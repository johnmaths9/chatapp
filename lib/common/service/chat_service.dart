import 'dart:io';
import 'dart:math';

import 'package:chatapp_2025/common/entities/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../entities/chat_user_model.dart';

abstract class BaseChatService {
  /// Sends a text or image message.
  Future<void> sendMessage(ChatUser chatUser, String msg, MessageType type);

  /// Returns a stream of messages for a specific conversation.
  Stream<List<Message>> getAllMessages(ChatUser chatUser);

  /// Updates the read status of a message.
  Future<void> updateMessageReadStatus(Message message);

  /// Deletes a message.
  Future<void> deleteMessage(Message message);

  /// Updates a previously sent message.
  Future<void> updateMessage(Message message, String updatedMsg);

  /// Sends a chat image.
  Future<void> sendChatImage(ChatUser chatUser, File file);
}

class FirebaseChatService implements BaseChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Collection references
  CollectionReference get _messagesCollection =>
      _firestore.collection('messages');
  CollectionReference get _usersCollection => _firestore.collection('users');

  // Helper method to get conversation ID
  String _getConversationId(String userId1, String userId2) {
    // Sort IDs to ensure consistent conversation ID regardless of sender/receiver
    List<String> sortedIds = [userId1, userId2]..sort();
    return "${sortedIds[0]}_${sortedIds[1]}";
  }

  // METHOD 1: Using Firestore auto-generated IDs
  Future<void> sendMessageUsingFirestoreIds(
    ChatUser chatUser,
    String msg,
    MessageType type,
  ) async {
    String currentUserId = _getCurrentUserId();
    String conversationId = _getConversationId(currentUserId, chatUser.id);

    // Create a reference with auto-generated ID
    DocumentReference messageRef =
        _messagesCollection.doc(conversationId).collection('messages').doc();

    Message message = Message(
      id: messageRef.id,
      senderId: currentUserId,
      receiverId: chatUser.id,
      content: msg,
      type: type,
      timestamp: DateTime.now(),
      isRead: false,
    );

    await messageRef.set(message.toMap());
    await _updateLastMessage(conversationId, message);
  }

  // METHOD 2: Using timestamp-based IDs
  String _generateTimestampId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  // METHOD 3: Custom alphanumeric ID generator
  String _generateRandomId([int length = 20]) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  // METHOD 4: Timestamp + random suffix
  String _generateTimestampWithRandomSuffix() {
    return '${DateTime.now().millisecondsSinceEpoch}_${_generateRandomId(8)}';
  }

  @override
  Future<void> sendMessage(
    ChatUser chatUser,
    String msg,
    MessageType type,
  ) async {
    String currentUserId = _getCurrentUserId();
    String conversationId = _getConversationId(currentUserId, chatUser.id);

    // Choose one of the ID generation methods
    String messageId = _generateTimestampWithRandomSuffix();

    Message message = Message(
      id: messageId,
      senderId: currentUserId,
      receiverId: chatUser.id,
      content: msg,
      type: type,
      timestamp: DateTime.now(),
      isRead: false,
    );

    await _messagesCollection
        .doc(conversationId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());

    await _updateLastMessage(conversationId, message);
  }

  // Helper to update last message reference for conversation
  Future<void> _updateLastMessage(
    String conversationId,
    Message message,
  ) async {
    await _firestore.collection('conversations').doc(conversationId).set({
      'lastMessage': message.content,
      'lastMessageTime': message.timestamp,
      'participants': [message.senderId, message.receiverId],
    });
  }

  @override
  Stream<List<Message>> getAllMessages(ChatUser chatUser) {
    String currentUserId = _getCurrentUserId();
    String conversationId = _getConversationId(currentUserId, chatUser.id);

    return _messagesCollection
        .doc(conversationId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Message.fromMap(doc.data() as Map<String, dynamic>))
              .toList();
        });
  }

  @override
  Future<void> updateMessageReadStatus(Message message) async {
    String conversationId = _getConversationId(
      message.senderId,
      message.receiverId,
    );

    await _messagesCollection
        .doc(conversationId)
        .collection('messages')
        .doc(message.id)
        .update({'isRead': true});
  }

  @override
  Future<void> deleteMessage(Message message) async {
    String conversationId = _getConversationId(
      message.senderId,
      message.receiverId,
    );

    await _messagesCollection
        .doc(conversationId)
        .collection('messages')
        .doc(message.id)
        .delete();
  }

  @override
  Future<void> updateMessage(Message message, String updatedMsg) async {
    String conversationId = _getConversationId(
      message.senderId,
      message.receiverId,
    );

    await _messagesCollection
        .doc(conversationId)
        .collection('messages')
        .doc(message.id)
        .update({'content': updatedMsg});
  }

  @override
  Future<void> sendChatImage(ChatUser chatUser, File file) async {
    String currentUserId = _getCurrentUserId();
    String conversationId = _getConversationId(currentUserId, chatUser.id);

    // Using one of the ID generation methods
    String messageId = _generateTimestampWithRandomSuffix();

    // Upload image to Firebase Storage
    String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    Reference storageRef = _storage.ref().child(
      'chat_images/$conversationId/$fileName',
    );

    UploadTask uploadTask = storageRef.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();

    // Create message with image URL
    Message message = Message(
      id: messageId,
      senderId: currentUserId,
      receiverId: chatUser.id,
      content: imageUrl,
      type: MessageType.image,
      timestamp: DateTime.now(),
    );

    await _messagesCollection
        .doc(conversationId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());

    await _updateLastMessage(conversationId, message);
  }

  // Helper method to get current user ID from Firebase Auth
  String _getCurrentUserId() {
    // Mock implementation - replace with actual auth call
    return 'current_user_id';
  }

  Stream<List<ChatUser>> getRecentChats() {
    String currentUserId = _getCurrentUserId();

    return _firestore
        .collection('conversations')
        .where('participants', arrayContains: currentUserId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
          List<ChatUser> users = [];

          for (var doc in snapshot.docs) {
            List<dynamic> participants = doc['participants'];
            String otherUserId =
                participants[0] == currentUserId
                    ? participants[1]
                    : participants[0];

            DocumentSnapshot userDoc =
                await _usersCollection.doc(otherUserId).get();
            if (userDoc.exists) {
              users.add(
                ChatUser.fromMap(userDoc.data() as Map<String, dynamic>),
              );
            }
          }

          return users;
        });
  }

  Stream<int> getUnreadMessageCount(ChatUser chatUser) {
    String currentUserId = _getCurrentUserId();
    String conversationId = _getConversationId(currentUserId, chatUser.id);

    return _messagesCollection
        .doc(conversationId)
        .collection('messages')
        .where('receiverId', isEqualTo: currentUserId)
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }
}
