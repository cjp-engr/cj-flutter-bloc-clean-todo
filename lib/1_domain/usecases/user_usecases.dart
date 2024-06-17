import 'package:dartz/dartz.dart';
import 'package:frontend/0_data/repositories/user_repo_impl.dart';
import 'package:frontend/1_domain/entities/user_entity.dart';
import 'package:frontend/1_domain/failures/failures.dart';
import 'package:frontend/1_domain/usecases/base_use_case/use_case.dart';

class RegisterUserUC implements UseCase<UserEntity, dynamic> {
  final userRepo = UserRepoImpl();

  @override
  Future<Either<Failure, dynamic>> call(UserEntity user) async {
    try {
      return await userRepo.registerUserToDataSource(user);
    } catch (e) {
      return Left(GeneralFailure());
    }
  }

  // Future<Either<Failure, UserEntity>> call(UserEntity user) async {
  //   return userRepo.registerUserToDataSource();
  // }
}
