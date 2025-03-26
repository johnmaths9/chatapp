part of 'userservice_bloc.dart';

abstract class UserserviceState extends Equatable {
  const UserserviceState();

  @override
  List<Object> get props => [];
}

class UserserviceInitial extends UserserviceState {}

class UserserviceLoading extends UserserviceState {}

class AddChatUserSuccess extends UserserviceState {}

class GetSelfInfoSuccess extends UserserviceState {}

class UserserviceError extends UserserviceState {
  final String message;

  const UserserviceError(this.message);

  @override
  List<Object> get props => [message];
}
