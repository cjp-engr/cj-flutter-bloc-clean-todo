// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

class LoginState extends Equatable {
  final BlocStatus status;
  final UserEntity user;

  const LoginState({
    required this.status,
    required this.user,
  });

  factory LoginState.initialState() {
    return const LoginState(
      status: BlocStatus.initial,
      user: UserEntity(email: ''),
    );
  }

  LoginState copyWith({
    BlocStatus? status,
    UserEntity? user,
  }) {
    return LoginState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, user];
}
