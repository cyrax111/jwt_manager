String removePaddings(String encoded) {
  return encoded.replaceAll(RegExp('='), '');
}
