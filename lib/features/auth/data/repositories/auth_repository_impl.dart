// features/auth/data/repositories/auth_repository_impl.dart
import 'package:aug_20_2025/core/errors/exceptions.dart';
import 'package:aug_20_2025/core/errors/failures.dart';
import 'package:aug_20_2025/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:aug_20_2025/core/entities/user_entity.dart';
import 'package:aug_20_2025/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthDatasource supabaseAuthDatasource;
  AuthRepositoryImpl(this.supabaseAuthDatasource);

  @override
  Future<Either<Failure, UserEntity>> currentUser() async {
    try {
      final user = await supabaseAuthDatasource
          .getCurrentuSerData();
      if (user == null) {
        return left(Failure("Login required"));
      }

      return right(user);
    } on ServerException catch (e) {
      throw (left(Failure(e.message)));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async =>
          await supabaseAuthDatasource.loginWithEmailPassword(
            email: email,
            password: password,
          ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async =>
          await supabaseAuthDatasource.signupWithEmailPassword(
            name: name,
            email: email,
            password: password,
          ),
    );
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await supabaseAuthDatasource.signOut();
      final session = supabaseAuthDatasource.currentUserSession;
      if (session != null) {
        return left(Failure("Sign out failed"));
      }
      return right(unit);
    } on ServerException catch (e) {
      throw (left(Failure(e.message)));
    }
  }

  Future<Either<Failure, UserEntity>> _getUser(
    Future<UserEntity> Function() fn,
  ) async {
    try {
      final user = await fn();

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on AuthException catch (e) {
      return left(Failure(e.message));
    }
  }
}
