import 'dart:convert';

import 'package:jwt_manager/src/exception.dart';
import 'package:jwt_manager/src/token.dart';
import 'package:jwt_manager/src/tools.dart';

import 'signifier.dart';

class JwtBuilder {
  JwtBuilder({
    required this.tokenDto,
    required Signifier signifier,
  }) : _signifier = signifier;

  final TokenDto tokenDto;

  final Signifier _signifier;

  String buildToken() {
    try {
      return _buildToken();
    } on JwtException {
      rethrow;
    } catch (e) {
      throw JwtBuilderException(e);
    }
  }

  String _buildToken() {
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
  JwtBuilderException(super.message);
}
