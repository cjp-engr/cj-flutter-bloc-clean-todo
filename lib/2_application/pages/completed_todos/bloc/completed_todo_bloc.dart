import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'completed_todo_event.dart';
part 'completed_todo_state.dart';

class CompletedTodoBloc extends Bloc<CompletedTodoEvent, CompletedTodoState> {
  CompletedTodoBloc() : super(CompletedTodoInitial()) {
    on<CompletedTodoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
