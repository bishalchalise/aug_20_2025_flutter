// core/errors/exceptions.dart
class ServerException implements Exception {
  final String message;

  const ServerException(this.message);
}
