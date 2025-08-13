// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Taskzilla';

  @override
  String get registerSubHeader =>
      'Curabitur non elit ut libero tristique sodales. Mauris a lacus. Donec mattis semper leo.';

  @override
  String get registerLearnMore =>
      'Morbi vestibulum volutpat enim. Duis lobortis. In turpis. Donec at ante non massa id feugiat.';

  @override
  String get registerPolicy => 'Mauris eget neque at sem venenatis eleifend.';

  @override
  String get email => 'Email';

  @override
  String get fullName => 'Full Name';

  @override
  String get userName => 'Username';

  @override
  String get password => 'Password';

  @override
  String get signUp => 'Sign up';

  @override
  String get haveAnAccount => 'Have an account?';

  @override
  String get login => 'Log in';

  @override
  String get userNameOrEmail => 'Username or email';

  @override
  String get dontHaveAnAccount => 'Don\'t have an account?';
}
