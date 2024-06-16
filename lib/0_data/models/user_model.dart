import 'package:equatable/equatable.dart';
import 'package:frontend/1_domain/entities/user_entity.dart';

class UserModel extends UserEntity with EquatableMixin {
  UserModel({
    required super.id,
    required super.email,
    required super.fullName,
    required super.username,
    required super.password,
  });

  //TODO: UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[''],
      email: json[''],
      fullName: json[''],
      username: json[''],
      password: json[''],
    );
  }
}
