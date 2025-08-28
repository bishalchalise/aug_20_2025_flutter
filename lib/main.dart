// main.dart

import 'package:aug_20_2025/core/theme/theme.dart';
import 'package:aug_20_2025/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aug_20_2025/features/auth/presentation/pages/login_page.dart';
import 'package:aug_20_2025/init_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependency();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: LoginPage(),
    );
  }
}
