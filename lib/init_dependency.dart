// init_dependency.dart

import 'package:aug_20_2025/core/secrets/app_secrets.dart';
import 'package:aug_20_2025/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:aug_20_2025/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:aug_20_2025/features/auth/domain/repository/auth_repository.dart';
import 'package:aug_20_2025/features/auth/domain/usecases/user_login.dart';
import 'package:aug_20_2025/features/auth/domain/usecases/user_sign_up.dart';
import 'package:aug_20_2025/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
  _initAuth();
}

void _initAuth() {
  serviceLocator.registerFactory<SupabaseAuthDatasource>(() {
    return SupabaseAuthDataSourceImpl(serviceLocator());
  });

  serviceLocator.registerFactory<AuthRepository>(() {
    return AuthRepositoryImpl(serviceLocator());
  });
  serviceLocator.registerFactory<UserSignUp>(() {
    return UserSignUp(serviceLocator());
  });
  serviceLocator.registerFactory<UserLogin>(() {
    return UserLogin(serviceLocator());
  });
  serviceLocator.registerLazySingleton<AuthBloc>(() {
    return AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
    );
  });
}
