import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/dependency_injection.dart' as di;
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:frenly/presentation/cubit/comment/comment_cubit.dart';
import 'package:frenly/presentation/cubit/comments/comments_cubit.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';
import 'package:frenly/presentation/cubit/posts/posts_cubit.dart';
import 'package:frenly/utils/constants.dart';
import 'package:frenly/utils/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.getIt<AuthCubit>()..getAuthStatus(),
        ),
        BlocProvider(
          create: (context) => di.getIt<CommentCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<CommentsCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<PostCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<PostsCubit>(),
        ),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return const SizedBox();
          } else {
            return MaterialApp.router(
              routerConfig: GoRouter(
                routes: routes,
                initialLocation:
                    state is Authenticated ? '/set_profile' : '/sign_in',
                navigatorKey: rootNavigatorKey,
              ),
              theme: ThemeData(
                textTheme:
                    GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
              ),
              debugShowCheckedModeBanner: false,
            );
          }
        },
        listener: (context, state) {},
        buildWhen: (previous, current) {
          if (current is Authenticated || current is UnAuthenticated) {
            return true;
          }
          return false;
        },
      ),
    );
  }
}
