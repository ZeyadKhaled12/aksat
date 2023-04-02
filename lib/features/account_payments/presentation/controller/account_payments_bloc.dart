import 'dart:async';
import 'package:aksat/features/account_payments/domain/usecases/search_for_bill_uc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enums.dart';
import '../../../add_new_contract/domain/entities/contract.dart';
import '../../domain/entities/ap.dart';
import '../../domain/usecases/get_contracts_list_uc.dart';
import '../../domain/usecases/pay_uc.dart';
import '../../domain/usecases/search_uc.dart';
import '../../domain/usecases/choose_filters_uc.dart';
import '../../domain/usecases/get_ap_list_uc.dart';

part 'account_payments_event.dart';

part 'account_payments_state.dart';

class AccountStatementBloc
    extends Bloc<AccountStatementEvent, AccountStatementState> {
  final GetContractsListUc getContractsListUc;
  final GetApListUc getApListUc;
  final ChooseFiltersUc chooseFiltersUc;
  final SearchUc acsSearchUc;
  final SearchForBillUc searchForBillUc;
  final PayUc payUc;

  AccountStatementBloc(this.getContractsListUc, this.getApListUc,
      this.chooseFiltersUc, this.payUc, this.searchForBillUc, this.acsSearchUc)
      : super(const AccountStatementState()) {
    on<GetContractsListEvent>(_getContractList);
    on<GetApListEvent>(_getApList);
    on<ChooseFilterEvent>(_chooseFilter);
    on<SearchForBillEvent>(_searchForBill);
    on<PayEvent>(_pay);
    on<AcsSearchEvent>(_acsSearch);
  }

  FutureOr<void> _getContractList(
      GetContractsListEvent event, Emitter<AccountStatementState> emit) async {
    emit(state.copyWith(state: RequestState.loading));
    final result =
        await getContractsListUc.call(event.getContractsListParameters);
    result.fold(
        (l) => emit(
            state.copyWith(state: RequestState.error, errorMessage: l.message)),
        (r) =>
            emit(state.copyWith(listContracts: r, state: RequestState.loaded)));
  }

  FutureOr<void> _getApList(
      GetApListEvent event, Emitter<AccountStatementState> emit) async {
    emit(state.copyWith(state: RequestState.loading));
    final result = await getApListUc.call(event.getApListParameters);
    result.fold(
        (l) => emit(
            state.copyWith(state: RequestState.error, errorMessage: l.message)),
        (r) {
      emit(state.copyWith(listAp: r));
      List<String> listContractToken = [];
      List<AksatStatus> listAksatStatus = [];
      for (var element in r) {
        listContractToken.add(element.tokenOfContract);
      }
      bool isFinish = false;
      for (var element in r) {
        isFinish = false;
        for (var element in element.apTableAksat.rows) {
          if (element.aksatStatus == AksatStatus.late) {
            listAksatStatus.add(AksatStatus.late);
            isFinish = true;
            break;
          }
        }
        if(isFinish){
          continue;
        }
        for (var element in element.apTableAksat.rows) {
          if (element.aksatStatus == AksatStatus.close) {
            listAksatStatus.add(AksatStatus.close);
            isFinish = true;
            break;
          }
        }
        if(isFinish){
          continue;
        }
        for (var element in element.apTablePayments.rows) {
          if (element.aksatStatus == AksatStatus.late) {
            listAksatStatus.add(AksatStatus.late);
            isFinish = true;
            break;
          }
        }
        if(isFinish){
          continue;
        }
        for (var element in element.apTablePayments.rows) {
          if (element.aksatStatus == AksatStatus.close) {
            listAksatStatus.add(AksatStatus.close);
            isFinish = true;
            break;
          }
        }
        listAksatStatus.add(AksatStatus.done);
      }
      add(GetContractsListEvent(
          getContractsListParameters: GetContractsListParameters(
              listContractToken: listContractToken,
              listAksatStatus: listAksatStatus,
              companyToken: event.getApListParameters.companyToken)));
    });
  }

  FutureOr<void> _chooseFilter(
      ChooseFilterEvent event, Emitter<AccountStatementState> emit) {
    emit(state.copyWith(state: RequestState.loading));
    final result = chooseFiltersUc.change(event.chooseFiltersParameters);
    emit(
        state.copyWith(filtersAksatStatus: result, state: RequestState.loaded));
  }

  FutureOr<void> _acsSearch(
      AcsSearchEvent event, Emitter<AccountStatementState> emit) {
    emit(state.copyWith(state: RequestState.loading));
    final result = acsSearchUc.change(event.acsSearchParameters);
    emit(state.copyWith(searchText: result, state: RequestState.loaded));
  }

  FutureOr<void> _pay(
      PayEvent event, Emitter<AccountStatementState> emit) async {
    emit(state.copyWith(state: RequestState.loading));
    final List<Ap> listAp = List.from(state.listAp);
    final result = await payUc.call(event.payParameters);
    result.fold(
        (l) => emit(
            state.copyWith(state: RequestState.error, errorMessage: l.message)),
        (r) {
      for (int i = 0; i < listAp.length; i++) {
        if (listAp[i].tokenOfAp == event.payParameters.apToken) {
          listAp[i] = r;
          break;
        }
      }
      emit(state.copyWith(state: RequestState.loaded, listAp: listAp));
    });
  }

  FutureOr<void> _searchForBill(SearchForBillEvent event, Emitter<AccountStatementState> emit) {
    emit(state.copyWith(state: RequestState.loading));
    final result = searchForBillUc.change(event.searchForBillParameters);
    emit(state.copyWith(searchBillText: result, state: RequestState.loaded));
  }
}
