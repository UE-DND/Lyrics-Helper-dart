import '../models/i_track_metadata.dart';
import 'helpers/compare_helper.dart';
import 'i_search_result.dart';
import 'searchers.dart';

/// 搜索提供者接口
abstract class ISearcher {
  /// 搜索源名称
  String get name;

  /// 搜索源显示名称 (in English)
  String get displayName;

  Searchers get searcherType;

  /// 搜索最佳匹配的曲目
  Future<ISearchResult?> searchForResult(ITrackMetadata track);

  /// 搜索最佳匹配的曲目
  Future<ISearchResult?> searchForResultWithMinimumMatch(
      ITrackMetadata track, CompareMatchType minimumMatch);

  /// 搜索匹配的曲目列表
  Future<List<ISearchResult>> searchForResults(ITrackMetadata track);

  /// 搜索匹配的曲目列表
  Future<List<ISearchResult>> searchForResultsWithFullSearch(
      ITrackMetadata track, bool fullSearch);

  /// 搜索关键字的曲目列表
  Future<List<ISearchResult>?> searchForResultsByString(String searchString);
}
