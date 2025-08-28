// features/auth/presentation/pages/signup_page.dart
import 'package:aug_20_2025/core/common/widgets/loader.dart';
import 'package:aug_20_2025/core/theme/app_pallete.dart';
import 'package:aug_20_2025/core/utils/show_snakbar.dart';
import 'package:aug_20_2025/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aug_20_2025/features/auth/presentation/widgets/auth_field.dart';
import 'package:aug_20_2025/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
    builder: (context) => const SignupPage(),
  );
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackbar(context, state.message);
            } else if (state is AuthSuccess) {
              showSnackbar(
                context,
                "Account created successfully! with name of : ${state.user.id.toString()}",
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Loader();
            }
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  AuthField(
                    hintText: "Name",
                    controller: nameController,
                  ),
                  SizedBox(height: 15),
                  AuthField(
                    hintText: "Email",
                    controller: emailController,
                  ),
                  SizedBox(height: 15),
                  AuthField(
                    hintText: "Password",
                    controller: passwordController,
                    isObscureText: true,
                  ),
                  SizedBox(height: 15),
                  AuthGradientButton(
                    buttonText: "Sign Up",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthSignUp(
                            email: emailController.text.trim(),
                            password: passwordController.text
                                .trim(),
                            name: nameController.text.trim(),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
