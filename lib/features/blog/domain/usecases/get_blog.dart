// features/blog/domain/usecases/get_blog.dart
import 'package:aug_20_2025/core/errors/failures.dart';
import 'package:aug_20_2025/core/usecase/usecase.dart';
import 'package:aug_20_2025/features/blog/domain/entities/blog_entities.dart';
import 'package:aug_20_2025/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBlog implements Usecase<List<BlogEntities>, NoParams> {
  final BlogRepository blogRepository;
  GetBlog(this.blogRepository);
  @override
  Future<Either<Failure, List<BlogEntities>>> call(
    NoParams params,
  ) async {
    return await blogRepository.getBlog();
  }
}
