part of 'account_payments_bloc.dart';

abstract class AccountStatementEvent extends Equatable {
  const AccountStatementEvent();

  @override
  List<Object> get props => [];
}

class GetContractsListEvent extends AccountStatementEvent {
  final GetContractsListParameters getContractsListParameters;

  const GetContractsListEvent({required this.getContractsListParameters});

  @override
  List<Object> get props => [getContractsListParameters];
}

class GetApListEvent extends AccountStatementEvent {
  final GetApListParameters getApListParameters;

  const GetApListEvent({required this.getApListParameters});

  @override
  List<Object> get props => [getApListParameters];
}

class ChooseFilterEvent extends AccountStatementEvent {
  final ChooseFiltersParameters chooseFiltersParameters;

  const ChooseFilterEvent({required this.chooseFiltersParameters});

  @override
  List<Object> get props => [chooseFiltersParameters];
}


class AcsSearchEvent extends AccountStatementEvent {
  final SearchParameters acsSearchParameters;

  const AcsSearchEvent({required this.acsSearchParameters});

  @override
  List<Object> get props => [acsSearchParameters];
}
class SearchForBillEvent extends AccountStatementEvent {
  final SearchForBillParameters searchForBillParameters;

  const SearchForBillEvent({required this.searchForBillParameters});

  @override
  List<Object> get props => [searchForBillParameters];
}

class PayEvent extends AccountStatementEvent {
  final PayParameters payParameters;

  const PayEvent({required this.payParameters});

  @override
  List<Object> get props => [payParameters];
}

