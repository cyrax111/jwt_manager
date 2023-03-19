# JWT manager

An easy-to-use pure dart JWT manager that creates JWT tokens and verifies a signature.

## Features

### Creating an encoded JWT token

```dart
// Creating a token
final tokenDto = FcmTokenDto(
iss: 'some@email.com',
iat: DateTime(2001),
);
final pemPrivateKey = '-----BEGIN PRIVATE KEY-----...';

// RsaKeyParser extracts private key from a pem string
final parser = RsaKeyParser();
final rsaPrivateKey = parser.extractPrivateKey(pemPrivateKey);

// Create RsaSignifier for signing
final rsaSignifier = RsaSignifier(privateKey: rsaPrivateKey);

// JwtBuilder encodes the token to string and signs it
final jwtBuilder = JwtBuilder(signifier: rsaSignifier);
final jwtToken = jwtBuilder.buildToken(tokenDto);

print('Encoded JWT: $jwtToken');
```

### Verifying a signature of jwt token

```dart
final pemPublicKey = '-----BEGIN PUBLIC KEY-----...'

// Extract public key from a pem string
final rsaPublicKey = parser.extractPublicKey(pemPublicKey);

// Verifying the signature
final rsaVerifier = RsaSignatureVerifier(publicKey: rsaPublicKey);
final isVerified = rsaVerifier.verify('signedData', 'signature');

print('Is signature verified: $isVerified');
```

### Extra example

You can also use the full working [example](https://github.com/cyrax111/jwt_manager/tree/master/example) from github.

## Ideas

If you have any ideas on how to enhance this package or have any concern, feel free to make an [issue](https://github.com/cyrax111/jwt_manager/issues).
