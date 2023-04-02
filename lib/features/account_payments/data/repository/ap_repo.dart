import 'package:aksat/core/error/failure.dart';
import 'package:aksat/core/utils/enums.dart';
import 'package:aksat/features/account_payments/domain/usecases/pay_uc.dart';
import 'package:aksat/features/account_payments/domain/usecases/search_for_bill_uc.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../add_new_contract/domain/entities/contract.dart';
import '../../domain/entities/ap.dart';
import '../../domain/repository/base_ap_repo.dart';
import '../../domain/usecases/choose_filters_uc.dart';
import '../../domain/usecases/get_contracts_list_uc.dart';
import '../../domain/usecases/search_uc.dart';
import '../../domain/usecases/get_ap_list_uc.dart';
import '../datasource/ap_remote_data_source.dart';

class ApRepo extends BaseApRepo {
  final BaseApRemoteDataSource baseApRemoteDataSource;

  ApRepo(this.baseApRemoteDataSource);

  @override
  Future<Either<Failure, List<Ap>>> getApList(
      GetApListParameters parameters) async {
    try {
      final result = await baseApRemoteDataSource.getApList(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
          ServerFailure(message: failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Contract>>> getContractsList(
      GetContractsListParameters parameters) async {
    try {
      final result = await baseApRemoteDataSource.getContractsList(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
          ServerFailure(message: failure.errorMessageModel.statusMessage));
    }
  }

  @override
  AksatStatus chooseFilters(ChooseFiltersParameters parameters) {
    return parameters.aksatStatus;
  }

  @override
  String acsSearch(SearchParameters parameters) {
    return parameters.text;
  }

  @override
  Future<Either<Failure, Ap>> pay(PayParameters parameters) async{
    try {
      final result = await baseApRemoteDataSource.pay(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
          ServerFailure(message: failure.errorMessageModel.statusMessage));
    }
  }

  @override
  String searchForBill(SearchForBillParameters parameters) {
    return parameters.text;
  }

}
