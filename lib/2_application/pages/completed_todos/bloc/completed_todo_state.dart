// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'completed_todo_bloc.dart';

class CompletedTodoState extends Equatable {
  final BlocStatus status;
  final TodoEntity todo;
  final List<TodoEntity> todos;
  const CompletedTodoState({
    required this.status,
    required this.todo,
    required this.todos,
  });

  factory CompletedTodoState.initialState() {
    return const CompletedTodoState(
      status: BlocStatus.initial,
      todo: TodoEntity(
        title: '',
        description: '',
        isCompleted: false,
      ),
      todos: [],
    );
  }

  CompletedTodoState copyWith({
    BlocStatus? status,
    TodoEntity? todo,
    List<TodoEntity>? todos,
  }) {
    return CompletedTodoState(
      status: status ?? this.status,
      todo: todo ?? this.todo,
      todos: todos ?? this.todos,
    );
  }

  @override
  List<Object?> get props => [
        status,
        todo,
        todos,
      ];
}
