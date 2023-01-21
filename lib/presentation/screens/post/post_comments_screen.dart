import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/presentation/cubit/comments/comments_cubit.dart';
import 'package:frenly/presentation/cubit/comments/comments_state.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';
import 'package:frenly/presentation/cubit/post/post_state.dart';
import 'package:frenly/presentation/screens/post/widgets/comment_form.dart';
import 'package:frenly/presentation/screens/post/widgets/comment_item.dart';
import 'package:frenly/presentation/widgets/post_item.dart';

class PostCommentsScreen extends StatefulWidget {
  final String postId;

  const PostCommentsScreen({super.key, required this.postId});

  @override
  State<PostCommentsScreen> createState() => _PostCommentsScreenState();
}

class _PostCommentsScreenState extends State<PostCommentsScreen> {
  @override
  void initState() {
    context.read<PostCubit>().getPost(PostEntity(id: widget.postId));
    context
        .read<CommentsCubit>()
        .getPostComments(PostEntity(id: widget.postId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<PostCubit, PostState>(
                    builder: (context, state) {
                      if (state is PostLoaded) {
                        return PostItem(post: state.post);
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<CommentsCubit, CommentsState>(
                    builder: (context, state) {
                      if (state is CommentsLoaded) {
                        return ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CommentItem(
                              comment: state.comments[index],
                              postId: widget.postId,
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: state.comments.length,
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          CommentForm(postId: widget.postId),
        ],
      ),
    );
  }
}
