import '../models/lyrics_data.dart';
import '../models/line_info.dart';
import '../models/syllable_info.dart';

/// QRC 歌词生成器
class QrcGenerator {
  /// 生成 QRC 字符串
  /// 
  /// [lyricsData] 用于生成的源歌词数据
  /// 返回生成出的 QRC 字符串
  static String generate(LyricsData lyricsData) {
    if (lyricsData.lines == null || lyricsData.lines!.isEmpty) return '';

    final sb = StringBuffer();
    final lines = lyricsData.lines!;
    
    for (int i = 0; i < lines.length; i++) {
      if (lines[i] is SyllableLineInfo) {
        final line = lines[i] as SyllableLineInfo;
        _appendLine(sb, line);
        
        if (line.subLine is SyllableLineInfo) {
          _appendLine(sb, line.subLine as SyllableLineInfo, true);
        }
      }
    }

    return sb.toString();
  }

  // 添加一行歌词
  static void _appendLine(StringBuffer sb, SyllableLineInfo line, [bool isSubLine = false]) {
    // 添加行信息
    sb.write('[');
    sb.write(line.startTime);
    sb.write(',');
    sb.write(line.duration);
    sb.write(']');

    // 添加音节信息
    for (var syllable in line.syllables) {
      if (syllable is SyllableInfo) {
        _append(sb, syllable);
      } else if (syllable is FullSyllableInfo) {
        for (var item in syllable.subItems) {
          _append(sb, item);
        }
      }
    }
    
    sb.writeln();
  }

  // 添加单个音节
  static void _append(StringBuffer sb, SyllableInfo item) {
    sb.write(item.text);
    sb.write('(');
    sb.write(item.startTime);
    sb.write(',');
    sb.write(item.duration);
    sb.write(')');
  }
} 