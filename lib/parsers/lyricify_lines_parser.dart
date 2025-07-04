// coverage:ignore-file

import '../helpers/general/string_helper.dart';
import '../models/i_line_info.dart';
import '../models/lyrics_data.dart';
import '../models/lyrics_types.dart';
import '../models/sync_types.dart';
import '../models/additional_file_info.dart';
import '../models/file_info.dart';
import '../models/line_info.dart';
import 'attributes_helper.dart';

class LyricifyLinesParser {
  LyricifyLinesParser._(); // coverage:ignore-line

  static LyricsData parse(String lyrics) {
    var lyricsLines = lyrics
        .replaceAll("[type:LyricifyLines]", "")
        .trim()
        .split('\n')
        .toList();
    var data = LyricsData()
      ..file = (FileInfo()
        ..syncTypes = SyncTypes.lineSynced
        ..type = LyricsTypes.lyricifyLines
        ..additionalInfo = (GeneralAdditionalInfo()..attributes = []));

    // 处理 Attributes，并获取可能的 offset
    final offset =
        AttributesHelper.parseGeneralAttributesToLyricsData(data, lyricsLines);

    var lines = _parseLyrics(lyricsLines, offset);
    data.lines = lines.cast<ILineInfo>().toList();

    return data;
  }

  static List<LineInfo> _parseLyrics(List<String> lines, int? offset) {
    offset ??= 0;
    var lyricsArray = <LineInfo>[];
    for (var line in lines) {
      if (!line.startsWith(RegExp(r'[\[\{]'))) continue;

      try {
        final isCurly = line.startsWith('{');
        final startTag = isCurly ? '{' : '[';
        final endTag = isCurly ? '}' : ']';

        if (!line.contains(',') || !line.contains(endTag)) continue;

        int begin = int.parse(line.between(startTag, ","));
        int end = int.parse(line.between(",", endTag));
        String text = line.substring(line.indexOf(endTag) + 1).trim();
        lyricsArray
            .add(LineInfo.fromTextAndTimes(text, begin - offset, end - offset));
      } catch (e) {
        // Ignore parse errors
      }
    }
    return lyricsArray;
  }
}
