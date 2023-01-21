import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final paths = [
    '/',
    '/activity',
    '/search',
    '/chats',
    '/profile',
  ];

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouter.of(context).location;
    final currentIndex =
        paths.contains(currentLocation) ? paths.indexOf(currentLocation) : 0;

    return CupertinoTabBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Ionicons.home_outline)),
        BottomNavigationBarItem(icon: Icon(Ionicons.flash_outline)),
        BottomNavigationBarItem(icon: Icon(Ionicons.search_outline)),
        BottomNavigationBarItem(icon: Icon(Ionicons.chatbubble_ellipses_outline)),
        BottomNavigationBarItem(icon: Icon(Ionicons.person_circle_outline)),
      ],
      onTap: (value) {
        context.go(paths[value]);
      },
      currentIndex: currentIndex,
    );
  }
}
