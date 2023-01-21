import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frenly/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  final String? id;
  final String? authorId;
  final String? authorName;
  final String? authorProfileImage;
  final bool? archived;
  final int? commentCount;
  final Timestamp? createdAt;
  final String? description;
  final List? images;
  final List? likes;

  const PostModel({
    this.id,
    this.authorId,
    this.authorName,
    this.authorProfileImage,
    this.archived,
    this.commentCount,
    this.createdAt,
    this.description,
    this.images,
    this.likes,
  }) : super(
          id: id,
          authorId: authorId,
          authorName: authorName,
          authorProfileImage: authorProfileImage,
          archived: archived,
          commentCount: commentCount,
          createdAt: createdAt,
          description: description,
          images: images,
          likes: likes,
        );

  factory PostModel.fromDocument(
    DocumentSnapshot postSnapshot,
    DocumentSnapshot userSnapshot,
    QuerySnapshot commentsSnapshot,
  ) {
    final postData = postSnapshot.data() as Map<String, dynamic>;
    final userData = userSnapshot.data() as Map<String, dynamic>;

    return PostModel(
      id: postSnapshot.id,
      authorName: userData['name'],
      authorProfileImage: userData['profileImage'],
      commentCount: commentsSnapshot.size,
      createdAt: postData['createdAt'],
      description: postData['description'],
      images: postData['images'],
      likes: postData['likes'],
    );
  }

  Map<String, dynamic> toMap() => {
        'authorId': authorId,
        'archived': archived,
        'createdAt': createdAt,
        'description': description,
        'images': images,
        'likes': likes,
      };
}
