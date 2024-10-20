part of 'completed_todo_bloc.dart';

sealed class CompletedTodoEvent extends Equatable {}

class ReadCompletedTodosEvent extends CompletedTodoEvent {
  final List<TodoEntity> todos;
  ReadCompletedTodosEvent({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class SearchCompletedTodoEvent extends CompletedTodoEvent {
  final String searchTodo;
  SearchCompletedTodoEvent({required this.searchTodo});

  @override
  List<Object?> get props => [searchTodo];
}
