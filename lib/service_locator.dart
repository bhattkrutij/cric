import 'package:cric/presentation/auth/bloc/signin_cubit.dart';
import 'package:cric/presentation/auth/bloc/signup_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/bloc/validation/validation_cubit.dart';
import 'core/network/dio_client.dart';
import 'data/auth/repositories/auth.dart';
import 'data/auth/sources/auth_api_service.dart';
import 'domain/auth/repositories/auth.dart';
import 'domain/auth/usecases/is_logged_in.dart';
import 'domain/auth/usecases/signin.dart';
import 'domain/auth/usecases/signup.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  //dio client
  sl.registerSingleton<DioClient>(DioClient());

  //cubits
  sl.registerFactory(() => ValidationCubit());
  sl.registerFactory(() => SignInCubit());
  sl.registerFactory(()=>SignUpCubit());

  // Services
  sl.registerSingleton<AuthService>(AuthApiServiceImpl());

  // Repostories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Usecases
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
}
