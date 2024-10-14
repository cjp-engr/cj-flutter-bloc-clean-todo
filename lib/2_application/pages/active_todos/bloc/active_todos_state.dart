// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'active_todos_bloc.dart';

class ActiveTodosState extends Equatable {
  final BlocStatus status;
  final TodoEntity todo;
  final List<TodoEntity> todos;
  const ActiveTodosState({
    required this.status,
    required this.todo,
    required this.todos,
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
    );
  }

  @override
  List<Object?> get props => [
        status,
        todo,
        todos,
      ];

  ActiveTodosState copyWith({
    BlocStatus? status,
    TodoEntity? todo,
    List<TodoEntity>? todos,
  }) {
    return ActiveTodosState(
      status: status ?? this.status,
      todo: todo ?? this.todo,
      todos: todos ?? this.todos,
    );
  }
}
