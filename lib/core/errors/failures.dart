import '../strings/failure_strings.dart';

abstract class Failure {
  String get failureMsg;
}

class NoInternetFailure extends Failure {
  @override
  // TODO: implement failureMsg
  String get failureMsg => kInternetFailureString;
}

//Failure for dio exceptions (i.e timeout, status codes errors)
class TimeoutFailure extends Failure {
  @override
  // TODO: implement failureMsg
  String get failureMsg => kServerTimeoutFailureString;
}

class ServerFailure extends Failure {
  @override
  // TODO: implement failureMsg
  String get failureMsg => kServerFailureString;
}

class CacheFailure extends Failure {
  @override
  // TODO: implement failureMsg
  String get failureMsg => kCacheFailureString;
}

class UndefinedFailure extends Failure {
  @override
  // TODO: implement failureMsg
  String get failureMsg => kUndefinedFailureString;
}
