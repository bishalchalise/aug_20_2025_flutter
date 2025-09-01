// features/blog/presentation/widgets/blog_editor.dart

import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const BlogEditor({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
      ),
    );
  }
}
