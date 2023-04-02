import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/entities/company.dart';
import '../../domain/usecases/login_uc.dart';
import '../../domain/usecases/sign_up_uc.dart';
import '../../domain/usecases/verified_email_uc.dart';

part 'start_event.dart';

part 'start_state.dart';

class StartBloc extends Bloc<StartEvent, StartState> {
  final LoginUc loginUc;
  final SignUpUc signUpUc;
  final VerifiedEmailUc verifiedEmailUc;

  StartBloc(this.loginUc, this.signUpUc, this.verifiedEmailUc)
      : super(const StartState()) {
    on<LoginEvent>(_login);
    on<SignUpEvent>(_signUp);
    on<VerifiedEmailEvent>(_verifiedEmail);
  }

  FutureOr<void> _login(LoginEvent event, Emitter<StartState> emit) async {
    emit(state.copyWith(state: RequestState.loading));
    final result = await loginUc.call(event.loginParameters);
    result.fold(
        (l) => emit(
            state.copyWith(state: RequestState.error, errorMessage: l.message)),
        (r) => emit(state.copyWith(company: r, state: RequestState.loaded)));
  }

  FutureOr<void> _signUp(SignUpEvent event, Emitter<StartState> emit) async {
    emit(state.copyWith(state: RequestState.loading));
    final result = await signUpUc.call(event.signUpParameters);
    result.fold(
        (l) => emit(
            state.copyWith(state: RequestState.error, errorMessage: l.message)),
        (r) => emit(state.copyWith(company: r, state: RequestState.loaded)));
  }

  FutureOr<void> _verifiedEmail(
      VerifiedEmailEvent event, Emitter<StartState> emit) async {
    emit(state.copyWith(state: RequestState.loading));
    final result = await verifiedEmailUc.call(event.verifiedEmailParameters);
    result.fold(
        (l) => emit(
            state.copyWith(state: RequestState.error, errorMessage: l.message)),
        (r) => emit(state.copyWith(company: r, state: RequestState.loaded)));
  }
}
