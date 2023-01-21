import 'package:frenly/domain/entities/post_entity.dart';

abstract class PostRemoteData {
  Future<void> createPost(PostEntity post);
  Future<PostEntity> getPost(PostEntity post);
  Future<List<PostEntity>> getPosts();
  Future<void> likePost(PostEntity post);
}
