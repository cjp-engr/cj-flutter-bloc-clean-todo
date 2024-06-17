import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final fbAuth = FirebaseAuth.instance;
final fbUserId = fbAuth.currentUser!.uid;
final storageReference = FirebaseStorage.instance.ref();

final usersCollection = FirebaseFirestore.instance.collection('users');
