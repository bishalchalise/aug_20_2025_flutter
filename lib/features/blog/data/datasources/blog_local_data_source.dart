// features/blog/data/datasources/blog_local_data_source.dart
import 'package:aug_20_2025/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBLogs();
  void updatePosterName({
    required String blogId,
    required String posterName,
  });
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl(this.box);

  @override
  List<BlogModel> loadBLogs() {
    List<BlogModel> blogs = [];
    box.read(() {
      for (var i = 0; i < box.length; i++) {
        final Map<String, dynamic> blogMap =
            Map<String, dynamic>.from(box.get(i.toString()));

        final posterName = blogMap['poster_name'] as String?;
        BlogModel blog = BlogModel.fromJson(
          blogMap,
        ).copyWith(posterName: posterName);

        blogs.add(blog);
      }
    });
    return blogs;
  }

  @override
  void uploadBlogs({required List<BlogModel> blogs}) {
    box.clear();
    box.write(() {
      for (var i = 0; i < blogs.length; i++) {
        final blogMap = blogs[i].toJson();

        if (blogs[i].posterName != null) {
          blogMap['poster_name'] = blogs[i].posterName;
        }

        box.put(i.toString(), blogMap);
      }
    });
  }

  @override
  void updatePosterName({
    required String blogId,
    required String posterName,
  }) {
    final blogMap = Map<String, dynamic>.from(box.get(blogId));
    blogMap['poster_name'] = posterName;
    box.put(blogId, blogMap);
  }
}
