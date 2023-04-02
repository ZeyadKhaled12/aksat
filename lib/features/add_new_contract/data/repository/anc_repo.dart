import 'package:aksat/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../domain/entities/contract.dart';
import '../../domain/repository/base_anc_repo.dart';
import '../../domain/usecases/add_new_contract_uc.dart';
import '../../domain/usecases/update_anc_info_uc.dart';
import '../datasource/anc_local_data_source.dart';
import '../datasource/anc_remote_data_source.dart';

class AncRepo extends BaseAncRepo {
  final BaseAncLocalDataSource baseAncLocalDataSource;
  final BaseAncRemoteDataSource baseAncRemoteDataSource;

  AncRepo(this.baseAncLocalDataSource, this.baseAncRemoteDataSource);

  @override
  Contract updateAncInfo(UpdateAncInfoParameters parameters) {
    return baseAncLocalDataSource.updateAncInfo(parameters);
  }

  @override
  Future<Either<Failure, Contract>> addNewContract(
      AddNewContractParameters parameters) async {
    try {
      final result = await baseAncRemoteDataSource.addNewContract(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
          ServerFailure(message: failure.errorMessageModel.statusMessage));
    }
  }
}
