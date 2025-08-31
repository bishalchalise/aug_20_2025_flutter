// features/auth/domain/usecases/user_login.dart

import 'package:aug_20_2025/core/errors/failures.dart';
import 'package:aug_20_2025/core/usecase/usecase.dart';
import 'package:aug_20_2025/core/entities/user_entity.dart';
import 'package:aug_20_2025/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements Usecase<UserEntity, SigninParams> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(
    SigninParams params,
  ) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SigninParams {
  final String email;
  final String password;
  SigninParams({required this.email, required this.password});
}
