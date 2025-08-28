// features/auth/data/repositories/auth_repository_impl.dart
import 'package:aug_20_2025/core/errors/exceptions.dart';
import 'package:aug_20_2025/core/errors/failures.dart';
import 'package:aug_20_2025/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:aug_20_2025/features/auth/domain/entities/user_entity.dart';
import 'package:aug_20_2025/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthDatasource supabaseAuthDatasource;
  AuthRepositoryImpl(this.supabaseAuthDatasource);

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await supabaseAuthDatasource
          .signupWithEmailPassword(
            name: name,
            email: email,
            password: password,
          );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
