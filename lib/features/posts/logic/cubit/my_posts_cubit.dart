import 'package:bloc/bloc.dart';
import 'package:bloc_arch_example/core/strings/success_strings.dart';

import '../../data/models/post.dart';
import '../../data/repo/posts_repo.dart';

part 'my_posts_state.dart';

class MyPostsCubit extends Cubit<MyPostsState> {
  MyPostsCubit({required this.postsRepo}) : super(MyPostsInitial());

  final PostsRepo postsRepo;

  List<Post> posts = [];

  void getAllPosts() async {
    emit(MyPostsLoadingState());
    final either = await postsRepo.getAllPosts();
    either.fold(
        (failure) => emit(MyPostsGettingAllDataFailedState(failure.failureMsg)),
        (posts) {
      this.posts = posts;
      emit(MyPostsGetAllPostsSuccessfullyState(posts));
    });
  }

  void addNewPost(Post addedPost) async {
    emit(MyPostsOperationLoadingState());
    final either = await postsRepo.addPost(addedPost);
    either.fold(
        (failure) => emit(MyPostsOperationFailedState(failure.failureMsg)),
        (unit) {
      emit(MyPostsOperationSuccessState(kPostAddedSuccessfullyString));
      getAllPosts();
    });
  }
}
