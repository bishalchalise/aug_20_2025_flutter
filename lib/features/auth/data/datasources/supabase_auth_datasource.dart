// features/auth/data/datasources/supabase_auth_datasource.dart

import 'package:aug_20_2025/core/errors/exceptions.dart';
import 'package:aug_20_2025/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class SupabaseAuthDatasource {
  Session? get currentUserSession;
  Future<UserModel> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentuSerData();

  Future<void> signOut();
}

class SupabaseAuthDataSourceImpl
    implements SupabaseAuthDatasource {
  final SupabaseClient supabaseClient;

  SupabaseAuthDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession =>
      supabaseClient.auth.currentSession;

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
  }) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);

      if (response.user == null) {
        throw ServerException("User can not be Found");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentuSerData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(
          userData.first,
        ).copyWith(email: currentUserSession!.user.email);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    return supabaseClient.auth.signOut();
  }
}
