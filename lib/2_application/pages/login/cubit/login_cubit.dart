import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/1_domain/entities/user_entity.dart';
import 'package:frontend/1_domain/usecases/user_usecases.dart';
import 'package:frontend/2_application/core/extension/bloc_api_status.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  // final LoggedInUserUC userUC = LoggedInUserUC();
  final LoggedInUserUC userUC;
  LoginCubit({required this.userUC}) : super(LoginState.initialState());

  void loggedInUser(
    String email,
    String password,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));

    final failureOrSuccess = await userUC.call(
      UserEntity(
        email: email,
        password: password,
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

  void isLoggedIn() {
    emit(state.copyWith(status: BlocStatus.success));
  }
}
