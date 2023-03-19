import 'dart:convert';

import 'package:jwt_manager/src/exception.dart';
import 'package:jwt_manager/src/token.dart';
import 'package:jwt_manager/src/tools.dart';

import 'signifier.dart';

/// JwtBuilder
///
/// Builds and encodes to string JWT token using [Signifier] for making
/// a signature.
class JwtBuilder {
  JwtBuilder({
    required Signifier signifier,
  }) : _signifier = signifier;

  final Signifier _signifier;

  /// Creates a string with format: "header.payload.signature" for JWT token.
  /// Can throw [JwtException].
  String buildToken(TokenDto tokenDto) {
    try {
      return _buildToken(tokenDto);
    } on JwtException {
      rethrow;
    } catch (e, st) {
      throw JwtBuilderException('buildToken exception',
          details: e, stackTrace: st);
    }
  }

  String _buildToken(TokenDto tokenDto) {
    final encodedHeader = _encode(tokenDto.buildHeader());
    final encodedClaims = _encode(tokenDto.buildClaims());

    final dataToSign = '$encodedHeader.$encodedClaims';
    final signature = _signifier.sign(dataToSign);

    return '$encodedHeader.$encodedClaims.$signature';
  }

  String _encode(Map<String, Object> body) {
    return removePaddings(base64Url.encode(utf8.encode(json.encode(body))));
  }
}

class JwtBuilderException extends JwtException {
  JwtBuilderException(super.message, {super.details, super.stackTrace});
}
