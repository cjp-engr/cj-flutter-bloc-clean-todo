import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'active_todos_event.dart';
part 'active_todos_state.dart';

class ActiveTodosBloc extends Bloc<ActiveTodosEvent, ActiveTodosState> {
  ActiveTodosBloc() : super(ActiveTodosInitial()) {
    on<ActiveTodosEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
