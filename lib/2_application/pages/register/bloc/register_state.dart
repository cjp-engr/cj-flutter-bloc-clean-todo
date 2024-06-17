// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final BlocStatus status;
  final String email;
  final String fullName;
  final String username;
  final String password;

  const RegisterState({
    required this.status,
    required this.email,
    required this.fullName,
    required this.username,
    required this.password,
  });

  factory RegisterState.initialState() {
    return const RegisterState(
      status: BlocStatus.initial,
      email: '',
      fullName: '',
      username: '',
      password: '',
    );
  }

  @override
  List<Object> get props => [
        status,
        email,
        fullName,
        username,
        password,
      ];

  RegisterState copyWith({
    BlocStatus? status,
    String? email,
    String? fullName,
    String? username,
    String? password,
  }) {
    return RegisterState(
      status: status ?? this.status,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
