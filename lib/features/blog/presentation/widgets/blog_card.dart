// features/blog/presentation/widgets/blog_card.dart
import 'package:aug_20_2025/core/utils/calculate_reading_time.dart';
import 'package:aug_20_2025/features/blog/domain/entities/blog_entities.dart';
import 'package:aug_20_2025/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final BlogEntities blog;
  final Color color;
  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewerPage.route(blog));
      },
      child: Container(
        height: 200,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: blog.topics
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Chip(label: Text(e)),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Text(blog.title),
              ],
            ),

            Text('${calculateReadingTime(blog.content)} min'),
          ],
        ),
      ),
    );
  }
}
