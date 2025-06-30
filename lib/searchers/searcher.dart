import '../models/i_track_metadata.dart';
import 'helpers/compare_helper.dart';
import 'i_search_result.dart';
import 'i_searcher.dart';
import 'searchers.dart';

/// 搜索提供者抽象类，提供统一搜索方法
abstract class Searcher implements ISearcher {
  @override
  String get name;

  @override
  String get displayName;

  @override
  Searchers get searcherType;

  @override
  Future<List<ISearchResult>?> searchForResultsByString(String searchString);

  @override
  Future<ISearchResult?> searchForResult(ITrackMetadata track) async {
    var search = await searchForResults(track);

    // 没有搜到时，尝试完整搜索
    if (search.isEmpty) {
      search = await searchForResultsWithFullSearch(track, true);
    }

    // 仍然没有搜到，直接返回 null
    if (search.isEmpty) {
      return null;
    }

    return search[0];
  }

  @override
  Future<ISearchResult?> searchForResultWithMinimumMatch(
      ITrackMetadata track, CompareMatchType minimumMatch) async {
    var search = await searchForResults(track);

    // 没有搜到时，尝试完整搜索
    if (search.isEmpty ||
        (search[0].matchType?.index ?? 0) > minimumMatch.index) {
      search = await searchForResultsWithFullSearch(track, true);
    }

    // 仍然没有搜到，直接返回 null
    if (search.isEmpty) {
      return null;
    }

    if ((search[0].matchType?.index ?? 0) <= minimumMatch.index) {
      return search[0];
    } else {
      return null;
    }
  }

  @override
  Future<List<ISearchResult>> searchForResults(ITrackMetadata track) async {
    return await searchForResultsWithFullSearch(track, false);
  }

  @override
  Future<List<ISearchResult>> searchForResultsWithFullSearch(
      ITrackMetadata track, bool fullSearch) async {
    String searchString =
        "${track.title} ${track.artist?.replaceAll(", ", " ")} ${track.album}"
            .replaceAll(" - ", " ")
            .trim();
    var searchResults = <ISearchResult>[];

    var level = 1;
    do {
      var results = await searchForResultsByString(searchString);
      if (results != null && results.isNotEmpty) {
        searchResults.addAll(results);
      }

      var newTitle = track.title;
      if (newTitle != null && newTitle.contains("(feat.")) {
        newTitle = newTitle.substring(0, newTitle.indexOf("(feat.")).trim();
      }
      if (newTitle != null && newTitle.contains(" - feat.")) {
        newTitle = newTitle.substring(0, newTitle.indexOf(" - feat.")).trim();
      }

      if (fullSearch || results == null || results.isEmpty) {
        var newSearchString = "";
        switch (level) {
          case 1:
            newSearchString = "$newTitle ${track.artist?.replaceAll(", ", " ")}"
                .replaceAll(" - ", " ")
                .trim();
            break;
          case 2:
            newSearchString = "$newTitle".replaceAll(" - ", " ").trim();
            break;
          default:
            newSearchString = "";
        }
        if (newSearchString != searchString) {
          searchString = newSearchString;
        } else {
          break;
        }
      } else {
        break;
      }
    } while (++level < 3);

    for (var result in searchResults) {
      result.setMatchType(CompareHelper.compareTrack(track, result));
    }

    searchResults.sort(
        (x, y) => (x.matchType?.index ?? 0).compareTo(y.matchType?.index ?? 0));

    return searchResults;
  }
}
