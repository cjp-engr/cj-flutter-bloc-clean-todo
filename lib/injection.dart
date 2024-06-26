import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/0_data/datasources/todo_remote_datasource.dart';
import 'package:frontend/0_data/datasources/user_remote_datasource.dart';
import 'package:frontend/0_data/repositories/todo_repo_impl.dart';
import 'package:frontend/0_data/repositories/user_repo_impl.dart';
import 'package:frontend/1_domain/repositories/todo_repo.dart';
import 'package:frontend/1_domain/repositories/user_repo.dart';
import 'package:frontend/1_domain/usecases/todo_usecases.dart';
import 'package:frontend/1_domain/usecases/user_usecases.dart';
import 'package:frontend/2_application/pages/all_todos/bloc/all_todos_bloc.dart';
import 'package:frontend/2_application/pages/login/cubit/login_cubit.dart';
import 'package:frontend/2_application/pages/register/bloc/register_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I;

Future<void> init() async {
  //! application layer

  sl.registerFactory(() => LoginCubit(userUC: sl()));
  sl.registerFactory(() => RegisterBloc(userUC: sl()));
  sl.registerFactory(
    () => AllTodosBloc(
      addTodoUC: sl(),
      readTodosUC: sl(),
      updateTodoUC: sl(),
      deleteTodoUC: sl(),
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
}
