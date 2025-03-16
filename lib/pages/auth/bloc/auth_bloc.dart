import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chatapp_2025/common/repositories/auth/auth_repos.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInWithPhoneNumber>(_signInWithPhoneNumber);
    on<VerifyOtp>(_verifyOtp);
    on<SaveUserDataToFirebase>(_saveUserDataToFirebase);
    on<SignOut>(_signOut);
    on<UpdatephotoURL>(_updatephotoURL);
  }

  FutureOr<void> _signInWithPhoneNumber(
    SignInWithPhoneNumber event,
    Emitter<AuthState> emit,
  ) async {
    print("Sign in with phone number");
    print(event.phone);
    emit(SignInLoadingState());
    final result = await authRepository.signInWithPhoneNumber(
      phone: event.phone,
    );
    result.fold((l) {
      emit(SignInErrorState());
    }, (r) => emit(SignInSuccessState()));
  }

  FutureOr<void> _verifyOtp(VerifyOtp event, Emitter<AuthState> emit) async {
    emit(VerifyOtpLoadingState());
    final result = await authRepository.verifyOtp(smsOtpCode: event.smsCode);
    result.fold(
      (l) => emit(VerifyOtpErrorState()),
      (r) => emit(VerifyOtpSuccessState()),
    );
  }

  FutureOr<void> _saveUserDataToFirebase(
    SaveUserDataToFirebase event,
    Emitter<AuthState> emit,
  ) async {
    emit(SaveUserDataToFirebaseLoadingState());
    final result = await authRepository.saveUserDataToFirebase(
      name: event.name,
      photoURL: event.photoURL,
    );
    result.fold(
      (l) => emit(SaveUserDataToFirebaseErrorState()),
      (r) => emit(SaveUserDataToFirebaseSuccessState()),
    );
  }

  FutureOr<void> _signOut(SignOut event, Emitter<AuthState> emit) {}

  FutureOr<void> _updatephotoURL(
    UpdatephotoURL event,
    Emitter<AuthState> emit,
  ) async {
    emit(UpdatephotoURLLoadingState());
    final result = await authRepository.updatephotoURL(event.path);
    result.fold(
      (l) => emit(UpdatephotoURLErrorState()),
      (r) => emit(UpdatephotoURLSuccessState()),
    );
  }
}
