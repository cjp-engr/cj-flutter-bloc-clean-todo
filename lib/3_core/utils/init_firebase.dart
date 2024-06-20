import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/firebase_options.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
