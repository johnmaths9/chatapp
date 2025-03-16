import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../entities/chat_user_model.dart';

abstract class BaseUserService {
  /// Checks if the current user exists in Firestore.
  Future<bool> userExists();

  /// Searches for a user by phoneNumber and adds them as a chat user.
  Future<bool> addChatUser(String phoneNumber);

  /// Retrieves self information from Firestore.
  Future<void> getSelfInfo();

  /// Creates a new user in Firestore.
  Future<void> createUser();

  /// Updates the current user's info (name, about, etc).
  Future<void> updateUserInfo();

  /// Updates the user's profile picture.
  Future<void> updatephotoURLture(File file);
}

class FirebaseUserService extends BaseUserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // User data cache
  ChatUser? _currentUser;

  // Collection references
  CollectionReference get _usersCollection => _firestore.collection('users');
  CollectionReference get _chatUsersCollection =>
      _firestore.collection('chat_users');

  // Get current authenticated user
  User? get _currentAuthUser => _auth.currentUser;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMyUsers() {
    if (_currentAuthUser == null) {
      return const Stream.empty();
    }

    String currentUserId = _currentAuthUser!.uid;

    return _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('my_users') // Fetch from subcollection
        .snapshots();
  }

  @override
  Future<bool> userExists() async {
    if (_currentAuthUser == null) return false;

    try {
      DocumentSnapshot userDoc =
          await _usersCollection.doc(_currentAuthUser!.uid).get();
      return userDoc.exists;
    } catch (e) {
      print('Error checking if user exists: $e');
      return false;
    }
  }

  @override
  Future<bool> addChatUser(String phoneNumber) async {
    if (_currentAuthUser == null) return false;

    try {
      // Search for user by phoneNumber
      QuerySnapshot snapshot =
          await _usersCollection
              .where('phoneNumber', isEqualTo: phoneNumber)
              .limit(1)
              .get();

      if (snapshot.docs.isEmpty) return false;

      // Get the found user
      DocumentSnapshot userDoc = snapshot.docs.first;
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      // Check if this user is already in the current user's chat list
      DocumentSnapshot chatUserDoc =
          await _chatUsersCollection
              .doc(_currentAuthUser!.uid)
              .collection('users')
              .doc(userDoc.id)
              .get();

      if (chatUserDoc.exists) return true; // Already added

      // Add the user to current user's chat list
      await _chatUsersCollection
          .doc(_currentAuthUser!.uid)
          .collection('users')
          .doc(userDoc.id)
          .set({
            'uId': userDoc.id,
            'name': userData['name'],
            'phoneNumber': userData['phoneNumber'],
            'status': userData['status'] ?? '',
            'photoURL': userData['photoURL'] ?? '',
            'lastSeen': userData['lastSeen'] ?? DateTime.now(),
            'createdAt': DateTime.now(),
          });

      return true;
    } catch (e) {
      print('Error adding chat user: $e');
      return false;
    }
  }

  @override
  Future<void> getSelfInfo() async {
    if (_currentAuthUser == null) return;

    try {
      DocumentSnapshot userDoc =
          await _usersCollection.doc(_currentAuthUser!.uid).get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        _currentUser = ChatUser(
          id: _currentAuthUser!.uid,
          name: userData['name'] ?? '',
          photoUrl: userData['image'],
          lastActive: (userData['lastActive'] as Timestamp).toDate(),
          isOnline: true,
        );

        // Update last active status
        await _usersCollection.doc(_currentAuthUser!.uid).update({
          'lastActive': DateTime.now(),
          'isOnline': true,
        });
      }
    } catch (e) {
      print('Error getting self info: $e');
    }
  }

  @override
  Future<void> createUser() async {
    if (_currentAuthUser == null) return;

    try {
      // Check if user already exists
      bool exists = await userExists();
      if (exists) return;

      await _usersCollection.doc(_currentAuthUser!.uid).set({
        'uid': _currentAuthUser!.uid,
        'phoneNumber': _currentAuthUser!.phoneNumber,
        'name': _currentAuthUser!.displayName ?? 'User',
        'photoURL': _currentAuthUser!.photoURL ?? '',
        'about': 'Hey there! I am using the Chat App',
        'createdAt': DateTime.now(),
        'lastSeen': DateTime.now(),
        'isOnline': true,
      });

      _currentUser = ChatUser(
        id: _currentAuthUser!.uid,
        name: _currentAuthUser!.displayName ?? 'User',
        photoUrl: _currentAuthUser!.photoURL,
        lastActive: DateTime.now(),
        isOnline: true,
      );
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  @override
  Future<void> updateUserInfo({String? name, String? about}) async {
    if (_currentAuthUser == null) return;

    try {
      Map<String, dynamic> updateData = {};

      if (name != null && name.trim().isNotEmpty) {
        updateData['name'] = name;
      }

      if (about != null && about.trim().isNotEmpty) {
        updateData['about'] = about;
      }

      if (updateData.isNotEmpty) {
        await _usersCollection.doc(_currentAuthUser!.uid).update(updateData);

        // Update local cache if available
        if (_currentUser != null && name != null) {
          _currentUser = ChatUser(
            id: _currentUser!.id,
            name: name,
            photoUrl: _currentUser!.photoUrl,
            lastActive: _currentUser!.lastActive,
            isOnline: _currentUser!.isOnline,
          );
        }
      }
    } catch (e) {
      print('Error updating user info: $e');
    }
  }

  @override
  Future<void> updatephotoURLture(File file) async {
    if (_currentAuthUser == null) return;

    try {
      // Upload image to Firebase Storage
      String fileName =
          '${_currentAuthUser!.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = _storage.ref().child('profile_pictures/$fileName');

      UploadTask uploadTask = storageRef.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      // Update profile image URL in Firestore
      await _usersCollection.doc(_currentAuthUser!.uid).update({
        'image': imageUrl,
      });

      // Update local cache if available
      if (_currentUser != null) {
        _currentUser = ChatUser(
          id: _currentUser!.id,
          name: _currentUser!.name,
          photoUrl: imageUrl,
          lastActive: _currentUser!.lastActive,
          isOnline: _currentUser!.isOnline,
        );
      }

      // Update Firebase Auth user profile
      await _currentAuthUser!.updatePhotoURL(imageUrl);
    } catch (e) {
      print('Error updating profile picture: $e');
    }
  }

  // Additional useful methods

  /// Get current chat user
  ChatUser? getCurrentUser() {
    return _currentUser;
  }

  /// Stream of all chat users added by the current user
  Stream<List<ChatUser>> getChatUsers() {
    if (_currentAuthUser == null) {
      return Stream.value([]);
    }

    return _chatUsersCollection
        .doc(_currentAuthUser!.uid)
        .collection('users')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data();
            return ChatUser(
              id: data['uid'],
              name: data['name'],
              photoUrl: data['image'],
              lastActive: (data['lastActive'] as Timestamp).toDate(),
              isOnline: false, // Will be updated via presence system
            );
          }).toList();
        });
  }

  /// Set user online/offline status
  Future<void> setUserStatus(bool isOnline) async {
    if (_currentAuthUser == null) return;

    try {
      await _usersCollection.doc(_currentAuthUser!.uid).update({
        'isOnline': isOnline,
        'lastActive': DateTime.now(),
      });
    } catch (e) {
      print('Error setting user status: $e');
    }
  }

  /// Sign out user and update online status
  Future<void> signOut() async {
    if (_currentAuthUser == null) return;

    try {
      // Set user as offline
      await setUserStatus(false);

      // Sign out from Firebase Auth
      await _auth.signOut();

      // Clear cached user data
      _currentUser = null;
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
