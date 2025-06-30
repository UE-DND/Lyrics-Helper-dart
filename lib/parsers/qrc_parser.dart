import '../models/i_line_info.dart';
import '../models/lyrics_data.dart';
import '../models/lyrics_types.dart';
import '../models/sync_types.dart';
import '../models/additional_file_info.dart';
import '../models/file_info.dart';
import '../models/line_info.dart';
import '../models/syllable_info.dart';
import '../helpers/offset_helper.dart';
import 'attributes_helper.dart';

class QrcParser {
  QrcParser._();

  static LyricsData parse(String lyrics) {
    var lyricsLines = lyrics.trim().split('\n').toList();
    var data = LyricsData()
      ..file = (FileInfo()
        ..type = LyricsTypes.qrc
        ..syncTypes = SyncTypes.syllableSynced
        ..additionalInfo = (GeneralAdditionalInfo()..attributes = []));

    // 处理 Attributes
    var offset =
        AttributesHelper.parseGeneralAttributesToLyricsData(data, lyricsLines);

    // 处理歌词行
    var lines = _parseLyrics(lyricsLines, offset);

    data.lines = lines;
    return data;
  }

  static List<ILineInfo> _parseLyrics(List<String> lines, int? offset) {
    var list = <SyllableLineInfo>[];

    for (var line in lines) {
      var item = _parseLyricsLine(line);
      if (item != null) {
        list.add(item);
      }
    }

    var returnList = list.cast<ILineInfo>().toList();
    if (offset != null && offset != 0) {
      OffsetHelper.addOffset(returnList, offset);
    }

    return returnList;
  }

  static SyllableLineInfo? _parseLyricsLine(String line) {
    if (line.contains(']')) {
      line = line.substring(line.indexOf("]") + 1);
    }

    List<SyllableInfo> lyricItems = [];
    RegExp regex = RegExp(r"(.*?)\((\d+),(\d+)\)");
    var matches = regex.allMatches(line);

    for (var match in matches) {
      if (match.groupCount == 3) {
        String text = match.group(1)!;
        int startTime = int.parse(match.group(2)!);
        int duration = int.parse(match.group(3)!);
        int endTime = startTime + duration;
        lyricItems.add(SyllableInfo.create(text, startTime, endTime));
      }
    }

    return SyllableLineInfo.fromSyllables(lyricItems);
  }
}
