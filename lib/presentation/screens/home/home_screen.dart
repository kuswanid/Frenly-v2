import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/presentation/cubit/posts/posts_cubit.dart';
import 'package:frenly/presentation/cubit/posts/posts_state.dart';
import 'package:frenly/presentation/screens/home/widgets/custom_drawer.dart';
import 'package:frenly/presentation/widgets/post_item.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<PostsCubit>().getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frenly'),
        actions: [
          IconButton(
            onPressed: () => context.push('/create_post'),
            icon: const Icon(Ionicons.add_outline),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.notifications_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<PostsCubit, PostsState>(
            builder: (context, state) {
              if (state is PostsLoaded) {
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return PostItem(post: state.posts[index]);
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: state.posts.length,
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }
}
