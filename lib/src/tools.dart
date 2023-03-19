mixin SignatureTool {
  static const digestIdentifierSHA256 = '0609608648016503040201';
  String removePaddings(String encoded) {
    return encoded.replaceAll(RegExp('='), '');
  }
}
