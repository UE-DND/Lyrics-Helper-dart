import 'package:lyricify_lyrics_helper/helpers/search_helper.dart';
import 'package:lyricify_lyrics_helper/searchers/helpers/compare_helper.dart';
import 'package:lyricify_lyrics_helper/searchers/i_search_result.dart';
import 'package:lyricify_lyrics_helper/searchers/i_searcher.dart';
import 'package:lyricify_lyrics_helper/models/track_metadata.dart';
import 'package:test/test.dart';
import 'package:lyricify_lyrics_helper/searchers/searchers.dart';

class DummySearchResult implements ISearchResult {
  @override
  List<String> artists;

  @override
  String album;

  DummySearchResult(this.title,
      {this.artists = const ['Test'], this.album = 'Album'});

  @override
  ISearcher get searcher => throw UnimplementedError();

  @override
  String title;

  @override
  List<String>? albumArtists;

  @override
  int? durationMs;

  CompareMatchType? _match;
  @override
  CompareMatchType? get matchType => _match;
  @override
  void setMatchType(CompareMatchType? matchType) {
    _match = matchType;
  }

  @override
  String get artist => artists.join(', ');

  @override
  String? get albumArtist => albumArtists?.join(', ');
}

class DummySearcher implements ISearcher {
  ISearchResult result;
  bool forResultCalled = false;
  bool forResultMinCalled = false;
  DummySearcher(this.result);

  @override
  String get displayName => 'Dummy';

  @override
  String get name => 'Dummy';

  @override
  Searchers get searcherType => Searchers.netease;

  @override
  Future<ISearchResult?> searchForResult(track) async {
    forResultCalled = true;
    return result;
  }

  @override
  Future<ISearchResult?> searchForResultWithMinimumMatch(
      track, minimumMatch) async {
    forResultMinCalled = true;
    return result;
  }

  @override
  Future<List<ISearchResult>> searchForResults(track) async => [result];
  @override
  Future<List<ISearchResult>> searchForResultsWithFullSearch(
          track, bool fullSearch) async =>
      [result];
  @override
  Future<List<ISearchResult>?> searchForResultsByString(
          String searchString) async =>
      [result];
}

void main() {
  group('SearchHelper', () {
    late TrackMetadata track;
    setUp(() {
      track = TrackMetadata()
        ..title = 'Song'
        ..artist = 'Artist';
    });

    test('calls searchForResult when minimumMatch is null', () async {
      final searcher = DummySearcher(DummySearchResult('Song'));
      final res = await SearchHelper.search(track, searcher);
      expect(res, isNotNull);
      expect(searcher.forResultCalled, isTrue);
      expect(searcher.forResultMinCalled, isFalse);
    });

    test('calls searchForResultWithMinimumMatch when minimumMatch is provided',
        () async {
      final searcher = DummySearcher(DummySearchResult('Song'));
      final res = await SearchHelper.search(
        track,
        searcher,
        minimumMatch: CompareMatchType.low,
      );
      expect(res, isNotNull);
      expect(searcher.forResultCalled, isFalse);
      expect(searcher.forResultMinCalled, isTrue);
    });
  });
}
