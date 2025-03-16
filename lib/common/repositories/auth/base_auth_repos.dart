import 'dart:io';
import 'package:dartz/dartz.dart';

import '../../entities/user_model.dart';
import 'package:chatapp_2025/common/error/failure.dart';

abstract class BaseAuthRemoteDataSource {
  Future<Either<Failure, void>> signInWithPhoneNumber({required String phone});

  Future<Either<Failure, void>> verifyOtp({required String smsOtpCode});

  Future<Either<Failure, void>> saveUserDataToFirebase({
    required String name,
    File? photoURL,
  });

  Future<Either<Failure, String>> getCurrentUid();
  Future<Either<Failure, String>> getCachedLocalCurrentUid();

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, UserEntity>> getCurrentUser();
  Stream<UserEntity> getUserById(String uId);
  Future<Either<Failure, void>> setUserState(bool isOnline);
  Future<Either<Failure, void>> updatephotoURL(String path);
}
