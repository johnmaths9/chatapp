part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInWithPhoneNumber extends AuthEvent {
  final String phone;

  SignInWithPhoneNumber({required this.phone});
  @override
  List<Object> get props => [phone];
}

class VerifyOtp extends AuthEvent {
  final String smsCode;

  VerifyOtp({required this.smsCode});
  @override
  List<Object> get props => [smsCode];
}

class SaveUserDataToFirebase extends AuthEvent {
  final String name;
  final File? photoURL;

  SaveUserDataToFirebase({required this.name, this.photoURL});

  @override
  List<Object> get props => [name, photoURL ?? ""];
}

class SignOut extends AuthEvent {
  const SignOut();
  @override
  List<Object> get props => [];
}

class UpdatephotoURL extends AuthEvent {
  final String path;

  UpdatephotoURL({required this.path});
  @override
  List<Object> get props => [path];
}
