import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/1_domain/entities/todo_entity.dart';
import 'package:frontend/1_domain/usecases/todo_usecases.dart';
import 'package:frontend/2_application/core/extension/bloc_api_status.dart';

part 'all_todos_event.dart';
part 'all_todos_state.dart';

class AllTodosBloc extends Bloc<AllTodosEvent, AllTodosState> {
  final AddTodoUC addTodoUC;
  final ReadTodosUC readTodosUC;
  final UpdateTodoUC updateTodoUC;
  final DeleteTodoUC deleteTodoUC;
  AllTodosBloc({
    required this.addTodoUC,
    required this.readTodosUC,
    required this.updateTodoUC,
    required this.deleteTodoUC,
  }) : super(AllTodosState.initialState()) {
    on<AddTodoEvent>(_addTodo);
    on<ReadTodosEvent>(_readTodos);

    add(ReadTodosEvent());
  }

  Future<void> _addTodo(
    AddTodoEvent event,
    Emitter<AllTodosState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    final failureOrSuccess = await addTodoUC.call(event.todo);

    failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(status: BlocStatus.error),
      ),
      (success) => emit(
        state.copyWith(status: BlocStatus.success),
      ),
    );
  }

  Future<void> _readTodos(
    ReadTodosEvent event,
    Emitter<AllTodosState> emit,
  ) async {
    emit(
      state.copyWith(status: BlocStatus.loading),
    );
    final failureOrSuccess = await readTodosUC.call();

    failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(status: BlocStatus.error),
      ),
      (todos) => emit(
        state.copyWith(status: BlocStatus.success, todos: todos),
      ),
    );
  }
}
