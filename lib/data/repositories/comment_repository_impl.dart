import 'package:frenly/data/data_sources/remote/comment/comment_remote_data.dart';
import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteData remoteData;

  CommentRepositoryImpl({required this.remoteData});

  @override
  Future<void> createComment(CommentEntity comment) {
    return remoteData.createComment(comment);
  }

  @override
  Future<void> deleteComment(CommentEntity comment) {
    return remoteData.deleteComment(comment);
  }

  @override
  Future<List<CommentEntity>> getPostComments(PostEntity post) {
    return remoteData.getPostComments(post);
  }

  @override
  Future<void> likeComment(CommentEntity comment) {
    return remoteData.likeComment(comment);
  }
}
