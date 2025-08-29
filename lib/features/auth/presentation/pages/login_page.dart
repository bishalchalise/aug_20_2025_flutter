// features/auth/presentation/pages/login_page.dart
// features/auth/presentation/pages/signup_page.dart
import 'package:aug_20_2025/core/theme/app_pallete.dart';
import 'package:aug_20_2025/core/utils/show_snakbar.dart';
import 'package:aug_20_2025/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aug_20_2025/features/auth/presentation/pages/signup_page.dart';
import 'package:aug_20_2025/features/auth/presentation/widgets/auth_field.dart';
import 'package:aug_20_2025/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailCOntroller = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailCOntroller.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackbar(context, state.message);
            } else if (state is AuthSuccess) {
              showSnackbar(
                context,
                "Account Logged In successfully! with name of : ${state.user.id.toString()}",
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  AuthField(
                    hintText: "Email",
                    controller: emailCOntroller,
                  ),
                  SizedBox(height: 15),
                  AuthField(
                    hintText: "Password",
                    controller: passwordController,
                    isObscureText: true,
                  ),
                  SizedBox(height: 15),
                  AuthGradientButton(
                    buttonText: "Sign In",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthLogin(
                            email: emailCOntroller.text.trim(),
                            password: passwordController.text
                                .trim(),
                          ),
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) =>
                                const Scaffold(),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        SignupPage.route(),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
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
