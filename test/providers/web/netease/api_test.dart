import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:lyricify_lyrics_helper/providers/web/base_api.dart';
import 'package:lyricify_lyrics_helper/providers/web/netease/api.dart';
import 'package:test/test.dart';

void main() {
  group('NeteaseApi', () {
    late Api neteaseApi;
    late http.Client originalClient;

    setUp(() {
      neteaseApi = Api();
      originalClient = BaseApi.httpClient;
    });

    tearDown(() {
      BaseApi.httpClient = originalClient;
    });

    test('search returns parsed result on success', () async {
      final jsonResponse = {
        "result": {
          "songs": [
            {"id": 123, "name": "Test Song"}
          ]
        },
        "code": 200
      };

      BaseApi.httpClient = MockClient((request) async {
        expect(request.url.toString(), contains('Test'));
        return http.Response(json.encode(jsonResponse), 200);
      });

      final result = await neteaseApi.search('Test', SearchType.song);

      expect(result, isNotNull);
      expect(result!.result!.songs!.first.name, 'Test Song');
    });

    test('searchNew returns parsed result on success', () async {
      final jsonResponse = {
        "result": {
          "songs": [
            {"id": 456, "name": "New Test Song", "dt": 180000}
          ]
        },
        "code": 200
      };

      BaseApi.httpClient = MockClient((request) async {
        // eapi a little complex, just check url
        expect(request.url.toString(),
            contains('interface.music.163.com/eapi/cloudsearch/pc'));
        return http.Response(json.encode(jsonResponse), 200);
      });

      final result = await neteaseApi.searchNew('Test');
      expect(result, isNotNull);
      expect(result!.result!.songs!.first.name, 'New Test Song');
    });

    test('getLyricNew returns parsed result on success', () async {
      final jsonResponse = {
        "lrc": {"lyric": "[00:01.00]Hello"},
        "klyric": {"lyric": ""},
        "tlyric": {"lyric": ""},
        "code": 200
      };

      BaseApi.httpClient = MockClient((request) async {
        expect(request.url.toString(),
            contains('interface3.music.163.com/eapi/song/lyric/v1'));
        return http.Response(json.encode(jsonResponse), 200);
      });

      final result = await neteaseApi.getLyricNew('123');
      expect(result, isNotNull);
      expect(result!.lrc!.lyric, contains('Hello'));
    });
  });
}
