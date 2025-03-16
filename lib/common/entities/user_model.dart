import 'package:equatable/equatable.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.uId,
    required super.status,
    required super.photoURL,
    required super.phoneNumber,
    required super.isOnline,
    required super.lastSeen,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'status': status,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'lastSeen': lastSeen.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uId: map['uId'] ?? '',
      status: map['status'] ?? '',
      photoURL: map['photoURL'] ?? '',
      phoneNumber: map['phoneNumber'],
      isOnline: map['isOnline'] ?? false,
      lastSeen: DateTime.fromMillisecondsSinceEpoch(map['lastSeen']),
    );
  }
}

class UserEntity extends Equatable {
  final String name;
  final String uId;
  final String status;
  final String photoURL;
  final String phoneNumber;
  final bool isOnline;
  final DateTime lastSeen;

  const UserEntity({
    required this.name,
    required this.uId,
    required this.status,
    required this.photoURL,
    required this.phoneNumber,
    required this.isOnline,
    required this.lastSeen,
  });

  @override
  List<Object?> get props => [
    name,
    uId,
    status,
    photoURL,
    phoneNumber,
    isOnline,
    lastSeen,
  ];
}
