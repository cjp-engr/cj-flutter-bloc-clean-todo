import 'package:frontend/0_data/datasources/user_remote_datasource.dart';
import 'package:frontend/0_data/repositories/user_repo_impl.dart';
import 'package:frontend/1_domain/repositories/user_repo.dart';
import 'package:frontend/1_domain/usecases/user_usecases.dart';
import 'package:frontend/2_application/pages/login/cubit/login_cubit.dart';
import 'package:frontend/2_application/pages/register/bloc/register_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I;

Future<void> init() async {
  //! application layer

  sl.registerFactory(() => LoginCubit(userUC: sl()));
  sl.registerFactory(() => RegisterBloc(userUC: sl()));

  // ! domain Layer
  sl.registerFactory(() => LoggedInUserUC(userRepo: sl()));
  sl.registerFactory(() => RegisterUserUC(userRepo: sl()));

  // ! data Layer
  sl.registerFactory<UserRepo>(() => UserRepoImpl(userRemoteDatasource: sl()));
  sl.registerFactory<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(fbAuth: sl()));

  // ! externs
  sl.registerFactory(() => FirebaseAuth.instance);
}
