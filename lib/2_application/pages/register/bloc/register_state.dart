// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final BlocStatus status;
  final UserEntity user;

  const RegisterState({
    required this.status,
    required this.user,
  });

  factory RegisterState.initialState() {
    return const RegisterState(
      status: BlocStatus.initial,
      user: UserEntity(email: ''),
    );
  }

  @override
  List<Object?> get props => [status, user];

  RegisterState copyWith({
    BlocStatus? status,
    UserEntity? user,
  }) {
    return RegisterState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
