class LyricifyLines {
  LyricifyLines._();

  static bool isLyricifyLines(String? input) {
    if (input == null) return false;

    if (input.contains("[type:LyricifyLines]")) return true;

    final regex = RegExp(r'^\[\d+,\d+\].*');
    final matches = regex.allMatches(input);
    if (matches.isNotEmpty) {
      final syllableRegex = RegExp(r'\w+\(\d+,\d+\)');
      final syllableMatches = syllableRegex.allMatches(input);
      return syllableMatches.length <= matches.length;
    }

    return false;
  }
} 