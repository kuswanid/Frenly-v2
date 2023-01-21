import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthCubit>().state as Authenticated;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(auth.user.profileImage!),
                  radius: 40,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text('${auth.user.name}'),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Ionicons.bookmarks_outline),
            title: const Text('Favorites'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Ionicons.settings_outline),
            title: const Text('Settings'),
            onTap: () => context.push('/settings'),
          ),
          ListTile(
            leading: const Icon(Ionicons.log_out_outline),
            title: const Text('Logout'),
            onTap: () {
              context.read<AuthCubit>().signOutUser();
            },
          ),
        ],
      ),
    );
  }
}
