import 'package:frenly/data/data_sources/remote/post/post_remote_data.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteData remoteData;

  PostRepositoryImpl({required this.remoteData});

  @override
  Future<void> createPost(PostEntity post) {
    return remoteData.createPost(post);
  }

  @override
  Future<PostEntity> getPost(PostEntity post) {
    return remoteData.getPost(post);
  }

  @override
  Future<List<PostEntity>> getPosts() {
    return remoteData.getPosts();
  }

  @override
  Future<void> likePost(PostEntity post) {
    return remoteData.likePost(post);
  }
}
