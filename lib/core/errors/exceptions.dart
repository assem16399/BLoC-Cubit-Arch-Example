import 'package:dio/dio.dart';

class ServerException extends DioError implements Exception {
  ServerException({required super.requestOptions});
}

class NoInternetException implements Exception {}

class CacheException implements Exception {}
