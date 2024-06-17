import 'package:equatable/equatable.dart';
import 'package:frontend/1_domain/entities/user_entity.dart';

class RegisterModel extends UserEntity with EquatableMixin {
  RegisterModel({
    required super.id,
    required super.email,
    required super.fullName,
    required super.username,
    required super.password,
  });

  //TODO: UserModel
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      id: json[''],
      email: json[''],
      fullName: json[''],
      username: json[''],
      password: json[''],
    );
  }
}
