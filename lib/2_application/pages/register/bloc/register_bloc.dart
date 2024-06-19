import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/1_domain/entities/user_entity.dart';
import 'package:frontend/1_domain/usecases/user_usecases.dart';
import 'package:frontend/2_application/core/extension/bloc_api_status.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUserUC userUC;
  RegisterBloc({required this.userUC}) : super(RegisterState.initialState()) {
    on<UserRegisterSubmitEvent>(_registerUser);
  }

  Future<void> _registerUser(
    UserRegisterSubmitEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    final failureOrSuccess = await userUC.call(
      UserEntity(
        email: event.email,
        fullName: event.fullName,
        username: event.username,
        password: event.password,
      ),
    );

    failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(status: BlocStatus.error),
      ),
      (success) => emit(
        state.copyWith(status: BlocStatus.success),
      ),
    );
  }
}
