// features/auth/data/datasources/firebase_auth_datasource.dart

import 'package:aug_20_2025/core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class FirebaseAuthDataSource {
  Future<String> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class FirebaseAuthDataSourceImpl
    implements FirebaseAuthDataSource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthDataSourceImpl(this.firebaseAuth);
  @override
  Future<String> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

      if (response.user == null) {
        throw const ServerException('User is null');
      }
      await response.user!.updateDisplayName(name);
      await response.user!.reload();
      return response.user!.uid;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // Implementation for logging in with Firebase
    throw UnimplementedError();
  }
}
