import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/0_data/exceptions/exceptions.dart';
import 'package:frontend/0_data/models/login_model.dart';
import 'package:frontend/0_data/models/register_model.dart';
import 'package:frontend/1_domain/entities/user_entity.dart';
import 'package:frontend/2_application/core/storage/secure_storage.dart';

abstract class UserRemoteDatasource {
  Future<RegisterModel> registerUserInfoToDatabase(UserEntity user);
  Future<String> loggedInUserFromDatabase(UserEntity user);
  Future<LoginModel> userDetailsFromDatabase();
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final FirebaseAuth fbAuth;
  final FirebaseFirestore fbDatabase;
  final FlutterSecureStorage secureStorage;

  UserRemoteDatasourceImpl({
    required this.fbAuth,
    required this.fbDatabase,
    required this.secureStorage,
  });
  String get _userId => fbAuth.currentUser!.uid;
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
  Future<String> loggedInUserFromDatabase(UserEntity user) async {
    try {
      final userCredential = await fbAuth.signInWithEmailAndPassword(
          email: user.email, password: user.password!);
      final signedInUser = userCredential.user!;
      final accessToken = await signedInUser.getIdToken();

      await secureStorage.write(
          key: SecureStorageKeys.accessToken, value: accessToken);
      return signedInUser.uid;
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<LoginModel> userDetailsFromDatabase() async {
    try {
      final DocumentSnapshot userDoc =
          await _userCollection().doc(_userId).get();
      final data = userDoc.data() as Map<String, dynamic>?;

      return LoginModel(
        id: data!['id'],
        email: data['email'],
        fullName: data['fullName'],
        username: data['username'],
      );
    } catch (_) {
      throw ServerException();
    }
  }
}
