// features/blog/presentation/bloc/blog_event.dart

part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent {
  final String postedId;
  final String title;
  final String content;
  final List<String> topics;
  final File image;

  BlogUpload({
    required this.postedId,
    required this.title,
    required this.content,
    required this.topics,
    required this.image,
  });
}

final class BlocGetAllBlogs extends BlogEvent {}
