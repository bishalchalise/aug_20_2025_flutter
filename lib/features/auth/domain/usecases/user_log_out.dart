// features/auth/domain/usecases/user_log_out.dart
import 'package:aug_20_2025/core/errors/failures.dart';
import 'package:aug_20_2025/core/usecase/usecase.dart';
import 'package:aug_20_2025/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogOut implements Usecase<Unit, NoParams> {
  final AuthRepository authRepository;
  UserLogOut(this.authRepository);
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await authRepository.signOut();
  }
}
