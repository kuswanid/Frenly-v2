import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/domain/repositories/comment_repository.dart';

class GetPostCommentsUseCase {
  final CommentRepository repository;

  GetPostCommentsUseCase({required this.repository});

  Future<List<CommentEntity>> call(PostEntity post) {
    return repository.getPostComments(post);
  }
}
