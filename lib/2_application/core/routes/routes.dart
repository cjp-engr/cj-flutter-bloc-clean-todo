import 'package:frontend/2_application/core/routes/route_name.dart';
import 'package:frontend/2_application/pages/login/login_page.dart';
import 'package:frontend/2_application/pages/register/register_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/${TodoRouteName.login}',
  routes: [
    _login(),
    _register(),
  ],
);

GoRoute _login() {
  return GoRoute(
    path: '/${TodoRouteName.login}',
    name: TodoRouteName.login,
    pageBuilder: (context, state) => const NoTransitionPage(
      child: LoginPageWrapperProvider(),
    ),
  );
}

GoRoute _register() {
  return GoRoute(
    path: '/${TodoRouteName.register}',
    name: TodoRouteName.register,
    pageBuilder: (context, state) => const NoTransitionPage(
      child: RegisterPageWrapperProvider(),
    ),
  );
}
