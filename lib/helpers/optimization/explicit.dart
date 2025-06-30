class Explicit {
  Explicit._();

  static String clean(String str, {bool strong = false}) {
    if (strong) {
      str = fixExplicit(str)
          .replaceAll("bitches", "*****")
          .replaceAll("Bitches", "*****")
          .replaceAll("bitch", "*****")
          .replaceAll("Bitch", "*****")
          .replaceAll("damn", "****")
          .replaceAll("Damn", "****")
          .replaceAll("dammit", "******")
          .replaceAll("Dammit", "******")
          .replaceAll("dick", "****")
          .replaceAll("Dick", "****")
          .replaceAll("dope", "****")
          .replaceAll("Dope", "****")
          .replaceAll("fuck", "****")
          .replaceAll("Fuck", "****")
          .replaceAll("nigga", "*****")
          .replaceAll("Nigga", "*****")
          .replaceAll("nigras", "******")
          .replaceAll("Nigras", "******")
          .replaceAll("pussy", "*****")
          .replaceAll("Pussy", "*****")
          .replaceAll("sex", "***")
          .replaceAll("Sex", "***")
          .replaceAll("shit", "****")
          .replaceAll("Shit", "****")
          .replaceAll("weed", "****")
          .replaceAll("Weed", "****")
          .replaceAll("whore", "*****")
          .replaceAll("Whore", "*****")
          .replaceAll("cocaine", "*******")
          .replaceAll("Cocaine", "*******")
          .replaceAll("drug", "****")
          .replaceAll("Drug", "****");
      // Fix ass
      for (int i = 0; i < str.length - 2; i++) {
        if (str.substring(i, i + 3) == "ass") {
          if (i > 0 && str[i - 1] != ' ' && str[i - 1] != '-') {
            i += 2;
            continue;
          } else if (i + 3 < str.length && str[i + 3] != ' ' && str[i + 3] != '-') {
            i += 2;
            continue;
          }
          str = str.substring(0, i) + "***" + str.substring(i + 3);
          i += 2;
        }
      }
      // Fix Ass
      for (int i = 0; i < str.length - 2; i++) {
        if (str.substring(i, i + 3) == "Ass") {
          if (i > 0 && str[i - 1] != ' ' && str[i - 1] != '-') {
            i += 2;
            continue;
          } else if (i + 3 < str.length && str[i + 3] != ' ' && str[i + 3] != '-') {
            i += 2;
            continue;
          }
          str = str.substring(0, i) + "***" + str.substring(i + 3);
          i += 2;
        }
      }
      // Fix hoe
      for (int i = 0; i < str.length - 2; i++) {
        if (str.substring(i, i + 3) == "hoe") {
          if (i > 0 && str[i - 1] != ' ' && str[i - 1] != '-') {
            i += 2;
            continue;
          } else if (i + 3 < str.length && str[i + 3] != ' ' && str[i + 3] != '-') {
            i += 2;
            continue;
          }
          str = str.substring(0, i) + "***" + str.substring(i + 3);
          i += 2;
        }
      }
    } else {
      str = str
          .replaceAll("bitch", "b***h")
          .replaceAll("Bitch", "B***h")
          .replaceAll("damn", "d**n")
          .replaceAll("Damn", "D**n")
          .replaceAll("dammit", "D**mit")
          .replaceAll("Dammit", "D**mit")
          .replaceAll("dick", "d**k")
          .replaceAll("Dick", "D**k")
          .replaceAll("dope", "d**e")
          .replaceAll("Dope", "D**e")
          .replaceAll("fuck", "f**k")
          .replaceAll("Fuck", "F**k")
          .replaceAll("nigga", "n***a")
          .replaceAll("Nigga", "N***a")
          .replaceAll("nigras", "n***as")
          .replaceAll("Nigras", "N***as")
          .replaceAll("pussy", "p***y")
          .replaceAll("Pussy", "P***y")
          .replaceAll("sex", "s*x")
          .replaceAll("Sex", "S*x")
          .replaceAll("shit", "s**t")
          .replaceAll("Shit", "S**t")
          .replaceAll("weed", "w**d")
          .replaceAll("Weed", "W**d")
          .replaceAll("whore", "w***e")
          .replaceAll("Whore", "W***e");
      // Fix ass
      for (int i = 0; i < str.length - 2; i++) {
        if (str.substring(i, i + 3) == "ass") {
          if (i > 0 && str[i - 1] != ' ' && str[i - 1] != '-') {
            i += 2;
            continue;
          } else if (i + 3 < str.length && str[i + 3] != ' ' && str[i + 3] != '-') {
            i += 2;
            continue;
          }
          str = str.substring(0, i) + "a*s" + str.substring(i + 3);
          i += 2;
        }
      }
      // Fix Ass
      for (int i = 0; i < str.length - 2; i++) {
        if (str.substring(i, i + 3) == "Ass") {
          if (i > 0 && str[i - 1] != ' ' && str[i - 1] != '-') {
            i += 2;
            continue;
          } else if (i + 3 < str.length && str[i + 3] != ' ' && str[i + 3] != '-') {
            i += 2;
            continue;
          }
          str = str.substring(0, i) + "A*s" + str.substring(i + 3);
          i += 2;
        }
      }
      // Fix hoe
      for (int i = 0; i < str.length - 2; i++) {
        if (str.substring(i, i + 3) == "hoe") {
          if (i > 0 && str[i - 1] != ' ' && str[i - 1] != '-') {
            i += 2;
            continue;
          } else if (i + 3 < str.length && str[i + 3] != ' ' && str[i + 3] != '-') {
            i += 2;
            continue;
          }
          str = str.substring(0, i) + "h*e" + str.substring(i + 3);
          i += 2;
        }
      }
    }
    return str;
  }

  static String fixExplicit(String str) {
    for (var replacement in _replacements) {
      str = str.replaceAllMapped(RegExp(replacement.pattern, caseSensitive: false), (match) {
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