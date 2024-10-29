// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final UserEntity user;
  final BlocStatus status;
  const SettingsState({
    required this.user,
    required this.status,
  });

  factory SettingsState.initialState() {
    return const SettingsState(
      status: BlocStatus.initial,
      user: UserEntity(email: ''),
    );
  }

  SettingsState copyWith({
    UserEntity? user,
    BlocStatus? status,
  }) {
    return SettingsState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [user];
}
