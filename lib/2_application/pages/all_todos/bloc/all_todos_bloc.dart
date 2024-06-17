import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_todos_event.dart';
part 'all_todos_state.dart';

class AllTodosBloc extends Bloc<AllTodosEvent, AllTodosState> {
  AllTodosBloc() : super(AllTodosInitial()) {
    on<AllTodosEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
