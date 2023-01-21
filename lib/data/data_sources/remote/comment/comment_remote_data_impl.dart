import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:frenly/data/data_sources/remote/comment/comment_remote_data.dart';
import 'package:frenly/data/models/comment_model.dart';
import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/domain/entities/post_entity.dart';

class CommentRemoteDataImpl implements CommentRemoteData {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  CommentRemoteDataImpl({
    required this.auth,
    required this.firestore,
    required this.storage,
  });

  @override
  Future<void> createComment(CommentEntity comment) async {
    final image = comment.imageFile != null
        ? () async {
            final name = comment.imageFile!.path.split('/').last;
            final storageRef = storage.ref('comments').child(name);
            await storageRef.putFile(comment.imageFile!);
            return storageRef.getDownloadURL();
          }()
        : null;
    final commentCollection = firestore
        .collection('posts')
        .doc(comment.postId)
        .collection('comments');
    final userId = auth.currentUser!.uid;
    final data = CommentModel(
      authorId: userId,
      createdAt: Timestamp.now(),
      image: await image,
      likes: const [],
      message: comment.message,
    ).toMap();
    await commentCollection.add(data);
  }

  @override
  Future<void> deleteComment(CommentEntity comment) async {
    final commentCollection = firestore
        .collection('posts')
        .doc(comment.postId)
        .collection('comments');
    final snapshot = await commentCollection.doc(comment.id).get();
    final image = snapshot['image'];
    if (image != null) {
      storage.refFromURL(image).delete();
    }
    await commentCollection.doc(comment.id).delete();
  }

  @override
  Future<List<CommentEntity>> getPostComments(PostEntity post) async {
    final commentCollection =
        firestore.collection('posts').doc(post.id).collection('comments');
    final snapshot = await commentCollection.get();
    final userCollection = firestore.collection('users');
    final comments = snapshot.docs.map((commentSnapshot) async {
      final authorId = commentSnapshot.data()['authorId'];
      final userSnapshot = await userCollection.doc(authorId).get();
      return CommentModel.fromDocument(commentSnapshot, userSnapshot);
    });
    return Future.wait(comments);
  }

  @override
  Future<void> likeComment(CommentEntity comment) async {
    final userId = auth.currentUser!.uid;
    final commentCollection = firestore
        .collection('posts')
        .doc(comment.postId)
        .collection('comments');
    final snapshot = await commentCollection.doc(comment.id).get();
    final likes = snapshot['likes'] as List;
    if (likes.contains(userId)) {
      commentCollection.doc(comment.id).update({
        'likes': FieldValue.arrayRemove([userId])
      });
    } else {
      commentCollection.doc(comment.id).update({
        'likes': FieldValue.arrayUnion([userId])
      });
    }
  }
}
