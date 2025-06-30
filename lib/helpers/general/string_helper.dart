/// 字符串处理辅助类
class StringHelper {
  /// 移除字符串前后的括号
  static String removeFrontBackBrackets(String text) {
    if (text.isEmpty) {
      return text;
    }

    if (text.startsWith('(') && text.endsWith(')')) {
      return text.substring(1, text.length - 1);
    }
    return text;
  }

  /// 比较两个字符串是否相等，null、空字符串判断为相等
  static bool isSame(String? str1, String? str2) {
    if (str1 == str2) return true;
    if ((str1 == null || str1.isEmpty) && (str2 == null || str2.isEmpty))
      return true;
    return false;
  }

  /// 比较两个字符串是否相等，null、空字符串、空格字符串判断为相等
  static bool isSameWhiteSpace(String? str1, String? str2) {
    if (str1 == str2) return true;
    if ((str1 == null || str1.trim().isEmpty) &&
        (str2 == null || str2.trim().isEmpty)) return true;
    return false;
  }

  /// 比较两个字符串在 Trim 后是否相等
  static bool isSameTrim(String? str1, String? str2) {
    final s1 = (str1 ?? '').trim();
    final s2 = (str2 ?? '').trim();
    if (s1 == s2) return true;
    if (s1.isEmpty && s2.isEmpty) return true;
    return false;
  }

  /// 将毫秒数转换为时间戳字符串
  ///
  /// [timeMs] 毫秒数
  /// [millisecond] 字符串中是否保留毫秒位
  /// 返回时间戳字符串
  static String formatTimeMsToTimestampString(int timeMs,
      {bool millisecond = true}) {
    if (timeMs < 0) {
      return "0:00";
    }
    int second;
    int minute = 0;
    second = timeMs ~/ 1000;
    if (second >= 60) {
      minute = second ~/ 60;
      second %= 60;
    }

    if (millisecond) {
      return "${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}.${(timeMs % 1000).toString().padLeft(3, '0')}";
    } else {
      return "${minute.toString()}:${second.toString().padLeft(2, '0')}";
    }
  }

  /// 获取字符串的毫秒数
  ///
  /// [time] 时长字符串
  /// 返回毫秒数，解析失败返回 null
  static int? getMillisecondsFromString(String time) {
    try {
      if (!time.contains(':')) {
        if (time.contains('.')) {
          final times = time.split('.');
          if (times.length == 2) {
            return int.parse(times[0]) * 1000 + int.parse(times[1]);
          }
        } else {
          return int.parse(time);
        }
      } else {
        int timeTotal = 0;
        final times = time.split(':');
        if (times.length == 2) {
          final minutes = int.parse(times[0]);
          String secondsStr = times[1];
          double seconds;

          if (secondsStr.contains('.')) {
            seconds = double.parse(secondsStr);
          } else {
            seconds = int.parse(secondsStr).toDouble();
          }

          timeTotal = (minutes * 60 * 1000 + seconds * 1000).round();
          return timeTotal;
        }
      }
    } catch (e) {
      // 解析错误
    }
    return null;
  }

  /// 移除两个及以上的空格
  static String removeDuoSpaces(String str) {
    while (str.contains("  ")) {
      str = str.replaceAll("  ", " ");
    }
    return str;
  }

  /// 移除三个及以上的空格
  static String removeTripleSpaces(String str) {
    while (str.contains("   ")) {
      str = str.replaceAll("   ", "  ");
    }
    return str;
  }

  /// 确保逗号后有且仅有一个空格
  static String fixCommaAfterSpace(String str) {
    str = str.replaceAll(",", ", ");
    return removeDuoSpaces(str);
  }

  /// 移除多个换行符
  static String removeDuoBackslashN(String? str) {
    if (str == null) return '';
    String result = str;
    while (result.contains("\n\n")) {
      result = result.replaceAll("\n\n", "\n");
    }
    return result;
  }

  /// 移除 \r
  static String removeBackslashR(String? str) {
    if (str == null) return '';
    return str.replaceAll("\r", "");
  }

