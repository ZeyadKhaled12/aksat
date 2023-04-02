part of 'anc_bloc.dart';

class AncState extends Equatable {
  final Contract contract;
  final RequestState state;
  final bool isNewContractAdded;
  final String errorMessage;

  const AncState(
      {this.contract =  const Contract(
          customerName: '',
          phoneNumber: '',
          productType: '',
          totalPrice: 0,
          extras: [],
          paidUpPrice: 0,
          valueOfKst: 0,
          kstSystem: 0,
          startDate: null),
      this.isNewContractAdded = false,
      this.state = RequestState.loaded,
      this.errorMessage = ''});

  AncState copyWith(
      {Contract? contract, bool? isNewContractAdded, RequestState? state, String? errorMessage}) {
    return AncState(
        contract: contract ?? this.contract,
        isNewContractAdded: isNewContractAdded?? this.isNewContractAdded,
        state: state ?? this.state,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object> get props => [contract, state, errorMessage, isNewContractAdded];
}
