import 'package:equatable/equatable.dart';
import 'package:frontend/1_domain/entities/user_entity.dart';

class LoginModel extends UserEntity with EquatableMixin {
  LoginModel({
    required super.id,
    required super.email,
    required super.fullName,
    required super.username,
  });
}
