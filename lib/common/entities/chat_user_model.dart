import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUser {
  final String id;
  final String name;
  final String? photoUrl;
  final DateTime lastActive;
  final bool isOnline;

  ChatUser({
    required this.id,
    required this.name,
    this.photoUrl,
    required this.lastActive,
    this.isOnline = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'lastActive': lastActive,
      'isOnline': isOnline,
    };
  }

  factory ChatUser.fromMap(Map<String, dynamic> map) {
    return ChatUser(
      id: map['id'],
      name: map['name'],
      photoUrl: map['photoUrl'],
      lastActive: (map['lastActive'] as Timestamp).toDate(),
      isOnline: map['isOnline'] ?? false,
    );
  }
}
