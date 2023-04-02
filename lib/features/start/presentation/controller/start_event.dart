part of 'start_bloc.dart';

abstract class StartEvent extends Equatable {
  const StartEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends StartEvent {
  final LoginParameters loginParameters;

  const LoginEvent({required this.loginParameters});

  @override
  List<Object> get props => [loginParameters];
}

class SignUpEvent extends StartEvent {
  final SignUpParameters signUpParameters;

  const SignUpEvent({required this.signUpParameters});

  @override
  List<Object> get props => [signUpParameters];
}

class VerifiedEmailEvent extends StartEvent {
  final VerifiedEmailParameters verifiedEmailParameters;

  const VerifiedEmailEvent({required this.verifiedEmailParameters});

  @override
  List<Object> get props => [verifiedEmailParameters];
}
