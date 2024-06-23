part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {}

class UserRegisterSubmitEvent extends RegisterEvent {
  final UserEntity user;

  UserRegisterSubmitEvent({
    required this.user,
  });
  @override
  List<Object?> get props => [
        user,
      ];
}
