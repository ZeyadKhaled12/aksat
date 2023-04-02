import 'package:aksat/core/error/failure.dart';
import 'package:aksat/core/usecase/base_use_case.dart';
import 'package:aksat/features/start/domain/entities/company.dart';
import 'package:aksat/features/start/domain/repository/base_start_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginUc extends BaseUseCase<Company, LoginParameters>{
  final BaseStartRepo baseAuthRepo;
  LoginUc(this.baseAuthRepo);

  @override
  Future<Either<Failure, Company>> call(LoginParameters parameters) async{
    return await baseAuthRepo.login(parameters);
  }


}


class LoginParameters extends Equatable {
  final String email;
  final String password;

  const LoginParameters({
    required this.email,
    required this.password
  });

  @override
  List<Object> get props => [email, password];

}