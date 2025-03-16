import 'dart:io';

import '../../service/user_service.dart';

abstract class BaseUserRepository {
  Future<bool> userExists();
  Future<bool> addChatUser(String phoneNumber);
  Future<void> getSelfInfo();
  Future<void> createUser();
  Future<void> updateUserInfo();
  Future<void> updatephotoURLture(File file);
}

class UserRepository extends BaseUserRepository {
  final FirebaseUserService userService;

  UserRepository({required this.userService});

  @override
  Future<bool> addChatUser(String phoneNumber) {
    return userService.addChatUser(phoneNumber);
  }

  @override
  Future<void> createUser() {
    return userService.createUser();
  }

  @override
  Future<void> getSelfInfo() {
    return userService.getSelfInfo();
  }

  @override
  Future<void> updateUserInfo() {
    return userService.updateUserInfo();
  }

  @override
  Future<void> updatephotoURLture(File file) {
    return userService.updatephotoURLture(file);
  }

  @override
  Future<bool> userExists() {
    return userService.userExists();
  }
}
