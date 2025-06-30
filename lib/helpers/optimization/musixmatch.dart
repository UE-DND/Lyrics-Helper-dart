import '../../models/i_line_info.dart';
import '../../models/line_info.dart';
import '../../models/syllable_info.dart';

class Musixmatch {
  Musixmatch._();

  static void standardizeMusixmatchLyrics(List<ILineInfo> list) {
    for (final line in list) {
      if (line is SyllableLineInfo) {
        standardizeMusixmatchLyricsForSyllableLine(line);
      }
    }
  }

  static void standardizeMusixmatchLyricsForSyllableLine(SyllableLineInfo syllableLine) {
    for (int i = 1; i < syllableLine.syllables.length; i++) {
      if (syllableLine.syllables[i].text == " ") {
        final prevSyllable = syllableLine.syllables[i - 1];
        if (prevSyllable is SyllableInfo) {
          prevSyllable.text += " ";
          syllableLine.syllables.removeAt(i--);
        }
      }
    }
    syllableLine.refreshProperties();
  }
} 