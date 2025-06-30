import '../models/i_track_metadata.dart';
import '../providers/web/providers.dart';
import 'helpers/compare_helper.dart';
import 'i_search_result.dart';
import 'i_searcher.dart';
import 'musixmatch_search_result.dart';
import 'searchers.dart';

class MusixmatchSearcher implements ISearcher {
  @override
  String get name => "Musixmatch";

  @override
  String get displayName => "Musixmatch";

  @override
  Searchers get searcherType => Searchers.musixmatch;

  @override
  Future<ISearchResult?> searchForResult(ITrackMetadata track) async {
    var result = await searchForResults(track);
    if (result.isNotEmpty) {
      return result[0];
    }
    return null;
  }

  @override
  Future<ISearchResult?> searchForResultWithMinimumMatch(
      ITrackMetadata track, CompareMatchType minimumMatch) async {
    var result = await searchForResults(track);
    if (result.isNotEmpty &&
        (result[0].matchType?.index ?? 0) >= minimumMatch.index) {
      return result[0];
    }
    return null;
  }

  Future<List<ISearchResult>?> searchForResultsByTrackArtist(
      String track, String artist, int? duration) async {
    var search = <ISearchResult>[];

    try {
      var result = await Providers.musixmatchApi.getTrack(track, artist,
          duration: duration != null ? duration ~/ 1000 : null);
      var t = result?.message?.body?.track;
      if (t == null) return null;

      var r = MusixmatchSearchResult.fromTrack(t);
      search.add(r);
    } catch (e) {
      return null;
    }

    return search;
  }

  @override
  Future<List<ISearchResult>> searchForResults(ITrackMetadata track) async {
    var results = await searchForResultsByTrackArtist(
        track.title ?? "", track.artist ?? "", track.durationMs);

    if (results != null) {
      for (var r in results) {
        r.setMatchType(CompareHelper.compareTrack(track, r));
      }
      results.sort((x, y) =>
          -(x.matchType?.index ?? 0).compareTo(y.matchType?.index ?? 0));
      return results;
    }
    return [];
  }

  @override
  Future<List<ISearchResult>> searchForResultsWithFullSearch(
      ITrackMetadata track, bool fullSearch) async {
    return await searchForResults(track);
  }

  @override
  Future<List<ISearchResult>?> searchForResultsByString(
      String searchString) async {
    return await searchForResultsByTrackArtist(searchString, "", null);
  }
}
