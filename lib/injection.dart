import 'package:frontend/2_application/pages/login/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I;

Future<void> init() async {
  //! application layer

  sl.registerFactory(() => LoginCubit());
}
