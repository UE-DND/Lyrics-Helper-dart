import 'helpers/compare_helper.dart';
import 'i_searcher.dart';

/// 搜索结果接口
abstract class ISearchResult {
  /// 搜索提供者
  ISearcher get searcher;

  /// 曲目名
  String get title;

  /// 艺人列表
  List<String> get artists;

  /// 艺人名
  String get artist => artists.join(", ");

  /// 专辑
  String get album;

  /// 专辑艺人列表
  List<String>? get albumArtists;

  /// 专辑艺人名
  String? get albumArtist => albumArtists?.join(", ");

  /// 曲目时长
  int? get durationMs;

  /// 匹配程度
  CompareMatchType? get matchType;

  /// 设置匹配程度
  void setMatchType(CompareMatchType? matchType);
} 