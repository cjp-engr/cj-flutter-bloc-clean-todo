import 'package:dartz/dartz.dart';
import 'package:frontend/0_data/datasources/user_remote_datasource.dart';
import 'package:frontend/0_data/exceptions/exceptions.dart';
import 'package:frontend/1_domain/entities/user_entity.dart';
import 'package:frontend/1_domain/failures/failures.dart';
import 'package:frontend/1_domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UserRemoteDatasource userRemoteDatasource;

  UserRepoImpl({required this.userRemoteDatasource});

  @override
  Future<Either<Failure, UserEntity>> registerUserToDataSource(
      UserEntity user) async {
    try {
      final result =
          await userRemoteDatasource.registerUserInfoToDatabase(user);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loggedInExistingUserFromDataSource(
      UserEntity user) async {
    try {
      final result = await userRemoteDatasource.loggedInUserFromDatabase(user);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }
}
