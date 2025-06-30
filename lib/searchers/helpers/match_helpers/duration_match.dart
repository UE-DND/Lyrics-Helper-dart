/// 时长匹配工具，移植自 C# `DurationMatch.cs`。
class DurationMatchHelper {
  /// 比较时长匹配程度
  ///
  /// [duration1] 原曲目的时长（毫秒）
  /// [duration2] 搜索结果的时长（毫秒）
  static DurationMatchType? compareDuration(int? duration1, int? duration2) {
    if (duration1 == null || duration2 == null || duration1 == 0 || duration2 == 0) {
      return null;
    }

    final diff = (duration1 - duration2).abs();
    if (diff == 0) {
      return DurationMatchType.perfect;
    } else if (diff < 300) {
      return DurationMatchType.veryHigh;
    } else if (diff < 700) {
      return DurationMatchType.high;
    } else if (diff < 1500) {
      return DurationMatchType.medium;
    } else if (diff < 3500) {
      return DurationMatchType.low;
    } else {
      return DurationMatchType.noMatch;
    }
  }
}

/// 时长匹配程度
enum DurationMatchType {
  perfect,
  veryHigh,
  high,
  medium,
  low,
  noMatch,
}

extension DurationMatchScore on DurationMatchType? {
  int getMatchScore() {
    switch (this) {
      case DurationMatchType.perfect:
        return 7;
      case DurationMatchType.veryHigh:
        return 6;
      case DurationMatchType.high:
        return 5;
      case DurationMatchType.medium:
        return 4;
      case DurationMatchType.low:
        return 2;
      case DurationMatchType.noMatch:
        return 0;
      default:
        return 0;
    }
  }
} 