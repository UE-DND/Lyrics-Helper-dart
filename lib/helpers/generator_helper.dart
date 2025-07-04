import '../models/lyrics_data.dart';
import '../models/lyrics_types.dart';
import '../generators/lrc_generator.dart';
import '../generators/lyricify_lines_generator.dart';
import '../generators/lyricify_syllable_generator.dart';
import '../generators/yrc_generator.dart';

/// <summary>
/// 生成帮助类
/// </summary>
class GenerateHelper {
  GenerateHelper._();

  /// <summary>
  /// 生成歌词字符串
  /// </summary>
  /// <param name="lyrics">用于生成的源歌词数据</param>
  /// <param name="lyricsType">需要生成的歌词字符串的类型</param>
  /// <returns>生成出的歌词字符串, <see langword="null"/> 若为空或生成失败</returns>
  static String? generateString(LyricsData lyrics, LyricsTypes lyricsType) {
    String? result;
    switch (lyricsType) {
      case LyricsTypes.lyricifySyllable:
        result = LyricifySyllableGenerator.generate(lyrics);
        break;
      case LyricsTypes.lyricifyLines:
        result = LyricifyLinesGenerator.generate(lyrics);
        break;
      case LyricsTypes.lrc:
        result = LrcGenerator.generate(lyrics);
        break;
      case LyricsTypes.yrc:
        result = YrcGenerator.generate(lyrics);
        break;
      default:
        result = null;
    }
    if (result == null || result.trim().isEmpty) return null;
    return result;
  }
}
