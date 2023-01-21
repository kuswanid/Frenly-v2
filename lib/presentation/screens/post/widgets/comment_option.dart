import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/presentation/cubit/comment/comment_cubit.dart';
import 'package:frenly/presentation/cubit/comment/comment_state.dart';
import 'package:frenly/presentation/cubit/comments/comments_cubit.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';
import 'package:ionicons/ionicons.dart';

class CommentOption extends StatelessWidget {
  final String commentId;
  final String postId;

  const CommentOption(
      {super.key, required this.commentId, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocListener<CommentCubit, CommentState>(
            listener: (context, state) {
              if (state is CommentDeleted) {
                Navigator.pop(context);
                context.read<PostCubit>().getPost(PostEntity(id: postId));
                context
                    .read<CommentsCubit>()
                    .getPostComments(PostEntity(id: postId));
              }
            },
            child: InkWell(
              child: Row(
                children: const [
                  Icon(Ionicons.close_circle_outline),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Delete'),
                ],
              ),
              onTap: () {
                context.read<CommentCubit>().deleteComment(CommentEntity(
                      id: commentId,
                      postId: postId,
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
