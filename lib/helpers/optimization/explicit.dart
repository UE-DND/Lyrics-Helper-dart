class Explicit {
  Explicit._();

  static String clean(String str, {bool strong = false}) {
    if (strong) {
      str = fixExplicit(str)
          .replaceAll(RegExp(r'\bbitches\b', caseSensitive: false), "*****")
          .replaceAll(RegExp(r'\bbitch\b', caseSensitive: false), "*****")
          .replaceAll(RegExp(r'\bdamn\b', caseSensitive: false), "****")
          .replaceAll(RegExp(r'\bdammit\b', caseSensitive: false), "******")
          .replaceAll(RegExp(r'\bdick\b', caseSensitive: false), "****")
          .replaceAll(RegExp(r'\bdope\b', caseSensitive: false), "****")
          .replaceAll(RegExp(r'\bfuck\b', caseSensitive: false), "****")
          .replaceAll(RegExp(r'\bnigga\b', caseSensitive: false), "*****")
          .replaceAll(RegExp(r'\bnigras\b', caseSensitive: false), "******")
          .replaceAll(RegExp(r'\bpussy\b', caseSensitive: false), "*****")
          .replaceAll(RegExp(r'\bsex\b', caseSensitive: false), "***")
          .replaceAll(RegExp(r'\bshit\b', caseSensitive: false), "****")
          .replaceAll(RegExp(r'\bweed\b', caseSensitive: false), "****")
          .replaceAll(RegExp(r'\bwhore\b', caseSensitive: false), "*****")
          .replaceAll(RegExp(r'\bcocaine\b', caseSensitive: false), "*******")
          .replaceAll(RegExp(r'\bdrug\b', caseSensitive: false), "****")
          .replaceAll(RegExp(r'\bass\b', caseSensitive: false), "***")
          .replaceAll(RegExp(r'\bhoe\b', caseSensitive: false), "***");
    } else {
      str = str
          .replaceAllMapped(RegExp(r'\b(b)it(ch)\b', caseSensitive: false),
              (m) => '${m[1]}***${m[2]}')
          .replaceAllMapped(RegExp(r'\b(b)itch(es)\b', caseSensitive: false),
              (m) => '${m[1]}*****${m[2]}')
          .replaceAllMapped(RegExp(r'\b(d)am(n)\b', caseSensitive: false),
              (m) => '${m[1]}**${m[2]}')
          .replaceAllMapped(RegExp(r'\b(d)ammi(t)\b', caseSensitive: false),
              (m) => '${m[1]}**${m[2]}')
          .replaceAllMapped(RegExp(r'\b(d)ic(k)\b', caseSensitive: false),
              (m) => '${m[1]}**${m[2]}')
          .replaceAllMapped(RegExp(r'\b(d)o(pe)\b', caseSensitive: false),
              (m) => '${m[1]}**${m[2]}')
          .replaceAllMapped(RegExp(r'\b(f)u(ck)\b', caseSensitive: false),
              (m) => '${m[1]}**${m[2]}')
          .replaceAllMapped(RegExp(r'\b(n)ig(ga)\b', caseSensitive: false),
              (m) => '${m[1]}***${m[2]}')
          .replaceAllMapped(RegExp(r'\b(n)ig(ras)\b', caseSensitive: false),
              (m) => '${m[1]}***${m[2]}')
          .replaceAllMapped(RegExp(r'\b(p)us(sy)\b', caseSensitive: false),
              (m) => '${m[1]}***${m[2]}')
          .replaceAllMapped(RegExp(r'\b(s)e(x)\b', caseSensitive: false),
              (m) => '${m[1]}*${m[2]}')
          .replaceAllMapped(RegExp(r'\b(s)hi(t)\b', caseSensitive: false),
              (m) => '${m[1]}**${m[2]}')
          .replaceAllMapped(RegExp(r'\b(w)ee(d)\b', caseSensitive: false),
              (m) => '${m[1]}**${m[2]}')
          .replaceAllMapped(RegExp(r'\b(w)ho(re)\b', caseSensitive: false),
              (m) => '${m[1]}***${m[2]}')
          .replaceAllMapped(RegExp(r'\b(a)s(s)\b', caseSensitive: false),
              (m) => '${m[1]}*${m[2]}')
          .replaceAllMapped(RegExp(r'\b(h)o(e)\b', caseSensitive: false),
              (m) => '${m[1]}*${m[2]}');
    }
    return str;
  }

  static String fixExplicit(String str) {
    for (var replacement in _replacements) {
      str = str.replaceAllMapped(
          RegExp(replacement.pattern, caseSensitive: false), (match) {
        String original = match.group(0)!;
        String replaced = replacement.replacement;
        return original[0].toUpperCase() == original[0]
            ? replaced[0].toUpperCase() + replaced.substring(1)
            : replaced;
      });
    }
    return str;
  }

  static final List<({String pattern, String replacement})> _replacements = [
    (pattern: "a\\*s", replacement: "ass"),
    (pattern: "a\\*\\*", replacement: "ass"),
    (pattern: "b\\*{3}h", replacement: "bitch"),
    (pattern: "b\\*{2}ch", replacement: "bitch"),
    (pattern: "b\\*{5}s", replacement: "bitches"),
    (pattern: "d\\*{2}n", replacement: "damn"),
    (pattern: "d\\*{2}mit", replacement: "dammit"),
    (pattern: "d\\*{2}k", replacement: "dick"),
    (pattern: "d\\*{2}e", replacement: "dope"),
    (pattern: "f\\*{2}k", replacement: "fuck"),
    (pattern: "f\\*ck", replacement: "fuck"),
    (pattern: "fu\\*k", replacement: "fuck"),
    (pattern: "h\\*e", replacement: "hoe"),
    (pattern: "h\\*{2}s", replacement: "hoes"),
    (pattern: "mother\\*{4}", replacement: "motherfuck"),
    (pattern: "n\\*{3}a", replacement: "nigga"),
    (pattern: "n\\*{2}ga", replacement: "nigga"),
    (pattern: "ni\\*{2}a", replacement: "nigga"),
    (pattern: "n\\*{3}as", replacement: "nigras"),
    (pattern: "p\\*{3}y", replacement: "pussy"),
    (pattern: "p\\*{2}sy", replacement: "pussy"),
    (pattern: "sh\\*t", replacement: "shit"),
    (pattern: "s\\*x", replacement: "sex"),
    (pattern: "s\\*{2}t", replacement: "shit"),
    (pattern: "w\\*{2}d", replacement: "weed"),
    (pattern: "w\\*{3}e", replacement: "whore"),
    (pattern: "c\\*{4}e", replacement: "cocaine"),
    (pattern: "d\\*{2}g", replacement: "drug")
  ];
}
