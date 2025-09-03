// features/blog/domain/entities/blog_entities.dart
class BlogEntities {
  final String id;
  final String postedId;
  final String imageUrl;
  final String title;
  final String content;
  final List<String> topics;
  final DateTime updatedAt;
  final String? posterName;

  BlogEntities({
    required this.id,
    required this.title,
    required this.content,
    required this.topics,
    required this.imageUrl,
    required this.postedId,
    required this.updatedAt,
    this.posterName,
  });
}
