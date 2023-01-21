import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:frenly/data/data_sources/remote/auth/auth_remote_data.dart';
import 'package:frenly/data/data_sources/remote/auth/auth_remote_data_impl.dart';
import 'package:frenly/data/data_sources/remote/comment/comment_remote_data.dart';
import 'package:frenly/data/data_sources/remote/comment/comment_remote_data_impl.dart';
import 'package:frenly/data/data_sources/remote/post/post_remote_data.dart';
import 'package:frenly/data/data_sources/remote/post/post_remote_data_impl.dart';
import 'package:frenly/data/repositories/auth_repository_impl.dart.dart';
import 'package:frenly/data/repositories/comment_repository_impl.dart';
import 'package:frenly/data/repositories/post_repository_impl.dart';
import 'package:frenly/domain/repositories/auth_repository.dart';
import 'package:frenly/domain/repositories/comment_repository.dart';
import 'package:frenly/domain/repositories/post_repository.dart';
import 'package:frenly/domain/usecases/auth/get_auth_status_usecase.dart';
import 'package:frenly/domain/usecases/auth/sign_in_user_usecase.dart';
import 'package:frenly/domain/usecases/auth/sign_out_user_usecase.dart';
import 'package:frenly/domain/usecases/auth/sign_up_user_usecase.dart';
import 'package:frenly/domain/usecases/comment/create_comment_usecase.dart';
import 'package:frenly/domain/usecases/comment/delete_comment_usecase.dart';
import 'package:frenly/domain/usecases/comment/get_post_comments_usecase.dart';
import 'package:frenly/domain/usecases/comment/like_comment_usecase.dart';
import 'package:frenly/domain/usecases/post/create_post_usecase.dart';
import 'package:frenly/domain/usecases/post/get_post_usecase.dart';
import 'package:frenly/domain/usecases/post/get_posts_usecase.dart';
import 'package:frenly/domain/usecases/post/like_post_usecase.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/comment/comment_cubit.dart';
import 'package:frenly/presentation/cubit/comments/comments_cubit.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';
import 'package:frenly/presentation/cubit/posts/posts_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void init() {
  // Cubit
  getIt.registerFactory(() => AuthCubit(
        getAuthStatusUseCase: getIt.call(),
        signInUserUseCase: getIt.call(),
        signOutUserUseCase: getIt.call(),
        signUpUserUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => CommentCubit(
        createCommentUseCase: getIt.call(),
        deleteCommentUseCase: getIt.call(),
        likeCommentUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => CommentsCubit(
        getPostCommentsUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => PostCubit(
        createPostUseCase: getIt.call(),
        getPostUseCase: getIt.call(),
        likePostUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => PostsCubit(
        getPostsUseCase: getIt.call(),
      ));

  // UseCase
  /// Auth
  getIt.registerLazySingleton(
      () => GetAuthStatusUseCase(repository: getIt.call()));
  getIt
      .registerLazySingleton(() => SignInUserUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => SignOutUserUseCase(repository: getIt.call()));
  getIt
      .registerLazySingleton(() => SignUpUserUseCase(repository: getIt.call()));

  /// Comment
  getIt.registerLazySingleton(
      () => CreateCommentUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => DeleteCommentUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => LikeCommentUseCase(repository: getIt.call()));

  /// Comments
  getIt.registerLazySingleton(
      () => GetPostCommentsUseCase(repository: getIt.call()));

  /// Post
  getIt
      .registerLazySingleton(() => CreatePostUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(() => GetPostUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(() => LikePostUseCase(repository: getIt.call()));

  /// Posts
  getIt.registerLazySingleton(() => GetPostsUseCase(repository: getIt.call()));

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteData: getIt.call()));
  getIt.registerLazySingleton<CommentRepository>(
      () => CommentRepositoryImpl(remoteData: getIt.call()));
  getIt.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(remoteData: getIt.call()));

  // DataSource
  getIt.registerLazySingleton<AuthRemoteData>(() => AuthRemoteDataImpl(
        auth: getIt.call(),
        firestore: getIt.call(),
      ));
  getIt.registerLazySingleton<CommentRemoteData>(() => CommentRemoteDataImpl(
        auth: getIt.call(),
        firestore: getIt.call(),
        storage: getIt.call(),
      ));
  getIt.registerLazySingleton<PostRemoteData>(() => PostRemoteDataImpl(
        auth: getIt.call(),
        firestore: getIt.call(),
        storage: getIt.call(),
      ));

  // Firebase
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => FirebaseStorage.instance);
}
