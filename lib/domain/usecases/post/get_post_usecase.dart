import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/domain/repositories/post_repository.dart';

class GetPostUseCase {
  final PostRepository repository;

  GetPostUseCase({required this.repository});

  Future<PostEntity> call(PostEntity post) {
    return repository.getPost(post);
  }
}
