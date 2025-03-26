import 'dart:io';

import 'package:chatapp_2025/common/service/contacts_service.dart';

abstract class BaseContactsRepository {
  Future<bool> userExists();
  Future<bool> addChatUser(String phoneNumber, String name);
  Future<void> getSelfInfo();
  Future<void> createUser();
  Future<void> updateUserInfo();
  Future<void> updatephotoURLture(File file);
}

class ContactsRepository extends BaseContactsRepository {
  final FirebaseContactsService contactsService;

  ContactsRepository({required this.contactsService});

  @override
  Future<bool> addChatUser(String phoneNumber, String name) {
    return contactsService.addChatUser(phoneNumber, name);
  }

  @override
  Future<void> createUser() {
    return contactsService.createUser();
  }

  @override
  Future<void> getSelfInfo() {
    return contactsService.getSelfInfo();
  }

  @override
  Future<void> updateUserInfo() {
    return contactsService.updateUserInfo();
  }

  @override
  Future<void> updatephotoURLture(File file) {
    return contactsService.updatephotoURLture(file);
  }

  @override
  Future<bool> userExists() {
    return contactsService.userExists();
  }
}
