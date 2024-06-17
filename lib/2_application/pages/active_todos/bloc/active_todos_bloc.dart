import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'active_todos_event.dart';
part 'active_todos_state.dart';

class ActiveTodosBloc extends Bloc<ActiveTodosEvent, ActiveTodosState> {
  ActiveTodosBloc() : super(ActiveTodosInitial()) {
    on<ActiveTodosEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
