// features/blog/domain/usecases/upload_blog.dart
import 'dart:io';

import 'package:aug_20_2025/core/errors/failures.dart';
import 'package:aug_20_2025/core/usecase/usecase.dart';
import 'package:aug_20_2025/features/blog/domain/entities/blog_entities.dart';
import 'package:aug_20_2025/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog
    implements Usecase<BlogEntities, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, BlogEntities>> call(
    UploadBlogParams params,
  ) async {
    return await blogRepository.uploadBlogs(
      title: params.title,
      content: params.content,
      topics: params.topics,
      postedId: params.postedId,
      image: params.image,
    );
  }
}

class UploadBlogParams {
  final String title;
  final String content;
  final List<String> topics;
  final String postedId;
  final File image;

  UploadBlogParams({
    required this.title,
    required this.content,
    required this.topics,
    required this.postedId,
    required this.image,
  });
}
