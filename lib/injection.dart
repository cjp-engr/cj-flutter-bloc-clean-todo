import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/0_data/datasources/todo_remote_datasource.dart';
import 'package:frontend/0_data/datasources/user_remote_datasource.dart';
import 'package:frontend/0_data/repositories/todo_repo_impl.dart';
import 'package:frontend/0_data/repositories/user_repo_impl.dart';
import 'package:frontend/1_domain/repositories/todo_repo.dart';
import 'package:frontend/1_domain/repositories/user_repo.dart';
import 'package:frontend/1_domain/usecases/todo_usecases.dart';
import 'package:frontend/1_domain/usecases/user_usecases.dart';
import 'package:frontend/2_application/core/routes/routes.dart';
import 'package:frontend/2_application/core/storage/shared_preferences.dart';
import 'package:frontend/2_application/core/storage/storage_interface.dart';
import 'package:frontend/2_application/pages/active_todos/bloc/active_todos_bloc.dart';
import 'package:frontend/2_application/pages/all_todos/bloc/all_todos_bloc.dart';
import 'package:frontend/2_application/pages/login/cubit/login_cubit.dart';
import 'package:frontend/2_application/pages/register/bloc/register_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.I;

Future<void> init() async {
  //! application layer

  sl.registerFactory(() => LoginCubit(
        userUC: sl(),
      ));
  sl.registerFactory(() => RegisterBloc(userUC: sl()));
  sl.registerFactory(
    () => AllTodosBloc(
      addTodoUC: sl(),
      readTodosUC: sl(),
      updateTodoUC: sl(),
      deleteTodoUC: sl(),
    ),
  );
  sl.registerFactory(
    () => ActiveTodosBloc(
      updateTodoUC: sl(),
      readTodosUC: sl(),
    ),
  );

  // ! domain Layer
  sl.registerFactory(() => LoggedInUserUC(userRepo: sl()));
  sl.registerFactory(() => RegisterUserUC(userRepo: sl()));

  sl.registerFactory(() => AddTodoUC(todoRepo: sl()));
  sl.registerFactory(() => ReadTodosUC(todoRepo: sl()));
  sl.registerFactory(() => UpdateTodoUC(todoRepo: sl()));
  sl.registerFactory(() => DeleteTodoUC(todoRepo: sl()));

  // ! data Layer
  sl.registerFactory<UserRepo>(() => UserRepoImpl(userRemoteDatasource: sl()));
  sl.registerFactory<UserRemoteDatasource>(
    () => UserRemoteDatasourceImpl(
      fbAuth: sl(),
      fbDatabase: sl(),
      secureStorage: sl(),
    ),
  );

  sl.registerFactory<TodoRepo>(() => TodoRepoImpl(todoRemoteDatasource: sl()));
  sl.registerFactory<TodoRemoteDatasource>(() => TodoRemoteDatasourceImpl(
        fbAuth: sl(),
        fbDatabase: sl(),
      ));

  // ! externs
  sl.registerFactory(() => FirebaseAuth.instance);
  sl.registerFactory(() => FirebaseFirestore.instance);
  sl.registerFactory(() => const FlutterSecureStorage());
  sl.registerFactory(() async => await SharedPreferences.getInstance());
  final SharedPreferences instance = await SharedPreferences.getInstance();
  sl.registerSingleton<AppStorage>(SharedPreferenceService(instance: instance));

  final GoRouter router = await routerFactory(sl());
  sl.registerSingleton(router);
}
