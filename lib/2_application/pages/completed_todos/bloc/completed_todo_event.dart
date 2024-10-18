part of 'completed_todo_bloc.dart';

sealed class CompletedTodoEvent extends Equatable {}

class ReadCompletedTodosEvent extends CompletedTodoEvent {
  final List<TodoEntity> todos;
  ReadCompletedTodosEvent({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class SearchCompletedTodoEvent extends CompletedTodoEvent {
  final String todo;
  SearchCompletedTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}
