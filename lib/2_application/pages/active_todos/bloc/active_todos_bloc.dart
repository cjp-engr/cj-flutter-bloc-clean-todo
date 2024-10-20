import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/1_domain/entities/todo_entity.dart';
import 'package:frontend/1_domain/usecases/todo_usecases.dart';
import 'package:frontend/2_application/core/extension/bloc_api_status.dart';

part 'active_todos_event.dart';
part 'active_todos_state.dart';

class ActiveTodosBloc extends Bloc<ActiveTodosEvent, ActiveTodosState> {
  final UpdateTodoUC updateTodoUC;
  ActiveTodosBloc({
    required this.updateTodoUC,
  }) : super(ActiveTodosState.initialState()) {
    on<DoneTodoEvent>(_doneTodo);
    on<ReadActiveTodosEvent>(_readActiveTodos);
    on<SearchActiveTodoEvent>(_searchActiveTodos);
  }

  Future<void> _doneTodo(
    DoneTodoEvent event,
    Emitter<ActiveTodosState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    final failureOrSuccess = await updateTodoUC.call(event.todo);

    failureOrSuccess.fold(
      (failure) {
        emit(
          state.copyWith(status: BlocStatus.error),
        );
      },
      (doneTodo) {
        final todos = state.todos.map(
          (TodoEntity todo) {
            if (doneTodo.id == todo.id) {
              return TodoEntity(
                id: todo.id,
                title: doneTodo.title,
                description: doneTodo.description,
                isCompleted: doneTodo.isCompleted,
              );
            }
            return todo;
          },
        ).toList();
        emit(state.copyWith(
          status: BlocStatus.updated,
          todos: todos,
          filteredTodos: todos,
        ));
      },
    );
  }

  Future<void> _readActiveTodos(
    ReadActiveTodosEvent event,
    Emitter<ActiveTodosState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));

    final activeTodos =
        event.todos.where((todo) => todo.isCompleted == false).toList();
    emit(state.copyWith(
      todos: activeTodos,
      filteredTodos: activeTodos,
      status: BlocStatus.success,
    ));
  }

  Future<void> _searchActiveTodos(
    SearchActiveTodoEvent event,
    Emitter<ActiveTodosState> emit,
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
