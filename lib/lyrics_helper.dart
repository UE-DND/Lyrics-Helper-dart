import 'dart:async';
import 'package:http/http.dart' as http;
import 'models/track_metadata.dart';
import 'helpers/parse_helper.dart';
import 'models/lyrics_data.dart';
import 'models/line_info.dart';
import 'searchers/netease_searcher.dart';
import 'searchers/netease_search_result.dart';
import 'providers/web/providers.dart';
import 'providers/web/base_api.dart';
import 'models/lyrics_types.dart';

/// 状态枚举
enum FetchStatus {
  success,
  notFound,
  networkError,
  parseFailed,
}

/// 统一返回结果
class FetchResult {
  final FetchStatus status;
  final LyricsData? lyricsData;
  final String? rawLyrics;
  final String? message;

  const FetchResult(
      {required this.status, this.lyricsData, this.rawLyrics, this.message});
}

/// 对外统一的歌词获取接口，仅使用网易云 API。
class LyricsHelper {
  LyricsHelper._();

  /// 新版接口：通过 TrackMetadata 获取歌词，返回 [FetchResult]
  static Future<FetchResult> fetchLyricsFull(
    TrackMetadata track, {
    Duration timeout = const Duration(seconds: 10),
    http.Client? client,
  }) async {
    // 可选覆盖全局 http client
    http.Client? original;
    if (client != null) {
      original = BaseApi.httpClient;
      BaseApi.httpClient = client;
    }

    try {
      // 搜索
      final searcher = NeteaseSearcher();
      final result = await searcher
          .searchForResult(track)
          .timeout(timeout, onTimeout: () => null);

      if (result == null || result is! NeteaseSearchResult) {
        return const FetchResult(status: FetchStatus.notFound);
      }

      final songId = result.id.toString();

      // 请求歌词
      dynamic lyricResp;
      try {
        lyricResp = await Providers.neteaseApi
            .getLyricNew(songId)
            .timeout(timeout, onTimeout: () => null);
        if (lyricResp == null || lyricResp.lrc?.lyric == null) {
          lyricResp = await Providers.neteaseApi
              .getLyric(songId)
              .timeout(timeout, onTimeout: () => null);
        }
      } on FormatException {
        return const FetchResult(
            status: FetchStatus.networkError, message: 'Invalid JSON');
      }

      final rawLyrics = lyricResp?.lrc?.lyric;
      if (rawLyrics == null || rawLyrics.isEmpty) {
        return const FetchResult(status: FetchStatus.notFound);
      }

      LyricsData? parsed =
          ParseHelper.parseLyrics(rawLyrics, LyricsRawTypes.yrc);

      // 若 YRC 解析失败或无行信息，尝试 LRC 解析，并同时处理翻译
      if (parsed == null || (parsed.lines?.isEmpty ?? true)) {
        parsed = ParseHelper.parseLyrics(rawLyrics, LyricsRawTypes.lrc);

        // 若存在翻译歌词字段，尝试合并
        if (parsed != null &&
            parsed.lines?.isNotEmpty == true &&
            lyricResp?.tlyric?.lyric != null) {
          // Convert to FullLineInfo to hold translations
          parsed.lines = parsed.lines!
              .map((e) => FullLineInfo.fromLineInfo(e as LineInfo))
              .toList();

          final transRaw = lyricResp!.tlyric!.lyric!;
          final transParsed =
              ParseHelper.parseLyrics(transRaw, LyricsRawTypes.lrc);
          if (transParsed != null && transParsed.lines?.isNotEmpty == true) {
            // 1) 优先按时间戳精确匹配
            final transMap = <int, String>{};
            for (var t in transParsed.lines!) {
              if (t.startTime != null && t.text.isNotEmpty) {
                transMap[t.startTime!] = t.text;
              }
            }

            for (var line in parsed.lines!) {
              var fullLine = line as FullLineInfo;
              int key = fullLine.startTime ?? -1;
              String? ct = transMap[key];
              // 容差匹配（±30ms）
              if (ct == null) {
                for (int delta = -30; delta <= 30; delta += 10) {
                  if (delta == 0) continue;
                  ct = transMap[key + delta];
                  if (ct != null) break;
                }
              }
              if (ct != null && ct.isNotEmpty) {
                fullLine.chineseTranslation = ct;
              }
            }

            // 2) 若仍无翻译（部分行无时间），按行顺序合并
            if (parsed.lines!
                    .where(
                        (l) => (l as FullLineInfo).chineseTranslation != null)
                    .isEmpty &&
                transParsed.lines!.length == parsed.lines!.length) {
              for (int i = 0; i < parsed.lines!.length; i++) {
                final ct = transParsed.lines![i].text;
                if (ct.isNotEmpty) {
                  (parsed.lines![i] as FullLineInfo).chineseTranslation = ct;
                }
              }
            }
          }
        }
      }

      if (parsed == null || (parsed.lines?.isEmpty ?? true)) {
        return FetchResult(
            status: FetchStatus.parseFailed, rawLyrics: rawLyrics);
      }

      return FetchResult(
          status: FetchStatus.success,
          lyricsData: parsed,
          rawLyrics: rawLyrics);
    } on TimeoutException catch (_) {
      return const FetchResult(
          status: FetchStatus.networkError, message: 'Timeout');
    } catch (e) {
      return FetchResult(
          status: FetchStatus.networkError, message: e.toString());
    } finally {
      if (client != null && original != null) {
        BaseApi.httpClient = original;
      }
    }
  }
}
