import 'package:flutter/material.dart';
import 'package:frenly/presentation/screens/auth/sign_in_screen.dart';
import 'package:frenly/presentation/screens/auth/sign_up_screen.dart';
import 'package:frenly/presentation/screens/chat/chats_screen.dart';
import 'package:frenly/presentation/screens/home/home_screen.dart';
import 'package:frenly/presentation/screens/post/create_post_screen.dart';
import 'package:frenly/presentation/screens/post/post_comments_screen.dart';
import 'package:frenly/presentation/screens/setting/settings_screen.dart';
import 'package:frenly/presentation/screens/user/profile_screen.dart';
import 'package:frenly/presentation/screens/user/set_profile_screen.dart';
import 'package:frenly/presentation/screens/user/set_username_screen.dart';
import 'package:frenly/presentation/widgets/custom_bottom_bar.dart';
import 'package:frenly/utils/constants.dart';
import 'package:go_router/go_router.dart';

final routes = [
  ShellRoute(
    builder: (context, state, child) {
      return Scaffold(
        body: child,
        bottomNavigationBar: const CustomBottomBar(),
      );
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/chats',
        builder: (context, state) => const ChatsScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  ),
  GoRoute(
    path: '/sign_in',
    builder: (context, state) => const SignInScreen(),
  ),
  GoRoute(
    path: '/sign_up',
    builder: (context, state) => const SignUpScreen(),
  ),
  GoRoute(
    path: '/create_post',
    builder: (context, state) => const CreatePostScreen(),
    parentNavigatorKey: rootNavigatorKey,
  ),
  GoRoute(
    path: '/post/:postId/comments',
    builder: (context, state) =>
        PostCommentsScreen(postId: state.params['postId']!),
    parentNavigatorKey: rootNavigatorKey,
  ),
  GoRoute(
    path: '/settings',
    builder: (context, state) => const SettingsScreen(),
    parentNavigatorKey: rootNavigatorKey,
  ),
  GoRoute(
    path: '/set_profile',
    builder: (context, state) => const SetProfileScreen(),
    parentNavigatorKey: rootNavigatorKey,
  ),
  GoRoute(
    path: '/set_username',
    builder: (context, state) => const SetUsernameScreen(),
  ),
];
