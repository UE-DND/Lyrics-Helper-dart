import 'dart:convert';

import '../models/i_line_info.dart';
import '../models/line_info.dart';
import '../models/lyrics_data.dart';
import '../models/lyrics_types.dart';
import '../models/syllable_info.dart';
import '../models/sync_types.dart';
import '../models/file_info.dart';
import '../models/additional_file_info.dart';
import 'models/spotify.dart';

class SpotifyParser {
  SpotifyParser._();

  static LyricsData? parse(String rawJson) {
    try {
      var colorLyrics = SpotifyColorLyrics.fromJson(json.decode(rawJson));
      var lyrics = _parseLyrics(colorLyrics.lyrics);
      var lyricsData = LyricsData()
        ..file = (FileInfo()
          ..type = LyricsTypes.spotify
          ..syncTypes = _getSyncType(colorLyrics.lyrics.syncType)
          ..additionalInfo = SpotifyAdditionalInfo())
        ..lines = lyrics;
      return lyricsData;
        } catch (e) {
      // Ignore parsing errors
    }
    return null;
  }

  static List<ILineInfo> _parseLyrics(SpotifyLyrics lyrics) {
    if (lyrics.syncType == "UNSYNCED") {
      return _parseUnsyncedLyrics(lyrics.lines).cast<ILineInfo>().toList();
    } else {
      return _parseSyncedLyrics(lyrics.lines);
    }
  }

  static List<LineInfo> _parseUnsyncedLyrics(List<SpotifyLyricsLine> lyrics) {
    return lyrics.map((line) => LineInfo.fromText(line.words)).toList();
  }

  static List<ILineInfo> _parseSyncedLyrics(List<SpotifyLyricsLine> lyrics) {
    var list = <ILineInfo>[];
    for (var line in lyrics) {
      if (line.syllables.isNotEmpty) {
        var syllables = <SyllableInfo>[];
        int i = 0;
        for (var syllable in line.syllables) {
          final charsCount = syllable.charsCount;
          syllables.add(SyllableInfo.create(
              line.words.substring(i, i + charsCount), syllable.startTime, syllable.endTime));
          i += charsCount;
        }
        list.add(SyllableLineInfo.fromSyllables(syllables));
      } else {
        if (line.endTime != 0) {
          list.add(LineInfo.fromTextAndTimes(line.words, line.startTime, line.endTime));
        } else {
          list.add(LineInfo.fromTextAndStartTime(line.words, line.startTime));
        }
      }
    }
    return list;
  }
  
  static SyncTypes _getSyncType(String syncType) {
    switch (syncType) {
      case "UNSYNCED":
        return SyncTypes.unsynced;
      case "LINE_SYNCED":
        return SyncTypes.lineSynced;
      case "SYLLABLE_SYNCED":
        return SyncTypes.syllableSynced;
      default:
        return SyncTypes.unknown;
    }
  }
} 