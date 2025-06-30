import '../models/lyrics_data.dart';
import '../models/i_line_info.dart';

/// LRC 歌词生成器
class LrcGenerator {
  /// 生成 LRC 字符串
  /// 
  /// [lyricsData] 用于生成的源歌词数据
  /// [endTimeOutputType] 作为行末时间的空行的输出类型
  /// [subLinesOutputType] 子行的输出方式
  /// 返回生成出的 LRC 字符串
  static String generate(
      LyricsData lyricsData, 
      {EndTimeOutputType endTimeOutputType = EndTimeOutputType.huge,
       SubLinesOutputType subLinesOutputType = SubLinesOutputType.inMainLine}) {
    if (lyricsData.lines == null || lyricsData.lines!.isEmpty) return '';

    final sb = StringBuffer();
    final lines = lyricsData.lines!;

    for (int i = 0; i < lines.length; i++) {
      var line = lines[i];
      if (subLinesOutputType == SubLinesOutputType.inDiffLine) {
        _appendLine(sb, line);
        if (_shouldAddLine(lines, line, false, i, endTimeOutputType))
          _appendEmptyLine(sb, line.endTime!);

        if (line.subLine != null) {
          _appendLine(sb, line.subLine!);
          if (_shouldAddLine(lines, line.subLine!, false, i, endTimeOutputType))
            _appendEmptyLine(sb, line.subLine!.endTime!);
        }
      } else {
        _appendLineWithSub(sb, line);
        if (_shouldAddLine(lines, line, true, i, endTimeOutputType))
          _appendEmptyLine(sb, line.endTimeWithSubLine!);
      }
    }

    return sb.toString();
  }

  // 添加普通行
  static void _appendLine(StringBuffer sb, ILineInfo line) {
    if (line.startTime == null) return;
    sb.writeln('[${_formatTimeMsToTimestampString(line.startTime!)}]${line.text}');
  }

  // 添加带子行的行
  static void _appendLineWithSub(StringBuffer sb, ILineInfo line) {
    if (line.startTimeWithSubLine == null) return;
    sb.writeln('[${_formatTimeMsToTimestampString(line.startTimeWithSubLine!)}]${line.fullText}');
  }

  // 添加空行（用于标记行结束时间）
  static void _appendEmptyLine(StringBuffer sb, int timeStamp) {
    sb.writeln('[${_formatTimeMsToTimestampString(timeStamp)}]');
  }

  // 判断是否应该添加行结束时间
  static bool _shouldAddLine(List<ILineInfo> lines, ILineInfo line, bool withSub, int index, EndTimeOutputType endTimeOutputType) {
    final endTime = withSub ? line.endTimeWithSubLine : line.endTime;
    if (endTime == null) return false;
    if (endTime <= 0) return false;
    
    if (endTimeOutputType == EndTimeOutputType.all) return true;
    if (endTimeOutputType == EndTimeOutputType.huge) {
      if (index + 1 >= lines.length) return true;
      if (lines[index + 1].startTimeWithSubLine != null && 
          lines[index + 1].startTimeWithSubLine! - endTime > 5000) return true;
    }
    return false;
  }

  // 格式化时间戳
  static String _formatTimeMsToTimestampString(int timeMs) {
    final minutes = (timeMs / 60000).floor();
    final seconds = ((timeMs % 60000) / 1000).floor();
    final milliseconds = (timeMs % 1000 / 10).floor();
    return '$minutes:${seconds.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(2, '0')}';
  }
}

/// 作为行末时间的空行的输出类型
enum EndTimeOutputType {
  /// 不输出作为行末时间的空行
  none,

  /// 输出间距 (5s 以上) 较大的行末时间空行
  huge,

  /// 输出所有行末时间空行
  all,
}

/// 子行的输出方式
enum SubLinesOutputType {
  /// 通过括号嵌在主行中
  inMainLine,

  /// 子行单独成行
  inDiffLine,
} 