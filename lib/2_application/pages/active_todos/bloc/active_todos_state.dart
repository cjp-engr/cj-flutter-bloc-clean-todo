part of 'active_todos_bloc.dart';

sealed class ActiveTodosState extends Equatable {
  const ActiveTodosState();
  
  @override
  List<Object> get props => [];
}

final class ActiveTodosInitial extends ActiveTodosState {}
