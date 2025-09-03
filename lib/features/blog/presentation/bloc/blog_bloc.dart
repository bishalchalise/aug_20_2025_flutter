// features/blog/presentation/bloc/blog_bloc.dart
import 'dart:io';

import 'package:aug_20_2025/core/usecase/usecase.dart';
import 'package:aug_20_2025/features/blog/domain/entities/blog_entities.dart';
import 'package:aug_20_2025/features/blog/domain/usecases/get_blog.dart';
import 'package:aug_20_2025/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetBlog _getBlog;
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetBlog getBlog,
  }) : _uploadBlog = uploadBlog,
       _getBlog = getBlog,
       super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlocGetAllBlogs>(_onGetBlog);
  }

  void _onBlogUpload(
    BlogUpload event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        title: event.title,
        content: event.content,
        topics: event.topics,
        postedId: event.postedId,
        image: event.image,
      ),
    );

    res.fold(
      (onLeft) => emit(BlogFailure(onLeft.message)),
      (onRight) => emit(BlogSuccess()),
    );
  }

  void _onGetBlog(
    BlocGetAllBlogs event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getBlog(NoParams());
    res.fold(
      (onLeft) => emit(BlogFailure(onLeft.message)),
      (onRight) => emit(BlogsDisplaySuccess(onRight)),
    );
  }
}
