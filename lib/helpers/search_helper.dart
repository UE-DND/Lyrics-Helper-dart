import 'dart:async';

import '../models/i_track_metadata.dart';
import '../searchers/i_searcher.dart';
import '../searchers/i_search_result.dart';
import '../searchers/searchers.dart';
import '../searchers/helpers/compare_helper.dart';
import '../searchers/searchers_helper.dart';

/// <summary>
/// 搜索帮助类
/// </summary>
class SearchHelper {
  SearchHelper._();

  /// <summary>
  /// 搜索指定曲目的对应曲目
  /// </summary>
  /// <param name="track">指定曲目</param>
  /// <param name="searcher">搜索提供者</param>
  /// <returns>对应曲目</returns>
  static Future<ISearchResult?> search(
    ITrackMetadata track,
    dynamic searcher, {
    CompareMatchType? minimumMatch,
  }) async {
    ISearcher? searcherInstance;
    if (searcher is Searchers) {
      searcherInstance = SearchersHelper.getSearcher(searcher);
    } else if (searcher is ISearcher) {
      searcherInstance = searcher;
    }

    if (searcherInstance == null) return null;

    if (minimumMatch != null) {
      return searcherInstance.searchForResultWithMinimumMatch(track, minimumMatch);
    } else {
      return searcherInstance.searchForResult(track);
    }
  }
} 