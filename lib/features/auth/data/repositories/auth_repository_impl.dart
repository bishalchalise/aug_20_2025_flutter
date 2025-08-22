// features/auth/data/repositories/auth_repository_impl.dart
import 'package:aug_20_2025/core/errors/failures.dart';
import 'package:aug_20_2025/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, String>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) {
    // TODO: implement signUpWithEmailPassword
    throw UnimplementedError();
  }
}
