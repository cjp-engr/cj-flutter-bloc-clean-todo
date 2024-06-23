// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'all_todos_bloc.dart';

class AllTodosState extends Equatable {
  final BlocStatus status;
  final TodoEntity todo;
  final List<TodoEntity> todos;
  const AllTodosState({
    required this.status,
    required this.todo,
    required this.todos,
  });

  factory AllTodosState.initialState() {
    return const AllTodosState(
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
  List<Object> get props => [status, todo, todos];

  AllTodosState copyWith({
    BlocStatus? status,
    TodoEntity? todo,
    List<TodoEntity>? todos,
  }) {
    return AllTodosState(
      status: status ?? this.status,
      todo: todo ?? this.todo,
      todos: todos ?? this.todos,
    );
  }
}
