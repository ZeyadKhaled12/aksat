
import 'package:aksat/features/start/domain/usecases/verified_email_uc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/company.dart';
import '../../domain/repository/base_start_repo.dart';
import '../../domain/usecases/login_uc.dart';
import '../../domain/usecases/sign_up_uc.dart';
import '../datasource/start_remote_data_source.dart';

class StartRepo extends BaseStartRepo {
  final BaseStartRemoteDataSource baseStartRemoteDataSource;

  StartRepo(this.baseStartRemoteDataSource);

  @override
  Future<Either<Failure, Company>> login(LoginParameters parameters) async {
    try {
      final result = await baseStartRemoteDataSource.login(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(message: failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Company>> signUp(SignUpParameters parameters) async{
    try {
      final result = await baseStartRemoteDataSource.signUp(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(message: failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Company>> verifiedEmail(VerifiedEmailParameters parameters) async{
    try {
      final result = await baseStartRemoteDataSource.verifiedEmail(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(message: failure.errorMessageModel.statusMessage));
    }
  }
}
