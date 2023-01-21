import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/domain/entities/post_entity.dart';

abstract class CommentRemoteData {
  Future<void> createComment(CommentEntity comment);
  Future<void> deleteComment(CommentEntity comment);
  Future<List<CommentEntity>> getPostComments(PostEntity post);
  Future<void> likeComment(CommentEntity comment);
}
