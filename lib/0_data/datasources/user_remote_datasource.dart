import 'package:frontend/0_data/models/user_model.dart';

abstract class UserRemoteDatasource {
  Future<UserModel> registerUserInfo();
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  @override
  Future<UserModel> registerUserInfo() {
    throw UnimplementedError();
  }
}
