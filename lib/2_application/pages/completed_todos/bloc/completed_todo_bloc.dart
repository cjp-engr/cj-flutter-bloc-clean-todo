import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/1_domain/entities/todo_entity.dart';
import 'package:frontend/2_application/core/extension/bloc_api_status.dart';

part 'completed_todo_event.dart';
part 'completed_todo_state.dart';

class CompletedTodoBloc extends Bloc<CompletedTodoEvent, CompletedTodoState> {
  CompletedTodoBloc() : super(CompletedTodoState.initialState()) {
    on<ReadCompletedTodosEvent>(_readCompletedTodos);
  }

  Future<void> _readCompletedTodos(
    ReadCompletedTodosEvent event,
    Emitter<CompletedTodoState> emit,
  ) async {
    final activeTodos =
        event.todos.where((todo) => todo.isCompleted == true).toList();
    emit(state.copyWith(todos: activeTodos, status: BlocStatus.success));
  }
}
