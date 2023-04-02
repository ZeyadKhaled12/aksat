
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../entities/ap.dart';
import '../repository/base_ap_repo.dart';

class GetApListUc extends BaseUseCase<List<Ap>, GetApListParameters> {
  final BaseApRepo baseAcsRepo;

  GetApListUc(this.baseAcsRepo);

  @override
  Future<Either<Failure, List<Ap>>> call(GetApListParameters parameters) async {
    return await baseAcsRepo.getApList(parameters);
  }
}

class GetApListParameters extends Equatable {
  final String companyToken;

  const GetApListParameters(
      {required this.companyToken});

  @override
  List<Object> get props => [companyToken];
}
