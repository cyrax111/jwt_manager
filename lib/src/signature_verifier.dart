import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

abstract class SignatureVerifier {
  bool verify(String signedData, String base64signature);
}

class RsaSignatureVerifier implements SignatureVerifier {
  RsaSignatureVerifier({
    required this.publicKey,
  });
  final PublicKey publicKey;
  @override
  bool verify(String signedData, String base64signature) {
    return _rsaVerify(publicKey, utf8.encode(signedData) as Uint8List,
        base64Url.decode(base64Url.normalize(base64signature)));
  }

  bool _rsaVerify(
      PublicKey publicKey, Uint8List signedData, Uint8List signature) {
    final sig = RSASignature(signature);
    final verifier = RSASigner(SHA256Digest(), '0609608648016503040201');
    verifier.init(false, PublicKeyParameter<RSAPublicKey>(publicKey));
    return verifier.verifySignature(signedData, sig);
  }
}
