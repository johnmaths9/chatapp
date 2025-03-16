import 'dart:io';

import 'package:chatapp_2025/common/entities/user_model.dart';
import 'package:chatapp_2025/common/values/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

abstract class BaseAuthService {
  Future<void> signInWithPhoneNumber({required String phone});

  Future<void> verifyOtp({required String smsOtpCode});

  Future<void> saveUserDataToFirebase({required String name, File? photoURL});

  Future<String> getCurrentUid();

  Future<void> signOut();

  Future<UserModel> getCurrentUser();

  Stream<UserModel> getUserById(String uId);

  Future<void> setUserState(bool isOnline);
  Future<void> updatephotoURL(String path);
}

class AuthService extends BaseAuthService {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  String _verificationId = '';
  int? _resendToken;

  AuthService({
    required this.auth,
    required this.firestore,
    required this.firebaseStorage,
  });

  @override
  Future<String> getCurrentUid() async => auth.currentUser!.uid;

  @override
  Future<void> signOut() async => await auth.signOut();

  @override
  Future<void> signInWithPhoneNumber({required String phone}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (AuthCredential credential) async {
          await auth.signInWithCredential(credential);
          if (kDebugMode) {
            print("phone verified : Token ${credential.token}");
          }
        },
        verificationFailed: (e) {
          print('Verification Failed: ${e.message}');
          // Handle specific error codes
          if (e.code == 'invalid-phone-number') {
            print('Invalid phone number format');
          } else if (e.code == 'too-many-requests') {
            print('Too many requests, try again later');
          } else if (e.code == 'quota-exceeded') {
            print('SMS quota exceeded for the project');
          }
          throw Exception(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          _resendToken = resendToken;
          if (kDebugMode) {
            print("Code sent to $phone. Verification ID: $verificationId");
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          if (kDebugMode) {
            print("time out :$verificationId");
          }
        },
        timeout: const Duration(minutes: 2),
        forceResendingToken: _resendToken,
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error in phone verification: $e");
      }
      rethrow;
    }
  }

  @override
  Future<void> verifyOtp({required String smsOtpCode}) async {
    try {
      if (_verificationId.isEmpty) {
        throw Exception("Verification ID is empty. Please request OTP first.");
      }

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsOtpCode,
      );
      await auth.signInWithCredential(credential);
    } catch (e) {
      if (kDebugMode) {
        print("Error verifying OTP: $e");
      }
      rethrow;
    }
  }

  @override
  Future<void> saveUserDataToFirebase({
    required String name,
    File? photoURL,
  }) async {
    String uId = await getCurrentUid();

    String photoUrl = '';
    if (photoURL != null) {
      photoUrl = await _storeFileToFirebase('photoURL/$uId', photoURL);
    }

    var user = UserModel(
      name: name,
      uId: uId,
      status: AppConstant.heyThere,
      photoURL: photoUrl,
      phoneNumber: auth.currentUser!.phoneNumber!,
      isOnline: true,
      lastSeen: DateTime.now(),
    );
    var userDoc = await firestore.collection('users').doc(uId).get();
    if (userDoc.exists) {
      await firestore.collection('users').doc(uId).update(user.toMap());
    } else {
      await firestore.collection('users').doc(uId).set(user.toMap());
    }
  }

  Future<String> _storeFileToFirebase(String path, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(path).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _deleteFileFromFirebase(String path) async {
    return await firebaseStorage.refFromURL(path).delete();
  }

  @override
  Future<UserModel> getCurrentUser() async {
    var userData =
        await firestore.collection('users').doc(await getCurrentUid()).get();
    UserModel user = UserModel.fromMap(userData.data()!);
    return user;
  }

  @override
  Stream<UserModel> getUserById(String uId) {
    return firestore.collection('users').doc(uId).snapshots().map((event) {
      return UserModel.fromMap(event.data()!);
    });
  }

  @override
  Future<void> setUserState(bool isOnline) async {
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'isOnline': isOnline,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> updatephotoURL(String path) async {
    String uId = auth.currentUser!.uid;
    //firstly delete previous image
    var userData = await firestore.collection('users').doc(uId).get();
    UserModel user = UserModel.fromMap(userData.data()!);
    if (user.photoURL.isNotEmpty) {
      await _deleteFileFromFirebase(user.photoURL);
    }
    //then upload new image
    String photoUrl = await _storeFileToFirebase('photoURL/$uId', File(path));
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'photoURL': photoUrl,
    });
  }
}
