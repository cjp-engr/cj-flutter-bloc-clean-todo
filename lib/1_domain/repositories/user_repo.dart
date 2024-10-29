import 'package:dartz/dartz.dart';
import 'package:frontend/1_domain/entities/user_entity.dart';
import 'package:frontend/1_domain/failures/failures.dart';

abstract class UserRepo {
  Future<Either<Failure, UserEntity>> registerUserToDataSource(UserEntity user);

  Future<Either<Failure, String>> loggedInExistingUserFromDataSource(
      UserEntity user);

  Future<Either<Failure, UserEntity>> userDetailsFromDataSource();
}
