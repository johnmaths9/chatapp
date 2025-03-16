import 'dart:io';

import 'package:chatapp_2025/common/error/failure.dart';
import 'package:chatapp_2025/common/service/auth_service.dart';
import 'package:chatapp_2025/common/values/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../entities/user_model.dart';
import '../../service/storage_service.dart';

class AuthRepository extends BaseAuthService {
  final AuthService authService;
  final StorageService storageService;

  AuthRepository({required this.authService, required this.storageService});

  @override
  Future<Either<Failure, void>> signInWithPhoneNumber({
    required String phone,
  }) async {
    final result = await authService.signInWithPhoneNumber(phone: phone);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp({required String smsOtpCode}) async {
    final result = await authService.verifyOtp(smsOtpCode: smsOtpCode);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserDataToFirebase({
    required String name,
    File? photoURL,
  }) async {
    final result = await authService.saveUserDataToFirebase(
      name: name,
      photoURL: photoURL,
    );
    storageService.setString(
      AppConstant.Uid_User,
      await authService.getCurrentUid(),
    );
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    final result = await authService.signOut();
    //await storageService.remove(storageService.getUser()!);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> setUserState(bool isOnline) async {
    final result = await authService.setUserState(isOnline);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> updatephotoURL(String path) async {
    final result = await authService.updatephotoURL(path);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<String> getCurrentUid() {
    // TODO: implement getCurrentUid
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Stream<UserModel> getUserById(String uId) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }
}
