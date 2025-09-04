// features/blog/presentation/pages/blog_viewer_page.dart

import 'package:aug_20_2025/core/theme/app_pallete.dart';
import 'package:aug_20_2025/core/utils/calculate_reading_time.dart';
import 'package:aug_20_2025/core/utils/format_date.dart';
import 'package:aug_20_2025/features/blog/domain/entities/blog_entities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  static MaterialPageRoute route(BlogEntities blog) =>
      MaterialPageRoute(
        builder: (context) => BlogViewerPage(blog: blog),
      );
  final BlogEntities blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'By ${blog.posterName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${formatDateBydMMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppPallete.greyColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: blog.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        Container(
                          height: 150,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey[600],
                          ),
                        ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  blog.content,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
