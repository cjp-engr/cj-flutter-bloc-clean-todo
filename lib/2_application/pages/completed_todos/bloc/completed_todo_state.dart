part of 'completed_todo_bloc.dart';

sealed class CompletedTodoState extends Equatable {
  const CompletedTodoState();
  
  @override
  List<Object> get props => [];
}

final class CompletedTodoInitial extends CompletedTodoState {}
