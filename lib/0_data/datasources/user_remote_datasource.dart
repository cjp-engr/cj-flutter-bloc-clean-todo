import 'package:frontend/0_data/exceptions/exceptions.dart';
import 'package:frontend/0_data/models/register_model.dart';
import 'package:frontend/1_domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:frontend/3_core/constants/firebase_constant.dart';

abstract class UserRemoteDatasource {
  Future<RegisterModel> registerUserInfoToDatabase(UserEntity user);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  fb_auth.User? get currentUser => fbAuth.currentUser;
  @override
  Future<RegisterModel> registerUserInfoToDatabase(UserEntity user) async {
    try {
      final userCredential = await fbAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      final signedInUser = userCredential.user!;

      await usersCollection.doc(signedInUser.uid).set({
        'email': user.email,
        'username': user.username,
        'fullName': user.fullName,
      });
      return RegisterModel(
        id: signedInUser.uid,
        email: user.email,
        fullName: user.username,
        username: user.fullName,
        password: 'Secret',
      );
    } catch (_) {
      throw ServerException();
    }
  }
}
