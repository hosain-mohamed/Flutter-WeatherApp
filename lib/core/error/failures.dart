import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class ServerFailure extends Failure {
  final String message;
  ServerFailure({this.message}) : super([message]);
}

class CacheFailure extends Failure {}

class InvalidInputFailure extends Failure {}

class LocationDisabledFailure extends Failure {}

class LocationPermessionFailure extends Failure {}
