import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
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

  const CommentEntity({
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
  });

  @override
  List<Object?> get props => [
        id,
        authorId,
        postId,
        authorName,
        authorProfileImage,
        createdAt,
        image,
        imageFile,
        likes,
        message,
      ];
}
