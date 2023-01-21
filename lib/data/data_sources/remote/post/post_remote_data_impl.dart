import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:frenly/data/data_sources/remote/post/post_remote_data.dart';
import 'package:frenly/data/models/post_model.dart';
import 'package:frenly/domain/entities/post_entity.dart';

class PostRemoteDataImpl implements PostRemoteData {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  PostRemoteDataImpl({
    required this.auth,
    required this.firestore,
    required this.storage,
  });

  @override
  Future<void> createPost(PostEntity post) async {
    final urls = post.images?.map((image) async {
      try {
        final name = image.path.split('/').last;
        final storageRef = storage.ref('posts').child(name);
        await storageRef.putFile(image);
        return storageRef.getDownloadURL();
      } catch (_) {}
    }).toList();

    final images = await Future.wait(urls!);
    final postCollection = firestore.collection('posts');
    final userId = auth.currentUser!.uid;
    final data = PostModel(
      authorId: userId,
      archived: false,
      createdAt: Timestamp.now(),
      description: post.description,
      images: images,
      likes: const [],
    ).toMap();
    await postCollection.add(data);
  }

  @override
  Future<PostEntity> getPost(PostEntity post) async {
    final postCollection = firestore.collection('posts');
    final postSnapshot = await postCollection.doc(post.id).get();
    final authorId = postSnapshot.data()?['authorId'];
    final userCollection = firestore.collection('users');
    final userSnapshot = await userCollection.doc(authorId).get();
    final commentsSnapshot =
        await postCollection.doc(post.id).collection('comments').get();
    return PostModel.fromDocument(postSnapshot, userSnapshot, commentsSnapshot);
  }

  @override
  Future<List<PostEntity>> getPosts() async {
    final postCollection = firestore.collection('posts');
    final userCollection = firestore.collection('users');
    final postsSnapshot = await postCollection.get();
    final posts = postsSnapshot.docs.map((postSnapshot) async {
      final authorId = postSnapshot.data()['authorId'];
      final userSnapshot = await userCollection.doc(authorId).get();
      final commentsSnapshot = await postCollection
          .doc(postSnapshot.id)
          .collection('comments')
          .get();
      return PostModel.fromDocument(
          postSnapshot, userSnapshot, commentsSnapshot);
    });
    return Future.wait(posts);
  }

  @override
  Future<void> likePost(PostEntity post) async {
    final postCollection = firestore.collection('posts');
    final userId = auth.currentUser!.uid;
    final snapshot = await postCollection.doc(post.id).get();
    final likes = snapshot['likes'] as List;
    if (likes.contains(userId)) {
      postCollection.doc(post.id).update({
        'likes': FieldValue.arrayRemove([userId])
      });
    } else {
      postCollection.doc(post.id).update({
        'likes': FieldValue.arrayUnion([userId])
      });
    }
  }
}
