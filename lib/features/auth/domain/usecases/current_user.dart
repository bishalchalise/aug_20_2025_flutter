// features/auth/domain/usecases/current_user.dart
import 'package:aug_20_2025/core/errors/failures.dart';
import 'package:aug_20_2025/core/usecase/usecase.dart';
import 'package:aug_20_2025/core/entities/user_entity.dart';
import 'package:aug_20_2025/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<UserEntity, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(
    NoParams params,
  ) async {
    return await authRepository.currentUser();
  }
}
