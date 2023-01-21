import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frenly/data/data_sources/remote/auth/auth_remote_data.dart';
import 'package:frenly/data/models/user_model.dart';
import 'package:frenly/domain/entities/user_entity.dart';

class AuthRemoteDataImpl implements AuthRemoteData {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDataImpl({required this.auth, required this.firestore});

  @override
  Future<UserEntity> getAuthStatus() async {
    final userCollection = firestore.collection('users');
    final currentUser = auth.currentUser;
    final snapshot = await userCollection.doc(currentUser?.uid).get();
    return UserModel.fromDocument(snapshot);
  }

  @override
  Future<UserEntity> signInUser(UserEntity user) async {
    final userCollection = firestore.collection('users');
    final credential = await auth.signInWithEmailAndPassword(
      email: user.email!,
      password: user.password!,
    );
    final snapshot = await userCollection.doc(credential.user?.uid).get();
    return UserModel.fromDocument(snapshot);
  }

  @override
  Future<void> signOutUser() async {
    return await auth.signOut();
  }

  @override
  Future<void> signUpUser(UserEntity user) async {
    final userCollection = firestore.collection('users');
    final credential = await auth.createUserWithEmailAndPassword(
      email: user.email!,
      password: user.password!,
    );
    final data = UserModel(
      email: user.email,
      joinAt: Timestamp.fromDate(credential.user!.metadata.creationTime!),
      name: user.name,
      profileImage: 'https://bit.ly/3XqSSyf',
    ).toMap();
    return await userCollection.doc(credential.user?.uid).set(data);
  }
}
