import 'dart:convert';
import 'dart:math';

import '../base_api.dart';
import 'response.dart';

class Api extends BaseApi {
  @override
  String? get httpRefer => null;

  @override
  Map<String, String>? get additionalHeaders => {
        "authority": "apic-desktop.musixmatch.com",
      };

  String? _userToken;

  void setUserToken(String token) {
    _userToken = token;
  }

  String? getUserToken() {
    return _userToken;
  }

  Future<GetTokenResponse?> getToken() async {
    final response = await getAsync(
        "https://apic-desktop.musixmatch.com/ws/1.1/token.get?app_id=web-desktop-app-v1.0&t=${_randomId()}");
    return GetTokenResponse.fromJson(jsonDecode(response));
  }

  Future<GetTrackResponse?> getTrack(String track, String artist, {int? duration}) async {
    await _ensureUserToken();
    var query = "matcher.track.get?q_track=$track&q_artist=$artist";
    if (duration != null) {
      query += "&q_duration=$duration";
    }
    final response = await _musixmatchGetAsync(query);
    if (response == null) return null;
    return GetTrackResponse.fromJson(jsonDecode(response));
  }
  
  Future<String?> _musixmatchGetAsync(String req, {int maxTrial = 8}) async {
    if (--maxTrial < 0) return null;

    await _ensureUserToken();

    final url = "https://apic-desktop.musixmatch.com/ws/1.1/$req"
        "&usertoken=$_userToken"
        "&format=json"
        "&app_id=web-desktop-app-v1.0"
        "&t=${_randomId()}";

    var response = await getAsync(url);

    if (response.contains("\"status_code\":401")) {
      if (response.contains("\"hint\":\"renew\"")) {
        _userToken = null;
        return await _musixmatchGetAsync(req, maxTrial: maxTrial);
      } else if (response.contains("\"hint\":\"captcha\"")) {
        await Future.delayed(const Duration(milliseconds: 1000));
        return await _musixmatchGetAsync(req, maxTrial: maxTrial);
      }
    }
    
    if (response.contains("\"status_code\":401") && response.contains("\"hint\":\"captcha\"")) {
      throw RequestCaptchaException(url, response);
    }

    return response;
  }

  static String _randomId() {
    final random = Random();
    final value = (random.nextDouble() * 9223372036854775807).toInt();
    var code = _convertToBase36(value);
    code = code.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    return code.substring(2, min(8, code.length));
  }

  static String _convertToBase36(int value) {
    const chars = "0123456789abcdefghijklmnopqrstuvwxyz";
    if (value == 0) return "0";
    String result = "";
    int targetBase = 36;
    int val = value;
    while (val > 0) {
      result = chars[val % targetBase] + result;
      val = val ~/ targetBase;
    }
    return result;
  }

  Future<void> _ensureUserToken() async {
    if (_userToken != null) return;
    await _refreshUserToken(isEnsure: true);
  }

  Future<void> _refreshUserToken({bool isEnsure = false}) async {
    var response = await getToken();
    int maxTry = 10;
    while (response?.message?.header?.statusCode == 401 &&
        response?.message?.header?.hint == "captcha" &&
        maxTry-- > 0) {
      await Future.delayed(const Duration(milliseconds: 1000));
      if (isEnsure && _userToken != null) return;
      response = await getToken();
    }
    final token = response?.message?.body?.userToken;
    if (token == null || token.isEmpty) {
      throw Exception("User Token failed to refresh");
    }
    _userToken = token;
  }

  Future<GetTrackResponse?> getFullLyrics(String track, String artist, {int? duration}) async {
    await _ensureUserToken();

    final response = await getFullLyricsRaw(track: track, artist: artist, duration: duration);
    if (response == null) return null;
    return GetTrackResponse.fromJson(jsonDecode(response));
  }

  /// 获取完整歌词
  /// 1. 指定 [trackId] 时直接按 ID 请求。
  /// 2. 否则需同时提供 [track] 与 [artist]（可选 [duration]）。
  /// 返回 Musixmatch 接口原始响应，可交由 MusixmatchParser 解析。
  Future<String?> getFullLyricsRaw({
    String? trackId,
    String? track,
    String? artist,
    int? duration,
  }) async {
    await _ensureUserToken();

    if (trackId != null) {
      return await _musixmatchGetAsync(
          "macro.subtitles.get?namespace=lyrics_richsynched&optional_calls=track.richsync&subtitle_format=lrc"
          "&track_id=$trackId"
          "&f_subtitle_length_max_deviation=40");
    }

    if (track == null || artist == null) {
      throw ArgumentError("Either trackId or both track & artist must be provided.");
    }

    final query = StringBuffer(
        "macro.subtitles.get?namespace=lyrics_richsynched&optional_calls=track.richsync&subtitle_format=lrc"
        "&q_track=$track&q_artist=$artist");
    if (duration != null) {
      query.write("&f_subtitle_length=$duration&q_duration=$duration");
    }
    query.write("&f_subtitle_length_max_deviation=40");

    return await _musixmatchGetAsync(query.toString());
  }

  @Deprecated("Use getFullLyricsRaw(trackId: ...) instead.")
  Future<String?> getFullLyricsRawById(String trackId) =>
      getFullLyricsRaw(trackId: trackId);

  Future<GetTranslationsResponse?> getTranslations(String trackId, {String language = "zh"}) async {
    final response = await _musixmatchGetAsync(
        "crowd.track.translations.get?translation_fields_set=minimal"
        "&selected_language=$language"
        "&track_id=$trackId"
        "&comment_format=text&part=user");
    if (response == null) return null;
    return GetTranslationsResponse.fromJson(jsonDecode(response));
  }
}

class RequestCaptchaException implements Exception {
  final String? requestUrl;
  final String? response;
  final String message;

  RequestCaptchaException(this.requestUrl, this.response,
      {this.message = "Hit 401 error with Captcha hint."});

  @override
  String toString() {
    return "RequestCaptchaException: $message (URL: $requestUrl)";
  }
} 