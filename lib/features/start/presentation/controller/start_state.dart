part of 'start_bloc.dart';

class StartState extends Equatable {
  final Company company;
  final RequestState state;
  final String errorMessage;

  const StartState(
      {this.company =
          const Company(companyName: '', token: '', phoneNumber: '', email: '',
            isVerification: false),
      this.state = RequestState.loaded,
      this.errorMessage = ''});

  StartState copyWith({Company? company, RequestState? state, String? errorMessage}) {
    return StartState(
        company: company ?? this.company,
        state: state ?? this.state,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object> get props => [company, state, errorMessage];
}
