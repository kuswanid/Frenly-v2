import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:frenly/presentation/cubit/comment/comment_cubit.dart';
import 'package:frenly/presentation/screens/post/widgets/comment_option.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentItem extends StatefulWidget {
  final CommentEntity comment;
  final String postId;

  const CommentItem({super.key, required this.comment, required this.postId});

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool liked = false;
  int likesCount = 0;

  @override
  void initState() {
    final auth = context.read<AuthCubit>().state as Authenticated;
    liked = widget.comment.likes!.contains(auth.user.id);
    likesCount = widget.comment.likes!.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthCubit>().state as Authenticated;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.comment.authorProfileImage!),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).highlightColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.comment.authorName}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.comment.message}',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  if (widget.comment.image != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.comment.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Text(
                        timeago.format(widget.comment.createdAt!.toDate()),
                        style: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      if (likesCount > 0)
                        Text(
                          '$likesCount ${likesCount > 1 ? 'likes   ' : 'like   '}',
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontSize: 12,
                          ),
                        ),
                      InkWell(
                        child: const Text(
                          'Reply',
                          style: TextStyle(fontSize: 12),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
              onLongPress: () {
                if (widget.comment.authorId == auth.user.id) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return CommentOption(
                        commentId: widget.comment.id!,
                        postId: widget.postId,
                      );
                    },
                  );
                }
              },
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () {
              context.read<CommentCubit>().likeComment(CommentEntity(
                    id: widget.comment.id,
                    postId: widget.postId,
                  ));
              setState(() {
                liked = !liked;
                liked ? likesCount++ : likesCount--;
              });
            },
            borderRadius: BorderRadius.circular(24),
            child: Icon(
              liked ? Ionicons.heart : Ionicons.heart_outline,
              size: 18,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
