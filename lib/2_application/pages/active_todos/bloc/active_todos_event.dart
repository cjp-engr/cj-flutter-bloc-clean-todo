part of 'active_todos_bloc.dart';

sealed class ActiveTodosEvent extends Equatable {}

class CompleteTodoEvent extends ActiveTodosEvent {
  final TodoEntity todo;

  CompleteTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class ReadActiveTodosEvent extends ActiveTodosEvent {
  final List<TodoEntity> todos;
  ReadActiveTodosEvent({required this.todos});

  @override
  List<Object?> get props => [todos];
}
