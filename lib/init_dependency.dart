// init_dependency.dart

import 'package:aug_20_2025/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:aug_20_2025/core/network/connection_checker.dart';
import 'package:aug_20_2025/core/secrets/app_secrets.dart';
import 'package:aug_20_2025/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:aug_20_2025/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:aug_20_2025/features/auth/domain/repository/auth_repository.dart';
import 'package:aug_20_2025/features/auth/domain/usecases/current_user.dart';
import 'package:aug_20_2025/features/auth/domain/usecases/user_log_out.dart';
import 'package:aug_20_2025/features/auth/domain/usecases/user_login.dart';
import 'package:aug_20_2025/features/auth/domain/usecases/user_sign_up.dart';
import 'package:aug_20_2025/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aug_20_2025/features/blog/data/datasources/blog_remote_data_sources.dart';
import 'package:aug_20_2025/features/blog/data/repository/blog_repository_impl.dart';
import 'package:aug_20_2025/features/blog/domain/repository/blog_repository.dart';
import 'package:aug_20_2025/features/blog/domain/usecases/get_blog.dart';
import 'package:aug_20_2025/features/blog/domain/usecases/upload_blog.dart';
import 'package:aug_20_2025/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(
    () => InternetConnection(),
  );

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
}

void _initAuth() {
  serviceLocator
    ..registerFactory<SupabaseAuthDatasource>(
      () => SupabaseAuthDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () =>
          AuthRepositoryImpl(serviceLocator(), serviceLocator()),
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

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(serviceLocator()),
    )
    ..registerFactory<UploadBlog>(
      () => UploadBlog(serviceLocator()),
    )
    ..registerFactory<GetBlog>(() => GetBlog(serviceLocator()))
    ..registerLazySingleton<BlogBloc>(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getBlog: serviceLocator(),
      ),
    );
}
