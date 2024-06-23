import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/0_data/exceptions/exceptions.dart';
import 'package:frontend/0_data/models/login_model.dart';
import 'package:frontend/0_data/models/register_model.dart';
import 'package:frontend/1_domain/entities/user_entity.dart';

abstract class UserRemoteDatasource {
  Future<RegisterModel> registerUserInfoToDatabase(UserEntity user);
  Future<LoginModel> loggedInUserFromDatabase(UserEntity user);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final FirebaseAuth fbAuth;
  final FirebaseFirestore fbDatabase;

  UserRemoteDatasourceImpl({
    required this.fbAuth,
    required this.fbDatabase,
  });

  CollectionReference<Map<String, dynamic>> _userCollection() =>
      fbDatabase.collection('users');

  @override
  Future<RegisterModel> registerUserInfoToDatabase(UserEntity user) async {
    try {
      final userCredential = await fbAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password!,
      );
      final signedInUser = userCredential.user!;

      await _userCollection().doc(signedInUser.uid).set({
        'id': signedInUser.uid,
        'email': user.email,
        'username': user.username,
        'fullName': user.fullName,
      });
      return RegisterModel(
        id: signedInUser.uid,
        email: user.email,
        fullName: user.username,
        username: user.fullName,
      );
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<LoginModel> loggedInUserFromDatabase(UserEntity user) async {
    try {
      final userCredential = await fbAuth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password!,
      );

      final signedInUser = userCredential.user!;
      final DocumentSnapshot userDoc =
          await _userCollection().doc(signedInUser.uid).get();
      final data = userDoc.data() as Map<String, dynamic>?;

      return LoginModel(
        id: signedInUser.uid,
        email: user.email,
        fullName: data!['fullName'],
        username: data['username'],
      );
    } catch (_) {
      throw ServerException();
    }
  }
}
