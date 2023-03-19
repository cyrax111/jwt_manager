import 'package:pointycastle/export.dart';
import 'package:rsa_pkcs/rsa_pkcs.dart' as rsa;

import 'exception.dart';

abstract class KeyParser {
  PrivateKey extractPrivateKey(String pem);
  PublicKey extractPublicKey(String pem);
}

class RsaKeyParser implements KeyParser {
  @override
  PrivateKey extractPrivateKey(String pem) {
    try {
      return _extractPrivateKey(pem);
    } on KeyParserException {
      rethrow;
    } catch (e, st) {
      throw KeyParserException('extract private key exception',
          details: e, stackTrace: st);
    }
  }

  PrivateKey _extractPrivateKey(String pem) {
    final pair = _extractKeyPair(pem);
    final privateKey = pair.private;
    if (privateKey == null) {
      throw KeyParserException('No private key found');
    }
    return RSAPrivateKey(privateKey.modulus, privateKey.privateExponent,
        privateKey.prime1, privateKey.prime2);
  }

  @override
  PublicKey extractPublicKey(String pem) {
    try {
      return _extractPublicKey(pem);
    } on KeyParserException {
      rethrow;
    } catch (e, st) {
      throw KeyParserException('extract public key exception',
          details: e, stackTrace: st);
    }
  }

  PublicKey _extractPublicKey(String pem) {
    final pair = _extractKeyPair(pem);
    final publicKey = pair.public;
    if (publicKey == null) {
      throw KeyParserException('No public key found');
    }
    return RSAPublicKey(
        publicKey.modulus, BigInt.from(publicKey.publicExponent));
  }

  rsa.RSAKeyPair _extractKeyPair(String pem) {
    final parser = rsa.RSAPKCSParser();
    final pair = parser.parsePEM(pem);
    return pair;
  }
}

class KeyParserException extends JwtException {
  KeyParserException(super.message, {super.details, super.stackTrace});
}
