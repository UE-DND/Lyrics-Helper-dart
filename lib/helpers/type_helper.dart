import '../models/lyrics_types.dart';
import 'types/lrc.dart';
import 'types/lyricify_lines.dart';

class TypeHelper {
  TypeHelper._();

  /// <summary>
  /// 识别歌词的类型
  /// </summary>
  /// <param name="lyrics">歌词字符串</param>
  /// <returns><see cref="LyricsRawTypes"/>, 如果没有识别成功则会返回 <see cref="LyricsRawTypes.unknown"/>.</returns>
  static LyricsRawTypes getLyricsTypes(String lyrics) {
    final trimmed = lyrics.trim();

    // 粗略判断 YRC：同时包含 "[" 开头及 "(" "," ")" 时间轴
    final hasBracket = trimmed.contains('[');
    final hasParenthesisTime = RegExp(r"\(\d+,\d+\)").hasMatch(trimmed);
    if (hasBracket && hasParenthesisTime) {
      return LyricsRawTypes.yrc;
    }

    // Lyricify Syllable (更具体，优先判断)
    final syllableRegex = RegExp(r'\w+\(\d+,\d+\)');
    if (syllableRegex.hasMatch(trimmed)) {
      return LyricsRawTypes.lyricifySyllable;
    }

    // Lyricify Lines / Syllable
    if (LyricifyLines.isLyricifyLines(trimmed)) {
      return LyricsRawTypes.lyricifyLines;
    }

    // LRC
    if (Lrc.isLrc(trimmed)) {
      return LyricsRawTypes.lrc;
    }

    return LyricsRawTypes.unknown;
  }

  /// <summary>
  /// 字符串是否是指定的歌词类型
  /// </summary>
  /// <param name="lyrics">歌词字符串</param>
  /// <param name="type">歌词类型</param>
  static bool isLyricsType(String lyrics, LyricsTypes type) {
    switch (type) {
      case LyricsTypes.lyricifyLines:
        return LyricifyLines.isLyricifyLines(lyrics);
      case LyricsTypes.lrc:
        return Lrc.isLrc(lyrics);
      default:
        // 暂不支持类型判断的，返回 false
        return false;
    }
  }

  /// <summary>
  /// 字符串的歌词类型是否在指定类型列表中
  /// </summary>
  /// <param name="lyrics">歌词字符串</param>
  /// <param name="types">歌词类型列表</param>
  static bool isLyricsTypeInList(String lyrics, List<LyricsTypes> types) {
    if (types.isEmpty) return false;

    for (var type in types) {
      if (isLyricsType(lyrics, type)) {
        return true;
      }
    }
    return false;
  }
}

/// <summary>
/// 将 LyricsRawType 转换为 LyricsType
/// </summary>
extension LyricsRawTypesExtension on LyricsRawTypes {
  LyricsTypes toLyricsType() {
    switch (this) {
      case LyricsRawTypes.unknown:
        return LyricsTypes.unknown;
      case LyricsRawTypes.lyricifySyllable:
        return LyricsTypes.lyricifySyllable;
      case LyricsRawTypes.lyricifyLines:
        return LyricsTypes.lyricifyLines;
      case LyricsRawTypes.lrc:
        return LyricsTypes.lrc;
      case LyricsRawTypes.yrc:
        return LyricsTypes.yrc;
      // 其他类型已移除
    }
  }
}
