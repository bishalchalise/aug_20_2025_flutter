// features/auth/data/datasources/supabase_auth_datasource.dart

import 'package:aug_20_2025/core/errors/exceptions.dart';
import 'package:aug_20_2025/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class SupabaseAuthDatasource {
  Future<UserModel> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class SupabaseAuthDataSourceImpl
    implements SupabaseAuthDatasource {
  final SupabaseClient supabaseClient;

  SupabaseAuthDataSourceImpl(this.supabaseClient);
  @override
  Future<UserModel> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw const ServerException('User is null!');
      }

      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException('AuthException: ${e.message}');
    } on PostgrestException catch (e) {
      throw ServerException('PostgrestException: ${e.message}');
    } catch (e) {
      throw ServerException('Unknown error: $e');
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // Implementation for logging in with Firebase
    throw UnimplementedError();
  }
}
