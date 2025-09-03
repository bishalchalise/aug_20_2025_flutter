// features/blog/domain/repository/blog_repository.dart
import 'dart:io';

import 'package:aug_20_2025/core/errors/failures.dart';
import 'package:aug_20_2025/features/blog/domain/entities/blog_entities.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntities>> uploadBlogs({
    required String postedId,
    required String title,
    required String content,
    required List<String> topics,
    required File image,
  });
  Future<Either<Failure, List<BlogEntities>>> getBlog();
}
