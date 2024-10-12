import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/2_application/core/routes/route_name.dart';
import 'package:frontend/2_application/core/storage/secure_storage.dart';
import 'package:frontend/2_application/core/widgets/navigation_bar.dart';
import 'package:frontend/2_application/pages/active_todos/active_todos_page.dart';
import 'package:frontend/2_application/pages/all_todos/all_todos_page.dart';
import 'package:frontend/2_application/pages/completed_todos/completed_todos_page.dart';
import 'package:frontend/2_application/pages/login/login_page.dart';
import 'package:frontend/2_application/pages/register/register_page.dart';
import 'package:frontend/2_application/pages/todo_form/todo_form_page.dart';
import 'package:go_router/go_router.dart';

GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> _shellNavigatorAllTodosKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellNavigatorAllTodosKey');
GlobalKey<NavigatorState> _shellNavigatorActiveTodosKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellNavigatorActiveTodosKey');

GlobalKey<NavigatorState> _shellNavigatorCompletedTodosKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellNavigatorCompletedTodosKey');

Future<GoRouter> routerFactory(FlutterSecureStorage storage) async {
  final accessToken = await storage.read(key: SecureStorageKeys.accessToken);
  return GoRouter(
    initialLocation: accessToken?.isNotEmpty ?? false
        ? '/${TodoRouteName.allTodo}'
        : '/${TodoRouteName.login}',
    navigatorKey: _rootNavigatorKey,
    routes: [
      _login(),
      _register(),
      _todoForm(),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return TodoNavigationBar(navigationShell: navigationShell);
        },
        branches: [
          _allTodos(),
          _activeTodos(),
          _completedTodos(),
        ],
      ),
    ],
  );
}

GoRoute _login() {
  return GoRoute(
    path: '/${TodoRouteName.login}',
    name: TodoRouteName.login,
    pageBuilder: (context, state) => const NoTransitionPage(
      child: LoginPageWrapperProvider(),
    ),
  );
}

GoRoute _todoForm() {
  return GoRoute(
    path: '/${TodoRouteName.todoForm}/:action',
    name: TodoRouteName.todoForm,
    pageBuilder: (context, state) {
      return state.pathParameters['action'] == 'add'
          ? const NoTransitionPage(
              child: TodoFormPageWrapperProvider(isAddForm: true),
            )
          : const NoTransitionPage(
              child: TodoFormPageWrapperProvider(isAddForm: false),
            );
    },
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

StatefulShellBranch _allTodos() {
  return StatefulShellBranch(
    navigatorKey: _shellNavigatorAllTodosKey,
    routes: [
      GoRoute(
        path: '/${TodoRouteName.allTodo}',
        name: TodoRouteName.allTodo,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: AllTodosPageWrapperProvider(),
        ),
      ),
    ],
  );
}

StatefulShellBranch _activeTodos() {
  return StatefulShellBranch(
    navigatorKey: _shellNavigatorActiveTodosKey,
    routes: [
      GoRoute(
        path: '/${TodoRouteName.activeTodo}',
        name: TodoRouteName.activeTodo,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: ActiveTodosPage(),
        ),
      ),
    ],
  );
}

StatefulShellBranch _completedTodos() {
  return StatefulShellBranch(
    navigatorKey: _shellNavigatorCompletedTodosKey,
    routes: [
      GoRoute(
        path: '/${TodoRouteName.completedTodo}',
        name: TodoRouteName.completedTodo,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: CompletedTodosPage(),
        ),
      ),
    ],
  );
}
