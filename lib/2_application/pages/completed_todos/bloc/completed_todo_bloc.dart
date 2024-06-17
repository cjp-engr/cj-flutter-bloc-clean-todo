import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'completed_todo_event.dart';
part 'completed_todo_state.dart';

class CompletedTodoBloc extends Bloc<CompletedTodoEvent, CompletedTodoState> {
  CompletedTodoBloc() : super(CompletedTodoInitial()) {
    on<CompletedTodoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
