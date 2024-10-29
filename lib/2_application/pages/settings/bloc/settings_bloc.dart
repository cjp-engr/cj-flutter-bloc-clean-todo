import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/1_domain/entities/user_entity.dart';
import 'package:frontend/1_domain/usecases/user_usecases.dart';
import 'package:frontend/2_application/core/extension/bloc_api_status.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UserDetailsUC userDetailsUC;
  SettingsBloc({
    required this.userDetailsUC,
  }) : super(SettingsState.initialState()) {
    on<ReadUserEvent>(_readUserDetails);
    on<UpdateUserEvent>(_updateUserDetails);
    on<LogOutUserEvent>(_logOutUser);

    add(ReadUserEvent());
  }

  Future<void> _readUserDetails(
    ReadUserEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    final failureOrSuccess = await userDetailsUC.call();
    failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(status: BlocStatus.error),
      ),
      (user) => emit(
        state.copyWith(status: BlocStatus.loaded, user: user),
      ),
    );
  }

  Future<void> _updateUserDetails(
    UpdateUserEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
  }

  Future<void> _logOutUser(
    LogOutUserEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
  }
}
