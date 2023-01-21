import 'package:equatable/equatable.dart';
import 'package:frenly/domain/entities/post_entity.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object?> get props => [];
}

class PostFailure extends PostState {
  final String message;

  const PostFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class PostCreated extends PostState {
  @override
  List<Object?> get props => [];
}

class PostLoaded extends PostState {
  final PostEntity post;

  const PostLoaded({required this.post});

  @override
  List<Object?> get props => [post];
}
