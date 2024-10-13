import 'package:dartz/dartz.dart';
import 'package:frontend/1_domain/entities/todo_entity.dart';
import 'package:frontend/1_domain/failures/failures.dart';
import 'package:frontend/1_domain/repositories/todo_repo.dart';
import 'package:frontend/1_domain/usecases/base_use_case/use_case.dart';

class ReadTodosUC implements UseCaseNoParams {
  final TodoRepo todoRepo;

  ReadTodosUC({required this.todoRepo});

  @override
  Future<Either<Failure, List<TodoEntity>>> call() async {
    try {
      return await todoRepo.readTodosFromDataSource();
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}

class AddTodoUC implements UseCase<TodoEntity, dynamic> {
  final TodoRepo todoRepo;

  AddTodoUC({required this.todoRepo});

  @override
  Future<Either<Failure, TodoEntity>> call(TodoEntity todo) async {
    try {
      return await todoRepo.addTodoToDataSource(todo);
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}

class UpdateTodoUC implements UseCase<TodoEntity, dynamic> {
  final TodoRepo todoRepo;

  UpdateTodoUC({required this.todoRepo});

  @override
  Future<Either<Failure, TodoEntity>> call(TodoEntity todo) async {
    try {
      return await todoRepo.updateTodoToDataSource(todo);
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}

class DeleteTodoUC implements UseCase<String, dynamic> {
  final TodoRepo todoRepo;

  DeleteTodoUC({required this.todoRepo});

  @override
  Future<Either<Failure, String>> call(String id) async {
    try {
      return await todoRepo.deleteTodoToDataSource(id);
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}
