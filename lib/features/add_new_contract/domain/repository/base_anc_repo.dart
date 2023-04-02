import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/contract.dart';
import '../usecases/add_new_contract_uc.dart';
import '../usecases/update_anc_info_uc.dart';

abstract class BaseAncRepo {
  Contract updateAncInfo(UpdateAncInfoParameters parameters);

  Future<Either<Failure, Contract>> addNewContract(
      AddNewContractParameters parameters);
}
