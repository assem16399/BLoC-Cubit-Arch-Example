part of 'my_posts_cubit.dart';

abstract class MyPostsState {}

class MyPostsInitial extends MyPostsState {}

class MyPostsLoadingState extends MyPostsState {}

class MyPostsGetAllPostsSuccessfullyState extends MyPostsState {
  final List<Post> posts;

  MyPostsGetAllPostsSuccessfullyState(this.posts);
}

class MyPostsGettingAllDataFailedState extends MyPostsState {
  final String failMsg;

  MyPostsGettingAllDataFailedState(this.failMsg);
}

class MyPostsOperationLoadingState extends MyPostsState {}

class MyPostsOperationSuccessState extends MyPostsState {
  final String successMsg;

  MyPostsOperationSuccessState(this.successMsg);
}

class MyPostsOperationFailedState extends MyPostsState {
  final String failMsg;

  MyPostsOperationFailedState(this.failMsg);
}
