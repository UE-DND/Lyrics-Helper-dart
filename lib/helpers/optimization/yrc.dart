import '../../models/i_line_info.dart';
import '../../models/line_info.dart';
import '../../models/syllable_info.dart';

class Yrc {
  Yrc._();

  static void standardizeYrcLyrics(List<ILineInfo> list) {
    for (final line in list) {
      if (line is SyllableLineInfo) {
        standardizeYrcLyricsForSyllableLine(line);
      }
    }
  }

  static void standardizeYrcLyricsForSyllableLine(SyllableLineInfo line) {
    var list = line.syllables;

    if (list.isEmpty) return;

    // 移除最后的空格
    while (list.isNotEmpty && list.last.text == " ") {
      list.removeLast();
    }

    for (int i = 0; i < list.length; i++) {
      // 移除空白格
      if (list[i].text.isEmpty) {
        list.removeAt(i);
        i--;
        continue;
      }

      // 合并单独的空格
      if (list[i].text == " ") {
        if (i > 0) {
          final prevSyllable = list[i - 1];
          if (prevSyllable is SyllableInfo) {
            prevSyllable.text += list[i].text;
          }
        }
        list.removeAt(i);
        i--;
        continue;
      }

      // 合并标点符号
      if (i > 0 &&
          list[i].text.length <= 2 &&
          (list[i].text[0] == ',' ||
              list[i].text[0] == '.' ||
              list[i].text[0] == '?' ||
              list[i].text[0] == '!' ||
              list[i].text[0] == '\"')) {
        final prevSyllable = list[i - 1];
        if (prevSyllable is SyllableInfo) {
          prevSyllable.text += list[i].text;
        }
        list.removeAt(i);
        i--;
        continue;
      }
    }
    line.refreshProperties();
  }
} 