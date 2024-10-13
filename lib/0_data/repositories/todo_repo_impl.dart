import 'package:dartz/dartz.dart';
import 'package:frontend/0_data/datasources/todo_remote_datasource.dart';
import 'package:frontend/0_data/exceptions/exceptions.dart';
import 'package:frontend/1_domain/entities/todo_entity.dart';
import 'package:frontend/1_domain/failures/failures.dart';
import 'package:frontend/1_domain/repositories/todo_repo.dart';

class TodoRepoImpl implements TodoRepo {
  final TodoRemoteDatasource todoRemoteDatasource;

  TodoRepoImpl({required this.todoRemoteDatasource});
  @override
  Future<Either<Failure, TodoEntity>> addTodoToDataSource(
      TodoEntity todo) async {
    try {
      final result = await todoRemoteDatasource.addTodoToDatabase(todo);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> readTodosFromDataSource() async {
    try {
      final result = await todoRemoteDatasource.readTodosFromDatabase();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteTodoToDataSource(String id) async {
    try {
      await todoRemoteDatasource.deleteTodoToDatabase(id);
      return right(id);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, TodoEntity>> updateTodoToDataSource(
      TodoEntity todo) async {
    try {
      final result = await todoRemoteDatasource.updateTodoToDatabase(todo);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }
}
