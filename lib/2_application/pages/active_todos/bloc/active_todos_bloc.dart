import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/1_domain/entities/todo_entity.dart';
import 'package:frontend/1_domain/usecases/todo_usecases.dart';
import 'package:frontend/2_application/core/extension/bloc_api_status.dart';

part 'active_todos_event.dart';
part 'active_todos_state.dart';

class ActiveTodosBloc extends Bloc<ActiveTodosEvent, ActiveTodosState> {
  final UpdateTodoUC updateTodoUC;
  final ReadTodosUC readTodosUC;
  ActiveTodosBloc({
    required this.updateTodoUC,
    required this.readTodosUC,
  }) : super(ActiveTodosState.initialState()) {
    on<CompleteTodoEvent>(_completeTodo);
    on<ReadActiveTodosEvent>(_readActiveTodos);
  }

  Future<void> _completeTodo(
    CompleteTodoEvent event,
    Emitter<ActiveTodosState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    final failureOrSuccess = await updateTodoUC.call(event.todo);

    failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(status: BlocStatus.error),
      ),
      (success) => emit(
        state.copyWith(status: BlocStatus.updated),
      ),
    );
  }

  Future<void> _readActiveTodos(
    ReadActiveTodosEvent event,
    Emitter<ActiveTodosState> emit,
  ) async {
    emit(state.copyWith(todos: event.todos, status: BlocStatus.success));
  }
}
