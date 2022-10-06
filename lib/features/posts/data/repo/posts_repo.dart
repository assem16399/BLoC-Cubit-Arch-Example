import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/errors/failures.dart';
import '/core/network/network_info.dart';
import '/features/posts/data/provider/posts_api.dart';
import '../models/post.dart';

abstract class PostsRepo {
  Future<Either<Failure, List<Post>>> getAllPosts();

  Future<Either<Failure, Unit>> addPost(Post post);

  Future<Either<Failure, Unit>> updatePost(Post post);

  Future<Either<Failure, Unit>> deletePost(String id);
}

class PostsRepoImpl implements PostsRepo {
  final PostsApi postsApi;
  final NetworkInfo networkInfo;

  PostsRepoImpl({required this.postsApi, required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      return await _handleGettingAllPosts();
    } else {
      return Left(NoInternetFailure());
    }
  }

  Future<Either<Failure, List<Post>>> _handleGettingAllPosts() async {
    try {
      final postsRawData = await postsApi.getPosts();
      final posts = <Post>[];
      postsRawData.forEach((fbId, postRawData) {
        posts.add(Post.fromJson(postRawData));
      });
      return Right(posts);
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        return Left(TimeoutFailure());
      }
      return Left(ServerFailure());
    } catch (_) {
      return Left(UndefinedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final postRawData = post.toJson();
    return await _handlePostOperation(() => postsApi.addPost(postRawData));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(String id) async {
    return await _handlePostOperation(() => postsApi.deletePost(id));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final updatedPostRawData = post.toJson();
    return await _handlePostOperation(
        () => postsApi.updatePost(updatedPostRawData));
  }

  Future<Either<Failure, Unit>> _handlePostOperation(
      Future<Unit> Function() postOperation) async {
    if (await networkInfo.isConnected) {
      try {
        await postOperation();
        return const Right(unit);
      } on DioError catch (error) {
        if (error.type == DioErrorType.connectTimeout) {
          return Left(TimeoutFailure());
        }
        return Left(ServerFailure());
      } catch (_) {
        return Left(UndefinedFailure());
      }
    }
    return Left(NoInternetFailure());
  }
}