  /// 首字母大写
  static String toUpperFirst(String str, {int start = 0}) {
    if (str.isEmpty || start >= str.length) return str;
    return str.substring(0, start) +
        str[start].toUpperCase() +
        (start + 1 < str.length ? str.substring(start + 1) : '');
  }

  /// 提取两个字符串之间的内容
  static String between(String str, String start, String end) {
    if (str.isEmpty) return '';

    final startIndex = str.indexOf(start);
    if (startIndex == -1) return '';

    final startPos = startIndex + start.length;
    final endIndex = str.indexOf(end, startPos);

    if (endIndex == -1) return '';

    return str.substring(startPos, endIndex);
  }

  /// 反转字符串
  static String reverse(String str) {
    if (str.isEmpty) return '';
    return String.fromCharCodes(str.runes.toList().reversed);
  }

  /// 移除字符串中的指定子串
  static String remove(String str, String substring) {
    return str.replaceAll(substring, '');
  }

  /// 判断是否为数字
  static bool isNumber(String str) {
    if (str.isEmpty) return false;
    return double.tryParse(str) != null;
  }

  /// 计算文本相似度 (适用于短文本)
  /// 返回 0-100
  static double computeTextSame(String textX, String textY,
      {bool isCase = false}) {
    if (textX.isEmpty || textY.isEmpty) {
      return 0;
    }
    if (!isCase) {
      textX = textX.toLowerCase();
      textY = textY.toLowerCase();
    }
    final m = textX.length;
    final n = textY.length;
    // 创建二维数组 (m+1)*(n+1)
    final dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));
    for (var i = 0; i < m; i++) {
      for (var j = 0; j < n; j++) {
        if (textX[i] == textY[j]) {
          dp[i + 1][j + 1] = dp[i][j] + 1;
        } else {
          dp[i + 1][j + 1] =
              dp[i][j + 1] > dp[i + 1][j] ? dp[i][j + 1] : dp[i + 1][j];
        }
      }
    }
    final lcs = dp[m][n];
    return (lcs / (m > n ? m : n) * 100).toDouble();
  }
}

/// 字符串扩展方法
extension StringExtensions on String {
  /// 移除字符串前后的括号
  String removeFrontBackBrackets() {
    return StringHelper.removeFrontBackBrackets(this);
  }

  /// 比较是否相等，null、空字符串判断为相等
  bool isSame(String? other) {
    return StringHelper.isSame(this, other);
  }

  /// 比较是否相等，null、空字符串、空格字符串判断为相等
  bool isSameWhiteSpace(String? other) {
    return StringHelper.isSameWhiteSpace(this, other);
  }

  /// 比较Trim后是否相等
  bool isSameTrim(String? other) {
    return StringHelper.isSameTrim(this, other);
  }

  /// 移除两个及以上的空格
  String removeDuoSpaces() {
    return StringHelper.removeDuoSpaces(this);
  }

  /// 移除三个及以上的空格
  String removeTripleSpaces() {
    return StringHelper.removeTripleSpaces(this);
  }

  /// 确保逗号后有且仅有一个空格
  String fixCommaAfterSpace() {
    return StringHelper.fixCommaAfterSpace(this);
  }

  /// 移除多个换行符
  String removeDuoBackslashN() {
    return StringHelper.removeDuoBackslashN(this);
  }

  /// 移除 \r
  String removeBackslashR() {
    return StringHelper.removeBackslashR(this);
  }

  /// 首字母大写
  String toUpperFirst({int start = 0}) {
    return StringHelper.toUpperFirst(this, start: start);
  }

  /// 提取两个字符串之间的内容
  String between(String start, String end) {
    return StringHelper.between(this, start, end);
  }

  /// 反转字符串
  String reverse() {
    return StringHelper.reverse(this);
  }

  /// 移除字符串中的指定子串
  String remove(String substring) {
    return StringHelper.remove(this, substring);
  }

  /// 判断是否为数字
  bool isNumber() {
    return StringHelper.isNumber(this);
  }
}
