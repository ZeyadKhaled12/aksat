import 'package:aksat/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/base_use_case.dart';
import '../entities/company.dart';
import '../repository/base_start_repo.dart';

class SignUpUc extends BaseUseCase<Company, SignUpParameters> {
  final BaseStartRepo baseAuthRepo;

  SignUpUc(this.baseAuthRepo);

  @override
  Future<Either<Failure, Company>> call(SignUpParameters parameters) async {
    return await baseAuthRepo.signUp(parameters);
  }

}


class SignUpParameters extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final String compName;
  final String phoneNumber;

  const SignUpParameters({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.compName,
    required this.phoneNumber});

  @override
  List<Object> get props =>
      [email, password, confirmPassword, compName, phoneNumber,];


}