import 'package:aksat/core/utils/enums.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../add_new_contract/domain/entities/contract.dart';
import '../entities/ap.dart';
import '../usecases/get_contracts_list_uc.dart';
import '../usecases/pay_uc.dart';
import '../usecases/search_for_bill_uc.dart';
import '../usecases/search_uc.dart';
import '../usecases/choose_filters_uc.dart';
import '../usecases/get_ap_list_uc.dart';

abstract class BaseApRepo {
  Future<Either<Failure, List<Ap>>> getApList(
      GetApListParameters parameters);

  Future<Either<Failure, List<Contract>>> getContractsList(
      GetContractsListParameters parameters);

  Future<Either<Failure, Ap>> pay(
      PayParameters parameters);

  AksatStatus chooseFilters(ChooseFiltersParameters parameters);
  String acsSearch(SearchParameters parameters);
  String searchForBill(SearchForBillParameters parameters);
}