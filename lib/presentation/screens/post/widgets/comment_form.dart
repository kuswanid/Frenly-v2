import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/presentation/cubit/comment/comment_cubit.dart';
import 'package:frenly/presentation/cubit/comment/comment_state.dart';
import 'package:frenly/presentation/cubit/comments/comments_cubit.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class CommentForm extends StatefulWidget {
  final String postId;

  const CommentForm({super.key, required this.postId});

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  TextEditingController messageController = TextEditingController();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Column(
        children: [
          if (image != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 28,
                top: 12,
                right: 28,
                bottom: 4,
              ),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.file(image!),
              ),
            ),
          Row(
            children: [
              InkWell(
                onTap: () async {
                  try {
                    final imageFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 512,
                      maxHeight: 384,
                    );
                    if (imageFile != null) {
                      setState(() {
                        image = File(imageFile.path);
                      });
                    }
                  } catch (_) {}
                },
                borderRadius: BorderRadius.circular(24),
                child: Icon(
                  Ionicons.camera_outline,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: const InputDecoration(
                    hintText: 'Your comment..',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              BlocListener<CommentCubit, CommentState>(
                listener: (context, state) {
                  if (state is CommentCreated) {
                    context
                        .read<PostCubit>()
                        .getPost(PostEntity(id: widget.postId));
                    context
                        .read<CommentsCubit>()
                        .getPostComments(PostEntity(id: widget.postId));
                    messageController.text = '';
                    setState(() {
                      image = null;
                    });
                  }
                },
                child: InkWell(
                  onTap: () {
                    context.read<CommentCubit>().createComment(CommentEntity(
                          postId: widget.postId,
                          imageFile: image,
                          message: messageController.text,
                        ));
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: Icon(
                    Ionicons.paper_plane_outline,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
