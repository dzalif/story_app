import '../constants/constant_message.dart';

abstract class Failure {
  String get errorMessage;
  Map? get response;
}

/// Handle on invalid request sent from app
class InvalidRequestFailure implements Failure {
  final Map? data;
  const InvalidRequestFailure(this.data);

  @override
  String get errorMessage => data?['message'] ?? ConstantMessage.invalidRequest;

  @override
  Map? get response => data;
}

/// Handle on server returning unauthorized response
class UnauthorizedFailure implements Failure {
  final Map? data;
  const UnauthorizedFailure(this.data);

  @override
  String get errorMessage =>
      data?['message'] ?? ConstantMessage.unauthorizedRequest;

  @override
  Map? get response => data;
}

/// Handle on server exception
class FetchDataFailure implements Failure {
  final String message;
  const FetchDataFailure(this.message);

  @override
  String get errorMessage => message;

  @override
  Map? get response => {};
}

/// Handle on no internet connection
class NoConnectionFailure implements Failure {
  @override
  String get errorMessage => ConstantMessage.noInternetConnection;

  @override
  Map? get response => {};
}

/// Handle on no internet connection
class TimeoutFailure implements Failure {
  @override
  String get errorMessage => ConstantMessage.timeoutRequest;

  @override
  Map? get response => {};
}

/// Handle on cache failure
class CacheFailure implements Failure {
  final String message;
  const CacheFailure(this.message);

  @override
  String get errorMessage => message;

  @override
  Map? get response => {};
}
