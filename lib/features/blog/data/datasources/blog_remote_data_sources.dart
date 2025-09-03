// features/blog/data/datasources/blog_remote_data_sources.dart
import 'dart:io';

import 'package:aug_20_2025/core/errors/exceptions.dart';
import 'package:aug_20_2025/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blogModel);
  Future<String> uploadImage({
    required File image,
    required BlogModel blogModel,
  });
  Future<List<BlogModel>> getBlog();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<BlogModel> uploadBlog(BlogModel blogModel) async {
    try {
      final response = await supabaseClient
          .from('blogs')
          .insert(blogModel.toJson())
          .select();
      return BlogModel.fromJson(response.first);
    } on PostgrestException catch (e) {
      throw ServerException('PostgrestException: ${e.message}');
    } catch (e) {
      throw ServerException('Error uploading blog: $e');
    }
  }

  @override
  Future<String> uploadImage({
    required File image,
    required BlogModel blogModel,
  }) async {
    try {
      await supabaseClient.storage
          .from("blog_images")
          .upload(blogModel.id, image);
      return supabaseClient.storage
          .from("blog_images")
          .getPublicUrl(blogModel.id);
    } catch (e) {
      throw ServerException('Error uploading image: $e');
    }
  }

  @override
  Future<List<BlogModel>> getBlog() async {
    try {
      final blogs = await supabaseClient
          .from('blogs')
          .select('*, profiles(name)');

      final blogsFinal = blogs
          .map(
            (blog) => BlogModel.fromJson(
              blog,
            ).copyWith(posterName: blog['profiles']['name']),
          )
          .toList();
      return blogsFinal;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
