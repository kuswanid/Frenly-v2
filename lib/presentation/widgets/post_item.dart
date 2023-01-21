import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class PostItem extends StatefulWidget {
  final PostEntity post;

  const PostItem({super.key, required this.post});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool liked = false;
  int likesCount = 0;
  int currentImage = 0;

  @override
  void initState() {
    final auth = context.read<AuthCubit>().state as Authenticated;
    liked = widget.post.likes!.contains(auth.user.id);
    likesCount = widget.post.likes!.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.post.authorProfileImage!),
            ),
            title: Text('${widget.post.authorName}'),
            subtitle: Text(
              formatDate(
                widget.post.createdAt!.toDate(),
                [dd, ' ', MM, ' ', yyyy],
              ),
              style: const TextStyle(fontSize: 12),
            ),
            trailing: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(24),
              child: const Icon(Ionicons.ellipsis_vertical),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          Text('${widget.post.description}'),
          const SizedBox(
            height: 12,
          ),
          CarouselSlider.builder(
            itemCount: widget.post.images?.length,
            itemBuilder: (context, index, realIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.post.images![index],
                  fit: BoxFit.cover,
                ),
              );
            },
            options: CarouselOptions(
              aspectRatio: 4 / 3,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  currentImage = index;
                });
              },
              scrollPhysics: widget.post.images!.length > 1
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  context
                      .read<PostCubit>()
                      .likePost(PostEntity(id: widget.post.id));
                  setState(() {
                    liked = !liked;
                    liked ? likesCount++ : likesCount--;
                  });
                },
                borderRadius: BorderRadius.circular(24),
                child: Icon(liked ? Ionicons.heart : Ionicons.heart_outline),
              ),
              const SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () => context.push('/post/${widget.post.id}/comments'),
                borderRadius: BorderRadius.circular(24),
                child: const Icon(Ionicons.chatbubble_outline),
              ),
              const Spacer(),
              if (widget.post.images!.length > 1)
                Row(
                  children: widget.post.images!.asMap().entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(currentImage == e.key ? 1 : .3),
                          shape: BoxShape.circle,
                        ),
                        width: 6,
                        height: 6,
                      ),
                    );
                  }).toList(),
                ),
              const Spacer(),
              const SizedBox(
                width: 28,
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(24),
                child: const Icon(Ionicons.bookmark_outline),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              if (likesCount > 0)
                Text(
                  '$likesCount ${likesCount > 1 ? 'likes  ' : 'like  '}  ',
                  style: const TextStyle(fontSize: 12),
                ),
              if (widget.post.commentCount! > 0)
                Text(
                  '${widget.post.commentCount} ${widget.post.commentCount! > 1 ? 'comments' : 'comment'}',
                  style: const TextStyle(fontSize: 12),
                ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
