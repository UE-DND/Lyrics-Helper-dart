import '../models/lyrics_data.dart';
import '../models/lyrics_types.dart';
import '../parsers/krc_parser.dart';
import '../parsers/lrc_parser.dart';
import '../parsers/lyricify_lines_parser.dart';
import '../parsers/lyricify_syllable_parser.dart';
import '../parsers/musixmatch_parser.dart';
import '../parsers/qrc_parser.dart';
import '../parsers/spotify_parser.dart';
import '../parsers/yrc_parser.dart';
import 'type_helper.dart';

/// <summary>
/// 解析帮助类
/// </summary>
class ParseHelper {
  ParseHelper._();

  /// <summary>
  /// 解析歌词
  /// </summary>
  /// <param name="lyrics">歌词字符串</param>
  /// <returns>解析后的歌词数据</returns>
  static LyricsData? parseLyrics(String lyrics, [LyricsRawTypes? lyricsRawType]) {
    lyricsRawType ??= TypeHelper.getLyricsTypes(lyrics);
    if (lyricsRawType != LyricsRawTypes.unknown) {
      return _parseLyrics(lyrics, lyricsRawType);
    }
    return null;
  }

  /// <summary>
  /// 解析歌词
  /// </summary>
  /// <param name="lyrics">歌词字符串</param>
  /// <param name="lyricsRawType">该歌词字符串的原始类型</param>
  /// <returns>解析后的歌词数据</returns>
  static LyricsData? _parseLyrics(String lyrics, LyricsRawTypes lyricsRawType) {
    switch (lyricsRawType) {
      case LyricsRawTypes.lyricifySyllable:
        return LyricifySyllableParser.parse(lyrics);
      case LyricsRawTypes.lyricifyLines:
        return LyricifyLinesParser.parse(lyrics);
      case LyricsRawTypes.lrc:
        return LrcParser.parse(lyrics);
      case LyricsRawTypes.qrc:
        return QrcParser.parse(lyrics);
      case LyricsRawTypes.krc:
        return KrcParser.parse(lyrics);
      case LyricsRawTypes.yrc:
        return YrcParser.parse(lyrics);
      case LyricsRawTypes.spotify:
        return SpotifyParser.parse(lyrics);
      case LyricsRawTypes.musixmatch:
        return MusixmatchParser.parse(lyrics);
      default:
        return null;
    }
  }
} 