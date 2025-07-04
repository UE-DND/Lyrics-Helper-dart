/// 艺人匹配工具，移植自 C# `ArtistMatch.cs`。
///
/// 该实现与原版算法保持一致，仅做 Dart 语法层面的调整。
class ArtistMatchHelper {
  /// 比较艺人匹配程度
  ///
  /// [artist1] 原曲目的艺人列表
  /// [artist2] 搜索结果中的艺人列表
  /// 返回 [ArtistMatchType] 或 null（任一列表为空时）
  static ArtistMatchType? compareArtist(
    Iterable<String>? artist1,
    Iterable<String>? artist2,
  ) {
    if (artist1 == null || artist2 == null) return null;

    final list1 = artist1.map((e) => e.toLowerCase()).toList();
    final list2 = artist2.map((e) => e.toLowerCase()).toList();

    // 统计匹配数量
    var count = 0;
    for (final art in list2) {
      if (list1.contains(art)) count++;
    }

    if (count == list1.length && list1.length == list2.length) {
      return ArtistMatchType.perfect;
    }

    if ((count + 1 >= list1.length && list1.length >= 2) ||
        (list1.length > 6 && count / list1.length > 0.8)) {
      return ArtistMatchType.veryHigh;
    }

    if (count == 1 && list1.length == 1 && list2.length == 2) {
      return ArtistMatchType.high;
    }

    if (list1.length > 5 &&
        (list2.first.contains('Various') || list2.first.contains('群星'))) {
      return ArtistMatchType.veryHigh;
    }

    if (list1.length > 7 && list2.length > 7 && count / list1.length > 0.66) {
      return ArtistMatchType.high;
    }

    if (list1.length == 1 &&
        list2.length > 1 &&
        list1.first.startsWith(list2.first)) {
      return ArtistMatchType.high;
    }

    if (list1.length == 1 &&
        list2.length > 1 &&
        list2.first.length > 3 &&
        list1.first.contains(list2.first)) {
      return ArtistMatchType.high;
    }

    if (list1.length == 1 &&
        list2.length > 1 &&
        list2.first.length > 1 &&
        list1.first.contains(list2.first)) {
      return ArtistMatchType.medium;
    }

    if (count == 1 && list1.length == 1 && list2.length >= 3) {
      return ArtistMatchType.medium;
    }

    if (count >= 2) {
      return ArtistMatchType.low;
    }

    return ArtistMatchType.noMatch;
  }
}

/// 艺人匹配程度
enum ArtistMatchType {
  perfect,
  veryHigh,
  high,
  medium,
  low,
  noMatch,
}

/// 扩展：为 [ArtistMatchType]（可空）提供分值转换
extension ArtistMatchScore on ArtistMatchType? {
  int getMatchScore() {
    switch (this) {
      case ArtistMatchType.perfect:
        return 7;
      case ArtistMatchType.veryHigh:
        return 6;
      case ArtistMatchType.high:
        return 5;
      case ArtistMatchType.medium:
        return 4;
      case ArtistMatchType.low:
        return 2;
      case ArtistMatchType.noMatch:
        return 0;
      default:
        return 0;
    }
  }
}
