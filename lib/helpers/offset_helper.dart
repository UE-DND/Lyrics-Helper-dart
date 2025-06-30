import '../models/i_line_info.dart';
import '../models/line_info.dart';
import '../models/syllable_info.dart';

class OffsetHelper {
  OffsetHelper._();

  static void addOffset(dynamic lines, int offset) {
    if (lines is List<ILineInfo>) {
      for (var line in lines) {
        _addOffsetForILineInfo(line, offset);
      }
    } else if (lines is ILineInfo) {
      _addOffsetForILineInfo(lines, offset);
    }
  }

  static void _addOffsetForILineInfo(ILineInfo line, int offset) {
    if (line is LineInfo) {
      _addOffsetForLineInfo(line, offset);
    } else if (line is SyllableLineInfo) {
      _addOffsetForSyllableLineInfo(line, offset);
    }
  }

  static void _addOffsetForLineInfo(LineInfo line, int offset) {
    if (line.startTime != null) {
      line.startTime = line.startTime! - offset;
    }
    if (line.endTime != null) {
      line.endTime = line.endTime! - offset;
    }
  }

  static void _addOffsetForSyllableLineInfo(SyllableLineInfo line, int offset) {
    for (var syllable in line.syllables) {
      if (syllable is SyllableInfo) {
        syllable.startTime -= offset;
        syllable.endTime -= offset;
      } else if (syllable is FullSyllableInfo) {
        for (var subItem in syllable.subItems) {
          subItem.startTime -= offset;
          subItem.endTime -= offset;
        }
      }
    }
    line.refreshProperties();
  }
}
