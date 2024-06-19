// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

class LoginState extends Equatable {
  final BlocStatus status;
  final String email;
  final String password;

  const LoginState({
    required this.status,
    required this.email,
    required this.password,
  });

  factory LoginState.initialState() {
    return const LoginState(
      status: BlocStatus.initial,
      email: '',
      password: '',
    );
  }

  LoginState copyWith({
    BlocStatus? status,
    String? email,
    String? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        password,
      ];
}
