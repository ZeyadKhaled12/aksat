import 'package:aksat/core/utils/enums.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/base_use_case.dart';
import '../../../add_new_contract/domain/entities/contract.dart';
import '../repository/base_ap_repo.dart';

class GetContractsListUc
    extends BaseUseCase<List<Contract>, GetContractsListParameters> {
  final BaseApRepo baseAcsRepo;

  GetContractsListUc(this.baseAcsRepo);

  @override
  Future<Either<Failure, List<Contract>>> call(
      GetContractsListParameters parameters) async {
    return await baseAcsRepo.getContractsList(parameters);
  }
}

class GetContractsListParameters extends Equatable {
  final String companyToken;
  final List<String> listContractToken;
  final List<AksatStatus> listAksatStatus;

  const GetContractsListParameters(
      {required this.companyToken,
      required this.listContractToken,
      required this.listAksatStatus});

  @override
  List<Object> get props => [companyToken, listContractToken, listAksatStatus];
}
