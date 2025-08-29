// features/auth/presentation/bloc/auth_bloc.dart
import 'package:aug_20_2025/features/auth/domain/entities/user_entity.dart';
import 'package:aug_20_2025/features/auth/domain/usecases/user_login.dart';
import 'package:aug_20_2025/features/auth/domain/usecases/user_sign_up.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());

      final res = await _userSignUp(
        UserSignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );

      res.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      final res = await _userLogin(
        SigninParams(
          email: event.email,
          password: event.password,
        ),
      );
      res.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });
  }
}
