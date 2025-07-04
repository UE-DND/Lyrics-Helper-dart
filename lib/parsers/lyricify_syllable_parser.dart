import '../helpers/general/string_helper.dart';
import '../helpers/offset_helper.dart';
import '../models/additional_file_info.dart';
import '../models/file_info.dart';
import '../models/i_line_info.dart';
import '../models/i_syllable_info.dart';
import '../models/line_info.dart';
import '../models/lyrics_data.dart';
import '../models/lyrics_types.dart';
import '../models/syllable_info.dart';
import '../models/sync_types.dart';
import 'attributes_helper.dart';

class LyricifySyllableParser {
  LyricifySyllableParser._();

  static LyricsData parse(String lyrics) {
    var lyricsLines = lyrics.trim().split('\n').toList();
    var data = LyricsData()
      ..file = (FileInfo()
        ..type = LyricsTypes.lyricifySyllable
        ..syncTypes = SyncTypes.syllableSynced
        ..additionalInfo = (GeneralAdditionalInfo()..attributes = []));

    var offset =
        AttributesHelper.parseGeneralAttributesToLyricsData(data, lyricsLines);
    var lines = _parseLyrics(lyricsLines, offset);
    data.lines = lines;
    return data;
  }

  static List<ILineInfo> _parseLyrics(List<String> lines, int? offset) {
    var list = <_SyllableLineInfoWithSubLineState>[];
    for (var line in lines) {
      var item = _parseLyricsLine(line);
      if (item != null) {
        list.add(item);
      }
    }
    var newList = _setBackgroundVocalsInfo(list);
    if (offset != null && offset != 0) {
      OffsetHelper.addOffset(newList, offset);
    }
    return newList;
  }

  static List<ILineInfo> _setBackgroundVocalsInfo(
      List<_SyllableLineInfoWithSubLineState> list) {
    for (int i = 1; i < list.length; i++) {
      if (list[i].isBackgroundVocals == true) {
        list[i - 1].subLine =
            _SyllableLineInfoWithSubLineState.getSyllableLineInfo(list[i]);
        list.removeAt(i--);
      }
    }
    bool isNotBackgroundVocals(_SyllableLineInfoWithSubLineState line) =>
        (line.isBackgroundVocals == null && !line.isBracketedLyrics) ||
        line.isBackgroundVocals == false;

    for (int i = 1; i < list.length; i++) {
      if (i + 1 < list.length &&
          list[i].isBackgroundVocals == null &&
          list[i].isBracketedLyrics) {
        if (isNotBackgroundVocals(list[i - 1]) && list[i - 1].subLine == null) {
          if (isNotBackgroundVocals(list[i + 1])) {
            list[i - 1].subLine =
                _SyllableLineInfoWithSubLineState.getSyllableLineInfo(list[i]);
            list.removeAt(i--);
          }
        }
      }
    }
    return list
        .map((e) => _SyllableLineInfoWithSubLineState.getSyllableLineInfo(e))
        .toList();
  }

  static _SyllableLineInfoWithSubLineState? _parseLyricsLine(String line) {
    var lyricItems = <SyllableInfo>[];
    var lineInfo = _SyllableLineInfoWithSubLineState();

    if (line.contains(']')) {
      var properties = line.substring(0, line.indexOf("]"));
      if (properties.length > 1 && (properties.substring(1).isNumber())) {
        int p = int.parse(properties.substring(1));
        if (p >= 6) {
          lineInfo.isBackgroundVocals = true;
        } else if (p >= 3) {
          lineInfo.isBackgroundVocals = false;
        }
        switch (p % 3) {
          case 0:
            lineInfo.lyricsAlignment = LyricsAlignment.unspecified;
            break;
          case 1:
            lineInfo.lyricsAlignment = LyricsAlignment.left;
            break;
          case 2:
            lineInfo.lyricsAlignment = LyricsAlignment.right;
            break;
        }
      }
      line = line.substring(line.indexOf("]") + 1);
    }

    var matches = RegExp(r"(.*?)\((\d+),(\d+)\)").allMatches(line);
    for (var match in matches) {
      if (match.groupCount == 3) {
        String text = match.group(1)!.trim();
        int startTime = int.parse(match.group(2)!);
        int duration = int.parse(match.group(3)!);
        int endTime = startTime + duration;
        lyricItems.add(SyllableInfo.create(text, startTime, endTime));
      }
    }

    lineInfo.syllables = lyricItems.cast<ISyllableInfo>().toList();
    return lineInfo;
  }
}

class _SyllableLineInfoWithSubLineState extends SyllableLineInfo {
  _SyllableLineInfoWithSubLineState();

  bool? isBackgroundVocals;

  bool get isBracketedLyrics =>
      (text.startsWith("(") || text.startsWith("（")) &&
      (text.endsWith(")") || text.endsWith("）"));

  static SyllableLineInfo getSyllableLineInfo(
      _SyllableLineInfoWithSubLineState state) {
    return SyllableLineInfo.fromSyllables(state.syllables)
      ..lyricsAlignment = state.lyricsAlignment
      ..subLine = state.subLine;
  }
}
