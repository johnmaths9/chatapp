import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/entities/chat_user_model.dart';
import '../../../common/entities/message_model.dart';
import '../../../common/repositories/auth/chat_repos.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  final ChatUser recipient;

  Stream<List<Message>>? _messagesStreamSubscription;

  ChatBloc({required this.chatRepository, required this.recipient})
    : super(ChatInitial()) {
    on<ChatSendTextMessage>(_onSendTextMessage);
    on<ChatSendImageMessage>(_onSendImageMessage);
    on<ChatMarkMessageAsRead>(_onMarkMessageAsRead);
    on<ChatDeleteMessage>(_onDeleteMessage);
    on<ChatUpdateMessage>(_onUpdateMessage);
    on<ChatMessagesUpdated>(_onMessagesUpdated);

    // Start listening to the messages stream.
    _messagesStreamSubscription = chatRepository.getMessages(recipient);
    _messagesStreamSubscription!.listen((messages) {
      add(ChatMessagesUpdated(messages: messages));
    });
  }

  Future<void> _onSendTextMessage(
    ChatSendTextMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await chatRepository.sendMessage(
        event.recipient,
        event.message,
        MessageType.text,
      );
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }

  Future<void> _onSendImageMessage(
    ChatSendImageMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await chatRepository.sendImageMessage(event.recipient, event.imageFile);
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }

  Future<void> _onMarkMessageAsRead(
    ChatMarkMessageAsRead event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await chatRepository.markMessageAsRead(event.message);
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }

  Future<void> _onDeleteMessage(
    ChatDeleteMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await chatRepository.deleteMessage(event.message);
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }

  Future<void> _onUpdateMessage(
    ChatUpdateMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await chatRepository.updateMessage(event.message, event.updatedText);
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }

  void _onMessagesUpdated(ChatMessagesUpdated event, Emitter<ChatState> emit) {
    emit(ChatLoaded(messages: event.messages));
  }

  @override
  Future<void> close() {
    // Cancel the messages stream if needed.
    return super.close();
  }
}
