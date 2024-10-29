part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {}

class ReadUserEvent extends SettingsEvent {
  ReadUserEvent();
  @override
  List<Object?> get props => [];
}

class UpdateUserEvent extends SettingsEvent {
  final UserEntity user;
  UpdateUserEvent({required this.user});
  @override
  List<Object?> get props => [user];
}

class LogOutUserEvent extends SettingsEvent {
  LogOutUserEvent();
  @override
  List<Object?> get props => [];
}
