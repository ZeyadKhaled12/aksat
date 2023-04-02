import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../entities/ap.dart';
import '../repository/base_ap_repo.dart';

class PayUc extends BaseUseCase<Ap, PayParameters> {
  final BaseApRepo baseAcsRepo;

  PayUc(this.baseAcsRepo);

  @override
  Future<Either<Failure, Ap>> call(PayParameters parameters) async {
    return await baseAcsRepo.pay(parameters);
  }
}

class PayParameters extends Equatable {
  final bool isKst;
  final String apToken;
  final int index;
  final String companyToken;

  const PayParameters(
      {required this.isKst, required this.companyToken, required this.apToken, required this.index});

  @override
  List<Object> get props => [isKst, apToken, companyToken, index];

}
