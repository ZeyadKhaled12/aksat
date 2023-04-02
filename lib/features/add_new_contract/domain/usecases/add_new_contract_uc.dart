import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../entities/contract.dart';
import '../repository/base_anc_repo.dart';

class AddNewContractUc extends BaseUseCase<Contract, AddNewContractParameters> {
  final BaseAncRepo baseAuthRepo;

  AddNewContractUc(this.baseAuthRepo);

  @override
  Future<Either<Failure, Contract>> call(
      AddNewContractParameters parameters) async {
    return await baseAuthRepo.addNewContract(parameters);
  }
}

class AddNewContractParameters extends Equatable {
  final Contract contract;
  final String token;

  const AddNewContractParameters({required this.contract, required this.token});

  @override
  List<Object?> get props => [contract, token];
}
