import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/domain/usecases/comment/get_post_comments_usecase.dart';
import 'package:frenly/presentation/cubit/comments/comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final GetPostCommentsUseCase getPostCommentsUseCase;

  CommentsCubit({required this.getPostCommentsUseCase})
      : super(CommentsInitial());

  Future<void> getPostComments(PostEntity post) async {
    try {
      final comments = await getPostCommentsUseCase(post);
      emit(CommentsLoaded(comments: comments));
    } catch (e) {
      emit(CommentsFailure(message: e.toString()));
    }
  }
}
