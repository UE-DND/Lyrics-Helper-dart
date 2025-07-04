import 'package:lyricify_lyrics_helper/providers/web/netease/api.dart'
    show SearchType;
import 'package:lyricify_lyrics_helper/providers/web/netease/response.dart'
    as model;
import 'package:lyricify_lyrics_helper/providers/web/providers.dart';
import 'package:lyricify_lyrics_helper/searchers/netease_searcher.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks.mocks.dart';

void main() {
  group('NeteaseSearcher', () {
    late NeteaseSearcher searcher;
    late MockApi mockApi;

    setUp(() {
      searcher = NeteaseSearcher();
      mockApi = MockApi();
      Providers.neteaseApi = mockApi;
    });

    test('returns results when legacy search succeeds', () async {
      final searchResult = model.SearchResult(
          code: 200,
          result: model.SearchResultData(songs: [
            model.Song(
                id: '1',
                name: 'Song 1',
                artists: [],
                album: null,
                duration: 180000)
          ]));

      when(mockApi.search('test', SearchType.song))
          .thenAnswer((_) async => searchResult);

      final results = await searcher.searchForResultsByString('test');

      expect(results, isNotNull);
      expect(results!.length, 1);
      expect(results.first.title, 'Song 1');
      verify(mockApi.search('test', SearchType.song)).called(1);
      verifyNever(mockApi.searchNew(any));
    });

    test('falls back to new search when legacy search fails', () async {
      when(mockApi.search('test', SearchType.song))
          .thenThrow(Exception('Legacy search failed'));

      final eapiSearchResult = model.EapiSearchResult(
          code: 200,
          result: model.EapiSearchResultData(songs: [
            model.EapiSong(id: 2, name: 'Song 2', duration: 190000)
          ]));
      when(mockApi.searchNew('test')).thenAnswer((_) async => eapiSearchResult);

      final results = await searcher.searchForResultsByString('test');

      expect(results, isNotNull);
      expect(results!.length, 1);
      expect(results.first.title, 'Song 2');
      verify(mockApi.search('test', SearchType.song)).called(1);
      verify(mockApi.searchNew('test')).called(1);
    });

    test('returns null when both searches fail', () async {
      when(mockApi.search(any, any))
          .thenThrow(Exception('Legacy search failed'));
      when(mockApi.searchNew(any)).thenThrow(Exception('New search failed'));

      final results = await searcher.searchForResultsByString('test');

      expect(results, isNull);
    });
  });
}
