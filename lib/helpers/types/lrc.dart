class Lrc {
  Lrc._();

  static bool isLrc(String? input) {
    if (input == null) return false;

    final pattern = RegExp(r'\[\d+:\d+\.\d+\](.+)');
    return pattern.hasMatch(input);
  }
} 