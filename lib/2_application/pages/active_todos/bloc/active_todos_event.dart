part of 'active_todos_bloc.dart';

sealed class ActiveTodosEvent extends Equatable {}

class DoneTodoEvent extends ActiveTodosEvent {
  final TodoEntity todo;

  DoneTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class ReadActiveTodosEvent extends ActiveTodosEvent {
  final List<TodoEntity> todos;
  ReadActiveTodosEvent({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class SearchActiveTodoEvent extends ActiveTodosEvent {
  final String todo;
  SearchActiveTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}
