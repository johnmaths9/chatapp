import 'dart:io';

import '../../entities/chat_user_model.dart';
import '../../entities/message_model.dart';
import '../../service/chat_service.dart';

abstract class BaseChatRepository {
  Future<void> sendMessage(ChatUser chatUser, String msg, MessageType type);
  Stream<List<Message>> getMessages(ChatUser chatUser);
  Future<void> markMessageAsRead(Message message);
  Future<void> deleteMessage(Message message);
  Future<void> updateMessage(Message message, String updatedMsg);
  Future<void> sendImageMessage(ChatUser chatUser, File file);
}

class ChatRepository extends BaseChatRepository {
  final BaseChatService chatService;

  ChatRepository({required this.chatService});

  @override
  Future<void> sendMessage(
    ChatUser chatUser,
    String msg,
    MessageType type,
  ) async {
    await chatService.sendMessage(chatUser, msg, type);
  }

  @override
  Stream<List<Message>> getMessages(ChatUser chatUser) {
    return chatService.getAllMessages(chatUser);
  }

  @override
  Future<void> markMessageAsRead(Message message) async {
    await chatService.updateMessageReadStatus(message);
  }

  @override
  Future<void> deleteMessage(Message message) async {
    await chatService.deleteMessage(message);
  }

  @override
  Future<void> updateMessage(Message message, String updatedMsg) async {
    await chatService.updateMessage(message, updatedMsg);
  }

  @override
  Future<void> sendImageMessage(ChatUser chatUser, File file) async {
    await chatService.sendChatImage(chatUser, file);
  }
}
