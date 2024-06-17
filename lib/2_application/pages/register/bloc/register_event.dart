part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {}

class UserRegisterSubmitEvent extends RegisterEvent {
  final String email;
  final String fullName;
  final String username;
  final String password;

  UserRegisterSubmitEvent({
    required this.email,
    required this.fullName,
    required this.username,
    required this.password,
  });
  @override
  List<Object?> get props => [
        email,
        fullName,
        username,
        password,
      ];
}
