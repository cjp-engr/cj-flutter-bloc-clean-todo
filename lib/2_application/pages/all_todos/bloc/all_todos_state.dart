part of 'all_todos_bloc.dart';

sealed class AllTodosState extends Equatable {
  const AllTodosState();
  
  @override
  List<Object> get props => [];
}

final class AllTodosInitial extends AllTodosState {}
