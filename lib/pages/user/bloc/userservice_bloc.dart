import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatapp_2025/common/repositories/auth/user_repos.dart';
import 'package:equatable/equatable.dart';

part 'userservice_event.dart';
part 'userservice_state.dart';

class UserserviceBloc extends Bloc<UserserviceEvent, UserserviceState> {
  final ContactsRepository contactsRepository;

  UserserviceBloc({required this.contactsRepository})
    : super(UserserviceInitial()) {
    on<AddChatUserEvent>(_onAddChatUser);
    on<GetSelfInfoEvent>(_onGetSelfInfo);
  }

  Future<void> _onAddChatUser(
    AddChatUserEvent event,
    Emitter<UserserviceState> emit,
  ) async {
    emit(UserserviceLoading());
    try {
      bool success = await contactsRepository.addChatUser(
        event.phoneNumber,
        event.name,
      );
      if (success) {
        emit(AddChatUserSuccess());
      } else {
        emit(UserserviceError("Failed to add chat user"));
      }
    } catch (e) {
      emit(UserserviceError(e.toString()));
    }
  }

  Future<void> _onGetSelfInfo(
    GetSelfInfoEvent event,
    Emitter<UserserviceState> emit,
  ) async {
    emit(UserserviceLoading());
    try {
      await contactsRepository.getSelfInfo();
      emit(GetSelfInfoSuccess());
    } catch (e) {
      emit(UserserviceError(e.toString()));
    }
  }
}
