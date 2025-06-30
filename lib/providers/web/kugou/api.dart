import 'dart:convert';
import '../base_api.dart';
import 'response.dart';

class Api extends BaseApi {
  @override
  String? get httpRefer => null;

  @override
  Map<String, String>? get additionalHeaders => null;

  Future<SearchSongResponse?> getSearchSong(String keywords) async {
    var response = await BaseApi.httpClient.get(Uri.parse(
        'http://mobilecdn.kugou.com/api/v3/search/song?format=json&keyword=$keywords&page=1&pagesize=20&showtype=1'));
    if (response.statusCode == 200) {
      final resp =
          SearchSongResponse.fromJson(jsonDecode(response.body));
      return resp;
    }
    return null;
  }

  Future<SearchLyricsResponse?> getSearchLyrics(
      {String? keywords, int? duration, String? hash}) async {
    String durationPara = '';
    if (duration != null) {
      durationPara = '&duration=$duration';
    }
    hash ??= '';
    var response = await BaseApi.httpClient.get(Uri.parse(
        'https://lyrics.kugou.com/search?ver=1&man=yes&client=pc&keyword=$keywords$durationPara&hash=$hash'));
    if (response.statusCode == 200) {
      final resp =
          SearchLyricsResponse.fromJson(jsonDecode(response.body));
      return resp;
    }
    return null;
  }
} 