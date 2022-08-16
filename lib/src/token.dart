// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class TokenDto {
  Map<String, Object> buildHeader();
  Map<String, Object> buildClaims();
}

class FcmTokenDto implements TokenDto {
  FcmTokenDto({
    DateTime? exp,
    DateTime? iat,
    this.alg = 'RS256',
    this.typ = 'JWT',
    required this.iss,
    this.scope = 'https://www.googleapis.com/auth/firebase.messaging',
    this.aud = 'https://oauth2.googleapis.com/token',
  })  : exp = (iat ?? DateTime.now()).add(const Duration(hours: 1)),
        iat = iat ?? DateTime.now();
  final String alg;
  final String typ;

  final String iss;
  final String scope;
  final String aud;
  final DateTime exp;
  final DateTime iat;

  @override
  Map<String, Object> buildHeader() {
    return {
      'alg': alg,
      'typ': typ,
    };
  }

  @override
  Map<String, Object> buildClaims() {
    return {
      "iss": iss,
      "scope": scope,
      "aud": aud,
      "exp": exp.millisecondsSinceEpoch ~/ 1000,
      "iat": iat.millisecondsSinceEpoch ~/ 1000,
    };
  }

  FcmTokenDto reissue() {
    final now = DateTime.now();
    return copyWith(iat: now, exp: now.add(const Duration(hours: 1)));
  }

  FcmTokenDto copyWith({
    String? alg,
    String? typ,
    String? iss,
    String? scope,
    String? aud,
    DateTime? exp,
    DateTime? iat,
  }) {
    return FcmTokenDto(
      alg: alg ?? this.alg,
      typ: typ ?? this.typ,
      iss: iss ?? this.iss,
      scope: scope ?? this.scope,
      aud: aud ?? this.aud,
      exp: exp ?? this.exp,
      iat: iat ?? this.iat,
    );
  }
}
