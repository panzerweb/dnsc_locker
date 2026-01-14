import 'package:dio/dio.dart';
import 'package:dnsc_locker/core/services/token_service.dart';
import 'package:dnsc_locker/feature/auth/data/data_source/auth_remote_datasource.dart';
import 'package:dnsc_locker/feature/auth/data/data_source/auth_remote_datasourceimpl.dart';
import 'package:dnsc_locker/feature/auth/data/repository/auth_repositoryimpl.dart';
import 'package:dnsc_locker/feature/auth/domain/repo/auth_repository.dart';
import 'package:dnsc_locker/feature/auth/domain/usecases/login_use_case.dart';
import 'package:dnsc_locker/feature/auth/domain/usecases/logout_use_case.dart';
import 'package:dnsc_locker/feature/auth/domain/usecases/register_use_case.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

final API_URL = 'http://127.0.0.1:8000/';

void setupLocator() {
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: API_URL));
    // api_URL can be your servers URL e.g: 'http://localhost:7087/api/'
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add JWT token to request headers
          final token = await locator<TokenService>().getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
    return dio;
  });

  // Authentication
  locator.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(),
  );

  locator.registerLazySingleton<TokenService>(() => TokenService());

  locator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceimpl(locator<Dio>(), locator<TokenService>()),
  );
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryimpl(
      locator<AuthRemoteDatasource>(),
      locator<TokenService>(),
    ),
  );

  locator.registerLazySingleton(
    () => LoginUseCase(authRepo: locator<AuthRepository>()),
  );
  locator.registerLazySingleton(
    () => RegisterUseCase(authRepo: locator<AuthRepository>()),
  );
  locator.registerLazySingleton(() => LogoutUseCase(locator<AuthRepository>()));

  locator.registerFactory(
    () => AuthCubit(
      loginUseCase: locator(),
      registerUseCase: locator(),
      logoutUseCase: locator(),
    ),
  );
}
