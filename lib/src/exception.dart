abstract class JwtException implements Exception {
  JwtException(this.message);
  final Object message;
}
