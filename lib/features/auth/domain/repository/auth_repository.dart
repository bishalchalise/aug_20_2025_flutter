// features/auth/domain/repository/auth_repository.dart
import 'package:aug_20_2025/core/errors/failures.dart';
import 'package:aug_20_2025/core/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> currentUser();
  Future<Either<Failure, Unit>> signOut();
}
