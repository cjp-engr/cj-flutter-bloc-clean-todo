import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/2_application/core/routes/route_name.dart';
import 'package:frontend/2_application/core/routes/router_observer.dart';
import 'package:frontend/2_application/core/storage/secure_storage.dart';
import 'package:frontend/2_application/core/widgets/navigation_bar.dart';
import 'package:frontend/2_application/pages/active_todos/active_todos_page.dart';
import 'package:frontend/2_application/pages/active_todos/bloc/active_todos_bloc.dart';
import 'package:frontend/2_application/pages/all_todos/all_todos_page.dart';
import 'package:frontend/2_application/pages/all_todos/bloc/all_todos_bloc.dart';
import 'package:frontend/2_application/pages/completed_todos/bloc/completed_todo_bloc.dart';
import 'package:frontend/2_application/pages/completed_todos/completed_todos_page.dart';
import 'package:frontend/2_application/pages/login/login_page.dart';
import 'package:frontend/2_application/pages/register/register_page.dart';
import 'package:frontend/2_application/pages/settings/settings_page.dart';
import 'package:frontend/2_application/pages/todo_form/todo_form_page.dart';
import 'package:frontend/injection.dart';
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
        ? TodoRouteName.allTodo.path
        : TodoRouteName.login.path,
    navigatorKey: _rootNavigatorKey,
    observers: [
      GoRouterObserver(),
    ],
    routes: [
      _login(),
      _register(),
      _todoForm(),
      _settings(),
      StatefulShellRoute.indexedStack(
        builder: (_, __, navigationShell) {
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
    path: TodoRouteName.login.path,
    name: TodoRouteName.login.name,
    pageBuilder: (context, state) => const NoTransitionPage(
      child: LoginPageWrapperProvider(),
    ),
  );
}

GoRoute _todoForm() {
  return GoRoute(
    path: '${TodoRouteName.todoForm.path}/:action/:index',
    name: TodoRouteName.todoForm.name,
    pageBuilder: (context, state) {
      return NoTransitionPage(
        child: BlocProvider(
          create: (context) => sl<AllTodosBloc>(),
          child: state.pathParameters['action'] == 'add'
              ? const TodoFormPage(isAddForm: true, index: -1)
              : TodoFormPage(
                  isAddForm: false,
                  index: int.tryParse(state.pathParameters['index']!)!,
                ),
        ),
      );
    },
  );
}

GoRoute _register() {
  return GoRoute(
    path: TodoRouteName.register.path,
    name: TodoRouteName.register.name,
    pageBuilder: (context, state) => const NoTransitionPage(
      child: RegisterPageWrapperProvider(),
    ),
  );
}

GoRoute _settings() {
  return GoRoute(
    path: TodoRouteName.settings.path,
    name: TodoRouteName.settings.name,
    pageBuilder: (context, state) => const NoTransitionPage(
      child: SettingsPage(),
    ),
  );
}

StatefulShellBranch _allTodos() {
  return StatefulShellBranch(
    navigatorKey: _shellNavigatorAllTodosKey,
    routes: [
      GoRoute(
        path: TodoRouteName.allTodo.path,
        name: TodoRouteName.allTodo.name,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: UniqueKey(),
            child: MultiBlocProvider(providers: [
              BlocProvider(create: (_) => sl<AllTodosBloc>()),
            ], child: const AllTodosPage()),
          );
        },
      ),
    ],
  );
}

StatefulShellBranch _activeTodos() {
  return StatefulShellBranch(
    navigatorKey: _shellNavigatorActiveTodosKey,
    routes: [
      GoRoute(
        path: TodoRouteName.activeTodo.path,
        name: TodoRouteName.activeTodo.name,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: UniqueKey(),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => sl<AllTodosBloc>()),
                BlocProvider(create: (_) => sl<ActiveTodosBloc>()),
              ],
              child: const ActiveTodosPage(),
            ),
          );
        },
      ),
    ],
  );
}

StatefulShellBranch _completedTodos() {
  return StatefulShellBranch(
    navigatorKey: _shellNavigatorCompletedTodosKey,
    routes: [
      GoRoute(
        path: TodoRouteName.completedTodo.path,
        name: TodoRouteName.completedTodo.name,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
              key: UniqueKey(),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => sl<AllTodosBloc>()),
                  BlocProvider(create: (_) => sl<CompletedTodoBloc>()),
                ],
                child: const CompletedTodosPage(),
              ));
        },
      ),
    ],
  );
}
