part of 'posts_bloc.dart';

abstract class PostsEvent {}

class GetAllPostsEvent extends PostsEvent {}

class AddPostEvent extends PostsEvent {
  final Post addedPost;

  AddPostEvent(this.addedPost);
}

class UpdatePostEvent extends PostsEvent {
  final Post editedPost;

  UpdatePostEvent(this.editedPost);
}

class DeletePostEvent extends PostsEvent {
  final String postId;

  DeletePostEvent(this.postId);
}
