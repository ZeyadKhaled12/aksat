import 'package:aksat/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../entities/company.dart';
import '../repository/base_start_repo.dart';

class VerifiedEmailUc extends BaseUseCase<Company, VerifiedEmailParameters> {
  final BaseStartRepo baseAuthRepo;
  VerifiedEmailUc(this.baseAuthRepo);

  @override
  Future<Either<Failure, Company>> call(VerifiedEmailParameters parameters) async{
   return await baseAuthRepo.verifiedEmail(parameters);
  }

}


class VerifiedEmailParameters extends Equatable {
  final String code;
  final Company company;

  const VerifiedEmailParameters({
    required this.code,
    required this.company});

  @override
  List<Object> get props => [code, company];

}