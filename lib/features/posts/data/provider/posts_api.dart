import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/network/remote/dio_helper.dart';
import '../../../../core/components/constants/endpoints.dart';

abstract class PostsApi {
  Future<Map<String, dynamic>> getPosts();
  Future<Unit> updatePost(Map<String, dynamic> postRawData);
  Future<Unit> deletePost(String postId);
  Future<Unit> addPost(Map<String, dynamic> postRawData);
}

class PostsApiWithDioImpl implements PostsApi {
  @override
  Future<Unit> addPost(Map<String, dynamic> postRawData) async {
    await DioHelper.postRequest(path: kPostsEndpoint, data: postRawData);
    return unit;
  }

  @override
  Future<Unit> deletePost(String postId) async {
    await DioHelper.deleteRequest(path: '$kPostsEndpoint/$postId');
    return unit;
  }

  @override
  Future<Map<String, dynamic>> getPosts() async {
    // TODO: implement getPosts
    final response = await DioHelper.getRequest(path: kPostsEndpoint);

    if (_canBeParsed(response)) {
      return response.data;
    } else {
      return {};
    }
  }

  bool _canBeParsed(Response response) {
    if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
      return true;
    }
    return false;
  }

  @override
  Future<Unit> updatePost(Map<String, dynamic> postRawData) async {
    final updatedPostId = postRawData['id'];
    await DioHelper.patchRequest(
        path: '$kPostsEndpoint/$updatedPostId', data: postRawData);
    return unit;
  }
}
