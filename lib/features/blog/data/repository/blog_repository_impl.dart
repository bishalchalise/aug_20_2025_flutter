// features/blog/data/repository/blog_repository_impl.dart
import 'dart:io';

import 'package:aug_20_2025/core/errors/exceptions.dart';
import 'package:aug_20_2025/core/errors/failures.dart';
import 'package:aug_20_2025/features/blog/data/datasources/blog_remote_data_sources.dart';
import 'package:aug_20_2025/features/blog/data/models/blog_model.dart';
import 'package:aug_20_2025/features/blog/domain/entities/blog_entities.dart';
import 'package:aug_20_2025/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  BlogRepositoryImpl(this.blogRemoteDataSource);
  @override
  Future<Either<Failure, BlogEntities>> uploadBlogs({
    required File image,
    required String postedId,
    required String title,
    required String content,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        postedId: postedId,
        title: title,
        content: content,
        imageUrl: "",
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadImage(
        image: image,
        blogModel: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(
        blogModel,
      );
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntities>>> getBlog() async {
    try {
      final blogs = await blogRemoteDataSource.getBlog();
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure('Error fetching blogs: $e'));
    }
  }
}
