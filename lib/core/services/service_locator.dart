import 'package:dio/dio.dart';
import 'package:dnsc_locker/core/services/token_service.dart';
import 'package:dnsc_locker/feature/auth/data/data_source/auth_remote_datasource.dart';
import 'package:dnsc_locker/feature/auth/data/data_source/auth_remote_datasourceimpl.dart';
import 'package:dnsc_locker/feature/auth/data/repository/auth_repositoryimpl.dart';
import 'package:dnsc_locker/feature/auth/domain/repo/auth_repository.dart';
import 'package:dnsc_locker/feature/auth/domain/usecases/current_user_use_case.dart';
import 'package:dnsc_locker/feature/auth/domain/usecases/login_use_case.dart';
import 'package:dnsc_locker/feature/auth/domain/usecases/logout_use_case.dart';
import 'package:dnsc_locker/feature/auth/domain/usecases/register_use_case.dart';
import 'package:dnsc_locker/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:dnsc_locker/feature/lockers/data/data_sources/lockers_remote_data_source.dart';
import 'package:dnsc_locker/feature/lockers/data/data_sources/lockers_remote_data_source_impl.dart';
import 'package:dnsc_locker/feature/lockers/data/repositories/locker_repository_impl.dart';
import 'package:dnsc_locker/feature/lockers/domain/repository/locker_repository.dart';
import 'package:dnsc_locker/feature/lockers/domain/usecases/filter_lockers_use_case.dart';
import 'package:dnsc_locker/feature/lockers/domain/usecases/get_lockers_use_case.dart';
import 'package:dnsc_locker/feature/lockers/presentation/bloc/locker_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final GetIt locator = GetIt.instance;

// Recommended to load API url directly from .env itself
final API_URL = dotenv.get('DJANGO_API_URL', fallback: 'MISSING');

void setupLocator() {
  /* 
    Injecting DIO dependency, injects the token once to all
    instance. 

    Helpful to not call locator<TokenService>().getToken(); everytime.
  */
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
        onError: (error, handler) {
          print(
            'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}',
          );
          return handler.next(error);
        },
      ),
    );
    return dio;
  });

  /*
    Auth Registry:

    Registered services, data sources, repositories, use cases, and cubits
    for Authentication feature.

  */
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

  locator.registerLazySingleton(
    () => CurrentUserUseCase(authRepo: locator<AuthRepository>()),
  );

  locator.registerFactory(
    () => AuthCubit(
      loginUseCase: locator(),
      registerUseCase: locator(),
      logoutUseCase: locator(),
      currentUser: locator(),
    ),
  );

  /*
    [Other feature registry below]

    Lockers Registry
  */
  locator.registerLazySingleton<LockersRemoteDataSource>(
    () => LockersRemoteDataSourceImpl(locator<Dio>()),
  );
  locator.registerLazySingleton<LockerRepository>(
    () => LockerRepositoryImpl(locator<LockersRemoteDataSource>()),
  );
  locator.registerLazySingleton(
    () => GetLockersUseCase(locator<LockerRepository>()),
  );
  locator.registerLazySingleton(
    () => FilterLockersUseCase(locator<LockerRepository>()),
  );
  locator.registerFactory(
    () => LockerCubit(
      getLockersUseCase: locator(),
      filterLockersUseCase: locator(),
    ),
  );

  /*
    Locker Request Submission Registry
  */
}
