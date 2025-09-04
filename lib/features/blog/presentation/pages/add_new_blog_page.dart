// features/blog/presentation/pages/add_new_blog_page.dart
import 'dart:io';

import 'package:aug_20_2025/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:aug_20_2025/core/common/widgets/loader.dart';
import 'package:aug_20_2025/core/constants/constatns.dart';
import 'package:aug_20_2025/core/theme/app_pallete.dart';
import 'package:aug_20_2025/core/utils/pick_image.dart';
import 'package:aug_20_2025/core/utils/show_snakbar.dart';
import 'package:aug_20_2025/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:aug_20_2025/features/blog/presentation/pages/blog_page.dart';
import 'package:aug_20_2025/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => AddNewBlogPage());

  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedChips = [];
  File? image;
  final _formKey = GlobalKey<FormState>();
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  void uploadBlog() {
    if (_formKey.currentState!.validate() &&
        selectedChips.isNotEmpty &&
        image != null) {
      final postedId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn)
              .user
              .id;
      context.read<BlogBloc>().add(
        BlogUpload(
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          topics: selectedChips,
          postedId: postedId,
          image: image!,
        ),
      );
      // Upload blog event
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              uploadBlog();
            },
            icon: Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackbar(context, state.error);
          } else if (state is BlogSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              BlogPage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),

              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(10),
                                child: Image.file(
                                  image!,

                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              selectImage();
                            },
                            child: DottedBorder(
                              options:
                                  RoundedRectDottedBorderOptions(
                                    radius: Radius.circular(10),
                                    color:
                                        AppPallete.borderColor,
                                    strokeCap: StrokeCap.round,
                                    dashPattern: [10, 5],
                                  ),

                              child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.folder_open),
                                    SizedBox(height: 15),
                                    Text(
                                      "Select an image.",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: Constatns.topics
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(
                                  5.0,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectedChips.contains(
                                      e,
                                    )) {
                                      selectedChips.remove(e);
                                    } else {
                                      selectedChips.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                    label: Text(e),
                                    color:
                                        selectedChips.contains(e)
                                        ? WidgetStatePropertyAll(
                                            AppPallete.gradient1,
                                          )
                                        : null,
                                    side:
                                        selectedChips.contains(e)
                                        ? null
                                        : BorderSide(
                                            color: AppPallete
                                                .borderColor,
                                          ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                    BlogEditor(
                      controller: titleController,
                      hintText: "Title",
                    ),
                    SizedBox(height: 20),
                    BlogEditor(
                      controller: contentController,
                      hintText: "Content",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
