import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frenly/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String? id;
  final String? email;
  final Timestamp? joinAt;
  final String? name;
  final String? username;
  final String? password;
  final String? profileImage;

  const UserModel({
    this.id,
    this.email,
    this.joinAt,
    this.name,
    this.username,
    this.password,
    this.profileImage,
  }) : super(
          id: id,
          email: email,
          joinAt: joinAt,
          name: name,
          username: username,
          password: password,
          profileImage: profileImage,
        );

  factory UserModel.fromDocument(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      id: snapshot.id,
      email: data['email'],
      joinAt: data['joinAt'],
      name: data['name'],
      username: data['username'],
      profileImage: data['profileImage'],
    );
  }

  Map<String, dynamic> toMap() => {
        'email': email,
        'joinAt': joinAt,
        'name': name,
        'profileImage': profileImage,
      };
}
