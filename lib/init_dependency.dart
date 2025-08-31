// init_dependency.dart

import 'package:aug_20_2025/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:aug_20_2025/core/secrets/app_secrets.dart';
import 'package:aug_20_2025/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:aug_20_2025/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:aug_20_2025/features/auth/domain/repository/auth_repository.dart';
import 'package:aug_20_2025/features/auth/domain/usecases/current_user.dart';
import 'package:aug_20_2025/features/auth/domain/usecases/user_log_out.dart';
import 'package:aug_20_2025/features/auth/domain/usecases/user_login.dart';
import 'package:aug_20_2025/features/auth/domain/usecases/user_sign_up.dart';
import 'package:aug_20_2025/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<SupabaseAuthDatasource>(
      () => SupabaseAuthDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    ..registerFactory<UserSignUp>(
      () => UserSignUp(serviceLocator()),
    )
    ..registerFactory<UserLogin>(
      () => UserLogin(serviceLocator()),
    )
    ..registerFactory<CurrentUser>(
      () => CurrentUser(serviceLocator()),
    )
    ..registerFactory(() => UserLogOut(serviceLocator()))
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        currentUser: serviceLocator(),
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        logOut: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
