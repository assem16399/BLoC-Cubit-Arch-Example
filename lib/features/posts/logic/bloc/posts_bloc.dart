import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '/core/strings/success_strings.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/post.dart';
import '../../data/repo/posts_repo.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepo postsRepo;

  List<Post> posts = [];
  PostsBloc({required this.postsRepo}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is GetAllPostsEvent) {
        emit(PostsLoadingState());
        final either = await postsRepo.getAllPosts();
        emit(_getFetchingPostsNextStateAfterEitherFolding(either));
      } else {
        emit(PostsOperationLoadingState());
        if (event is AddPostEvent) {
          final either = await postsRepo.addPost(event.addedPost);
          emit(_getPostsOperationNextStateAfterEitherFolding(either,
              successMsg: kPostAddedSuccessfullyString));
        } else if (event is DeletePostEvent) {
          final either = await postsRepo.deletePost(event.postId);
          emit(_getPostsOperationNextStateAfterEitherFolding(either,
              successMsg: kPostDeletedSuccessfullyString));
        } else if (event is UpdatePostEvent) {
          final either = await postsRepo.updatePost(event.editedPost);
          emit(_getPostsOperationNextStateAfterEitherFolding(either,
              successMsg: kPostUpdatedSuccessfullyString));
        }
      }
    });
  }

  PostsState _getFetchingPostsNextStateAfterEitherFolding(
      Either<Failure, List<Post>> either) {
    return either.fold(
        (failure) => PostsGettingAllDataFailedState(_mapFailureToMsg(failure)),
        (posts) {
      this.posts = posts;
      return PostsGetAllPostsSuccessfullyState(posts);
    });
  }

  PostsState _getPostsOperationNextStateAfterEitherFolding(
      Either<Failure, Unit> either,
      {required String successMsg}) {
    return either
        .fold((failure) => PostsOperationFailedState(_mapFailureToMsg(failure)),
            (unit) {
      add(GetAllPostsEvent());
      return PostsOperationSuccessState(successMsg);
    });
  }

  String _mapFailureToMsg(Failure failure) => failure.failureMsg;
}
