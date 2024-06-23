part of 'all_todos_bloc.dart';

sealed class AllTodosEvent extends Equatable {}

class AddTodoEvent extends AllTodosEvent {
  final TodoEntity todo;

  AddTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class ReadTodosEvent extends AllTodosEvent {
  ReadTodosEvent();

  @override
  List<Object?> get props => [];
}
