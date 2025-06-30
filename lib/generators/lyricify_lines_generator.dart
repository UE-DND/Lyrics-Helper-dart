import '../models/lyrics_data.dart';
import '../models/i_line_info.dart';

/// Lyricify Lines 歌词生成器
class LyricifyLinesGenerator {
  /// 生成 Lyricify Lines 字符串
  /// 
  /// [lyricsData] 用于生成的源歌词数据
  /// [subLinesOutputType] 子行的输出方式
  /// 返回生成出的 Lyricify Lines 字符串
  static String generate(
      LyricsData lyricsData, 
      {SubLinesOutputType subLinesOutputType = SubLinesOutputType.inMainLine}) {
    if (lyricsData.lines == null || lyricsData.lines!.isEmpty) return '';

    final sb = StringBuffer();
    final lines = lyricsData.lines!;
    for (int i = 0; i < lines.length; i++) {
      var line = lines[i];
      if (subLinesOutputType == SubLinesOutputType.inDiffLine) {
        _appendLine(sb, line);
        if (line.subLine != null)
          _appendLine(sb, line.subLine!);
      } else {
        if (line.startTimeWithSubLine != null)
          sb.writeln('[${line.startTimeWithSubLine},${line.endTimeWithSubLine ?? 0}]${line.fullText}');
      }
    }

    return sb.toString();
  }

  // 添加普通行
  static void _appendLine(StringBuffer sb, ILineInfo line) {
    if (line.startTime != null)
      sb.writeln('[${line.startTime},${line.endTime ?? 0}]${line.text}');
  }
}

/// 子行的输出方式
enum SubLinesOutputType {
  /// 通过括号嵌在主行中
  inMainLine,

  /// 子行单独成行
  inDiffLine,
} 