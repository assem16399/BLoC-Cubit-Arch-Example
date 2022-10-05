part of 'posts_bloc.dart';

abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsGetAllPostsSuccessfullyState extends PostsState {
  final List<Post> posts;

  PostsGetAllPostsSuccessfullyState(this.posts);
}

class PostsGettingAllDataFailedState extends PostsState {
  final String failMsg;

  PostsGettingAllDataFailedState(this.failMsg);
}

class PostsOperationLoadingState extends PostsState {}

class PostsOperationSuccessState extends PostsState {
  final String successMsg;

  PostsOperationSuccessState(this.successMsg);
}

class PostsOperationFailedState extends PostsState {
  final String failMsg;

  PostsOperationFailedState(this.failMsg);
}
