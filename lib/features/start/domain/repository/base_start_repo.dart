
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/company.dart';
import '../usecases/login_uc.dart';
import '../usecases/sign_up_uc.dart';
import '../usecases/verified_email_uc.dart';

abstract class BaseStartRepo{
  Future<Either<Failure, Company>> login(LoginParameters parameters);
  Future<Either<Failure, Company>> signUp(SignUpParameters parameters);
  Future<Either<Failure, Company>> verifiedEmail(VerifiedEmailParameters parameters);
}