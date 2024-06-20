import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/main.dart';
import 'package:patrol/patrol.dart';
import 'package:frontend/injection.dart' as di;
import 'package:frontend/3_core/utils/init_firebase.dart' as init_fb;

void main() {
  patrolTest(
    'My test Taskzilla',
    ($) async {
      WidgetsFlutterBinding.ensureInitialized();
      await di.init();
      await init_fb.initializeFirebase();
      await $.pumpWidgetAndSettle(const MyApp());
      expect($('Taskzilla'), findsOneWidget);
      await $(#testEmail).enterText('c@c.com');
      await $(#testPassword).enterText('Test750!!');
      await $(#testButton).tap();
      expect($('All Todos'), findsOneWidget);
    },
  );
}
