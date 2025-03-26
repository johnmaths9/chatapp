part of 'userservice_bloc.dart';

abstract class UserserviceEvent extends Equatable {
  const UserserviceEvent();

  @override
  List<Object> get props => [];
}

class AddChatUserEvent extends UserserviceEvent {
  final String phoneNumber;
  final String name;

  const AddChatUserEvent({required this.phoneNumber, required this.name});

  @override
  List<Object> get props => [phoneNumber, name];
}


class GetSelfInfoEvent extends UserserviceEvent {}
