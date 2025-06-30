import 'dart:convert';

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
import '../models/track_metadata.dart';
import '../decrypter/krc/model.dart';
import 'attributes_helper.dart';

class KrcParser {
  KrcParser._();

  static LyricsData parse(String krc) {
    var data = LyricsData()
      ..file = (FileInfo()
        ..type = LyricsTypes.krc
        ..syncTypes = SyncTypes.syllableSynced
        ..additionalInfo = (KrcAdditionalInfo()..attributes = []))
      ..trackMetadata = TrackMetadata();

    var lyricsLines = _getSplitedKrc(krc).toList();
    var offset = AttributesHelper.parseGeneralAttributesToLyricsData(data, lyricsLines);
    var lyrics = _parseLyrics(lyricsLines, offset);

    // 翻译处理（仅当歌词中带有 [language:...] 信息时）
    if (KrcTranslationParser.checkKrcTranslation(krc)) {
      var lyricsTrans = KrcTranslationParser.getTranslationFromKrc(krc);
      if (lyricsTrans != null) {
        for (int i = 0; i < lyrics.length && i < lyricsTrans.length; i++) {
          String t = lyricsTrans[i];
          t = t != "//" ? t : "";
          lyrics[i] = FullSyllableLineInfo.fromSyllableLineInfoWithExtra(
            lyrics[i] as SyllableLineInfo,
            chineseTranslation: t,
          );
        }
      }
    }

    data.lines = lyrics;
    return data;
  }

  /// 仅解析歌词部分（可供外部单独使用）
  static List<ILineInfo> parseLyrics(String krc) {
    var lyricsLines = _getSplitedKrcWithoutInfoLine(krc);
    var lyrics = _parseLyrics(lyricsLines, null);

    if (KrcTranslationParser.checkKrcTranslation(krc)) {
      var lyricsTrans = KrcTranslationParser.getTranslationFromKrc(krc);
      if (lyricsTrans != null) {
        for (int i = 0; i < lyrics.length && i < lyricsTrans.length; i++) {
          String t = lyricsTrans[i];
          t = t != "//" ? t : "";
          lyrics[i] = FullSyllableLineInfo.fromSyllableLineInfoWithExtra(
            lyrics[i] as SyllableLineInfo,
            chineseTranslation: t,
          );
        }
      }
    }

    return lyrics;
  }

  static List<ILineInfo> _parseLyrics(List<String> lyricsLines, int? offset) {
    var lyrics = <ILineInfo>[];
    for (var line in lyricsLines) {
      if (line.startsWith('[')) {
        var l = _parseLyricsLine(line);
        if (l != null) {
          lyrics.add(l);
        }
      }
    }
    if (offset != null && offset != 0) {
      OffsetHelper.addOffset(lyrics, offset);
    }
    return lyrics;
  }

  static List<String> _getSplitedKrc(String krc) {
    final lines = krc.replaceAll('\r', '').split('\n');
    final buffer = StringBuffer();
    for (var line in lines) {
      if (line.startsWith('[')) {
        buffer.writeln(line);
      }
    }
    return buffer.toString().replaceAll('\r', '').split('\n');
  }

  /// 拆分并移除附加信息行
  static List<String> _getSplitedKrcWithoutInfoLine(String krc) {
    final lines = krc.replaceAll('\r', '').split('\n');
    final buffer = StringBuffer();
    for (var line in lines) {
      if (line.startsWith('[') && line.length >= 5 && line[1].isNumber()) {
        buffer.writeln(line);
      }
    }
    return buffer.toString().replaceAll('\r', '').split('\n');
  }

  static SyllableLineInfo? _parseLyricsLine(String line) {
    try {
      final parts = line.split(']');
      final timeParts = parts[0].substring(1).split(',');
      final lineStart = int.parse(timeParts[0]);
      
      final wordParts = parts[1].split(RegExp(r'<[0-9]'));
      if (wordParts.isEmpty) return null;

      var syllables = <ISyllableInfo>[];
      
      for (var wordPart in wordParts) {
          if (wordPart.isEmpty) continue;
          final timeMatches = RegExp(r'(\d+),(\d+),(\d+)>(.*)').firstMatch(wordPart);
          if (timeMatches == null) continue;

          final start = int.parse(timeMatches.group(1)!);
          final duration = int.parse(timeMatches.group(2)!);
          final text = timeMatches.group(4) ?? '';

          syllables.add(SyllableInfo.create(text, lineStart + start, lineStart + start + duration));
      }
      return SyllableLineInfo.fromSyllables(syllables);
    } catch (e) {
      return null;
    }
  }
}

/// 处理 KRC 内嵌翻译信息
class KrcTranslationParser {
  KrcTranslationParser._();

  static bool checkKrcTranslation(String krc) {
    if (!krc.contains('[language:')) return false;
    try {
      final language = krc.between('[language:', ']');
      final decode = utf8.decode(base64.decode(language));
      final translation = KugouTranslation.fromJson(json.decode(decode) as Map<String, dynamic>);
      return (translation.content?.isNotEmpty ?? false);
    } catch (_) {
      return false;
    }
  }

  static List<String>? getTranslationFromKrc(String krc) {
    if (!krc.contains('[language:')) return null;
    try {
      final language = krc.between('[language:', ']');
      final decode = utf8.decode(base64.decode(language));
      final translation = KugouTranslation.fromJson(json.decode(decode) as Map<String, dynamic>);
      if (translation.content?.isEmpty ?? true) return null;
      final content = translation.content?.firstWhere(
        (t) => t.type == 1,
        orElse: () => ContentItem(),
      );
      if (content == null || content.lyricContent == null) return null;
      return content.lyricContent!.map((c) => c?[0] ?? '').toList();
    } catch (_) {
      return null;
    }
  }

  static KugouTranslation? getTranslationRawFromKrc(String krc) {
    if (!krc.contains('[language:')) return null;
    try {
      final language = krc.between('[language:', ']');
      final decode = utf8.decode(base64.decode(language));
      return KugouTranslation.fromJson(json.decode(decode) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }
}