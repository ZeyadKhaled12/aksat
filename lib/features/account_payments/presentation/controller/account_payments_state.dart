part of 'account_payments_bloc.dart';

class AccountStatementState extends Equatable {
  final List<Contract> listContracts;
  final List<Ap> listAp;
  final AksatStatus filtersAksatStatus;
  final String searchText;
  final String searchBillText;
  final RequestState state;
  final String errorMessage;

  const AccountStatementState(
      {this.listContracts = const [],
      this.searchText = '',
      this.searchBillText = '',
      this.filtersAksatStatus = AksatStatus.all,
      this.listAp = const [],
      this.state = RequestState.loaded,
      this.errorMessage = ''});

  AccountStatementState copyWith(
      {List<Contract>? listContracts,
      String? searchText,
      String? searchBillText,
      AksatStatus? filtersAksatStatus,
      List<Ap>? listAp,
      RequestState? state,
      String? errorMessage}) {
    return AccountStatementState(
        listAp: listAp ?? this.listAp,
        searchBillText: searchBillText ?? this.searchBillText,
        searchText: searchText ?? this.searchText,
        filtersAksatStatus: filtersAksatStatus ?? this.filtersAksatStatus,
        listContracts: listContracts ?? this.listContracts,
        state: state ?? this.state,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object> get props => [
        listContracts,
        listAp,
        searchBillText,
        state,
        errorMessage,
        filtersAksatStatus,
        searchText
      ];
}
