import 'package:dartz/dartz.dart';
import 'package:frontend/1_domain/failures/failures.dart';

abstract class UseCase<Params, T> {
  Future<Either<Failure, T>> call(Params params);
}

abstract class UseCaseNoParamsNoAsync<T> {
  Either<Failure, T> call();
}
