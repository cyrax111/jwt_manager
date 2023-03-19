import 'dart:convert';
import 'dart:typed_data';

import 'package:jwt_manager/src/tools.dart';
import 'package:pointycastle/export.dart';

abstract class Signifier {
  String sign(String dataToSign);
}

class RsaSignifier implements Signifier {
  RsaSignifier({
    required this.privateKey,
  });
  final PrivateKey privateKey;

  @override
  String sign(String dataToSign) {
    //final signer = Signer('SHA-256/RSA'); // Get using registry
    final signer = RSASigner(SHA256Digest(), '0609608648016503040201');

    // initialize with true, which means sign
    signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));

    final sig =
        signer.generateSignature(Uint8List.fromList(utf8.encode((dataToSign))));

    return removePaddings(base64Url.encode(sig.bytes));
  }
}
