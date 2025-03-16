part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatSendTextMessage extends ChatEvent {
  final ChatUser recipient;
  final String message;

  ChatSendTextMessage({required this.recipient, required this.message});
}

class ChatSendImageMessage extends ChatEvent {
  final ChatUser recipient;
  final File imageFile;

  ChatSendImageMessage({required this.recipient, required this.imageFile});
}

class ChatMessagesUpdated extends ChatEvent {
  final List<Message> messages;

  ChatMessagesUpdated({required this.messages});
}

class ChatMarkMessageAsRead extends ChatEvent {
  final Message message;

  ChatMarkMessageAsRead({required this.message});
}

class ChatDeleteMessage extends ChatEvent {
  final Message message;

  ChatDeleteMessage({required this.message});
}

class ChatUpdateMessage extends ChatEvent {
  final Message message;
  final String updatedText;

  ChatUpdateMessage({required this.message, required this.updatedText});
}
