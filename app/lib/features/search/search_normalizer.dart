class SearchNormalizer {
  const SearchNormalizer();

  String normalize(String input) {
    return _toHalfWidth(input)
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), '')
        .replaceAll('-', '')
        .replaceAll('_', '')
        .replaceAll('・', '')
        .replaceAll('　', '');
  }

  String _toHalfWidth(String input) {
    final buffer = StringBuffer();

    for (final codeUnit in input.codeUnits) {
      if (codeUnit == 0x3000) {
        buffer.writeCharCode(0x20);
      } else if (codeUnit >= 0xFF01 && codeUnit <= 0xFF5E) {
        buffer.writeCharCode(codeUnit - 0xFEE0);
      } else {
        buffer.writeCharCode(codeUnit);
      }
    }

    return buffer.toString();
  }
}
