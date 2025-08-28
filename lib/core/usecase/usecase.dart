// core/usecase/usecase.dart
import 'package:aug_20_2025/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
