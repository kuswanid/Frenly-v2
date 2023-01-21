import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';
import 'package:frenly/presentation/cubit/post/post_state.dart';
import 'package:frenly/presentation/screens/post/widgets/image_list.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController descriptionController = TextEditingController();
  List<File> imageList = [];

  Future pickCamera() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 512,
        maxHeight: 384,
      );
      if (image != null) {
        setState(() {
          imageList.add(File(image.path));
        });
      }
    } catch (_) {}
  }

  Future pickGallery() async {
    try {
      final images = await ImagePicker().pickMultiImage(
        maxWidth: 512,
        maxHeight: 384,
      );
      final imagesFile = images.map((e) => File(e.path)).toList();
      setState(() {
        imageList = [...imageList, ...imagesFile];
      });
    } catch (_) {}
  }

  @override
  void initState() {
    descriptionController.text =
        'Have a nice meeting with my partner for our future busines together!';
    imageList.add(File(
        '/data/user/0/com.kuswand.frenly/cache/scaled_image_picker8157688498872700636.jpg'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          BlocListener<PostCubit, PostState>(
            listener: (context, state) {
              if (state is PostCreated) {
                context.go('/');
              }
            },
            child: IconButton(
              onPressed: () {
                context.read<PostCubit>().createPost(PostEntity(
                      description: descriptionController.text,
                      images: imageList,
                    ));
              },
              icon: const Icon(Ionicons.checkmark),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
                contentPadding: EdgeInsets.all(16),
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(
              height: 18,
            ),
            ImageList(
              imageList: imageList,
              pickCamera: pickCamera,
              pickGallery: pickGallery,
              removeImage: (image) {
                setState(() {
                  imageList.remove(image);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
