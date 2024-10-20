// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'active_todos_bloc.dart';

class ActiveTodosState extends Equatable {
  final BlocStatus status;
  final TodoEntity todo;
  final List<TodoEntity> todos;
  final List<TodoEntity> filteredTodos;
  const ActiveTodosState({
    required this.status,
    required this.todo,
    required this.todos,
    required this.filteredTodos,
  });

  factory ActiveTodosState.initialState() {
    return const ActiveTodosState(
      status: BlocStatus.initial,
      todo: TodoEntity(
        title: '',
        description: '',
        isCompleted: false,
      ),
      todos: [],
      filteredTodos: [],
    );
  }

  @override
  List<Object?> get props => [status, todo, todos, filteredTodos];

  ActiveTodosState copyWith({
    BlocStatus? status,
    TodoEntity? todo,
    List<TodoEntity>? todos,
    List<TodoEntity>? filteredTodos,
  }) {
    return ActiveTodosState(
      status: status ?? this.status,
      todo: todo ?? this.todo,
      todos: todos ?? this.todos,
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}
