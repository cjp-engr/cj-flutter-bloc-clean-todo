import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/1_domain/entities/todo_entity.dart';
import 'package:frontend/2_application/core/extension/bloc_api_status.dart';

part 'completed_todo_event.dart';
part 'completed_todo_state.dart';

class CompletedTodoBloc extends Bloc<CompletedTodoEvent, CompletedTodoState> {
  CompletedTodoBloc() : super(CompletedTodoState.initialState()) {
    on<ReadCompletedTodosEvent>(_readCompletedTodos);
    on<SearchCompletedTodoEvent>(_searchCompletedTodos);
  }

  Future<void> _readCompletedTodos(
    ReadCompletedTodosEvent event,
    Emitter<CompletedTodoState> emit,
  ) async {
    final completedTodos =
        event.todos.where((todo) => todo.isCompleted == true).toList();
    emit(state.copyWith(
        todos: completedTodos,
        filteredTodos: completedTodos,
        status: BlocStatus.success));
  }

  Future<void> _searchCompletedTodos(
    SearchCompletedTodoEvent event,
    Emitter<CompletedTodoState> emit,
  ) async {
    List<TodoEntity> filteredTodos = [];
    emit(state.copyWith(status: BlocStatus.loading));
    filteredTodos = state.todos.where((todo) {
      return todo.title
              .toLowerCase()
              .contains(event.searchTodo.toLowerCase()) ||
          todo.description
              .toLowerCase()
              .contains(event.searchTodo.toLowerCase());
    }).toList();
    if (event.searchTodo.isEmpty) {
      emit(state.copyWith(
          status: BlocStatus.success, filteredTodos: state.todos));
    } else {
      emit(state.copyWith(
          status: BlocStatus.success, filteredTodos: filteredTodos));
    }
  }
}
