part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class SetCountrySuccessState extends AuthState {
  @override
  List<Object> get props => [];
}

class SignInLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class SignInSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}

class SignInErrorState extends AuthState {
  @override
  List<Object> get props => [];
}

class VerifyOtpLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class VerifyOtpSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}

class VerifyOtpErrorState extends AuthState {
  @override
  List<Object> get props => [];
}

class SaveUserDataToFirebaseLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class SaveUserDataToFirebaseSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}

class SaveUserDataToFirebaseErrorState extends AuthState {
  @override
  List<Object> get props => [];
}

class SignOutLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class SignOutSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}

class SignOutErrorState extends AuthState {
  @override
  List<Object> get props => [];
}

class GetCurrentLocalSuccessState extends AuthState {
  final String uId;

  const GetCurrentLocalSuccessState(this.uId);
  @override
  List<Object> get props => [uId];
}

class GetCurrentLocalErrorState extends AuthState {
  @override
  List<Object> get props => [];
}

class SetUserStateErrorState extends AuthState {
  @override
  List<Object> get props => [];
}

class SetUserStateSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}

/////get current user
class GetCurrentUserLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class GetCurrentUserErrorState extends AuthState {
  @override
  List<Object> get props => [];
}

class GetCurrentUserSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}

//update profile pic
class UpdatephotoURLLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class UpdatephotoURLErrorState extends AuthState {
  @override
  List<Object> get props => [];
}

class UpdatephotoURLSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}
