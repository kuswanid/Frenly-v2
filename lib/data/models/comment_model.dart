import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frenly/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  final String? id;
  final String? authorId;
  final String? postId;
  final String? authorName;
  final String? authorProfileImage;
  final Timestamp? createdAt;
  final String? image;
  final File? imageFile;
  final List? likes;
  final String? message;

  const CommentModel({
    this.id,
    this.authorId,
    this.postId,
    this.authorName,
    this.authorProfileImage,
    this.createdAt,
    this.image,
    this.imageFile,
    this.likes,
    this.message,
  }) : super(
          id: id,
          authorId: authorId,
          postId: postId,
          authorName: authorName,
          authorProfileImage: authorProfileImage,
          createdAt: createdAt,
          image: image,
          imageFile: imageFile,
          likes: likes,
          message: message,
        );

  factory CommentModel.fromDocument(
      DocumentSnapshot commentSnapshot, DocumentSnapshot userSnapshot) {
    final commentData = commentSnapshot.data() as Map<String, dynamic>;
    final userData = userSnapshot.data() as Map<String, dynamic>;

    return CommentModel(
      id: commentSnapshot.id,
      authorId: userSnapshot.id,
      authorName: userData['name'],
      authorProfileImage: userData['profileImage'],
      image: commentData['image'],
      createdAt: commentData['createdAt'],
      likes: commentData['likes'],
      message: commentData['message'],
    );
  }

  Map<String, dynamic> toMap() => {
        'authorId': authorId,
        'createdAt': createdAt,
        'image': image,
        'likes': likes,
        'message': message,
      };
}
