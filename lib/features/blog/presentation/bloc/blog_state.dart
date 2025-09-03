// features/blog/presentation/bloc/blog_state.dart
part of 'blog_bloc.dart';

sealed class BlogState {
  const BlogState();
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogSuccess extends BlogState {
  final List<BlogEntities>? blog;
  const BlogSuccess([this.blog]);
}

final class BlogFailure extends BlogState {
  final String error;
  const BlogFailure(this.error);
}

final class BlogsDisplaySuccess extends BlogState {
  final List<BlogEntities> blogs;
  const BlogsDisplaySuccess(this.blogs);
}
