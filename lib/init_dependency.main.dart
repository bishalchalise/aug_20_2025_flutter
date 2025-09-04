// init_dependency.main.dart
part of 'init_dependency.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  Hive.defaultDirectory =
      (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(
    () => Hive.box(name: "blogs"),
  );

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
      () => BlogRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory<UploadBlog>(
      () => UploadBlog(serviceLocator()),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<GetBlog>(() => GetBlog(serviceLocator()))
    ..registerLazySingleton<BlogBloc>(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getBlog: serviceLocator(),
      ),
    );
}
