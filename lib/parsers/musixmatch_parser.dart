import 'dart:convert';
import '../models/i_line_info.dart';
import '../models/line_info.dart';
import '../models/lyrics_data.dart';
import '../models/lyrics_types.dart';
import '../models/syllable_info.dart';
import '../models/sync_types.dart';
import '../models/file_info.dart';
import 'lrc_parser.dart';
import 'models/musixmatch.dart';

class MusixmatchParser {
  MusixmatchParser._();

  static LyricsData? parse(String rawJson, {bool ignoreSyllable = false}) {
    try {
      final dynamic jsonObj = json.decode(rawJson);
      final dynamic calls = jsonObj?['message']?['body']?['macro_calls'];
      if (calls == null) return null;

      bool checkHeader200(dynamic getObj) {
        return getObj?['message']?['header']?['status_code'] == 200;
      }

      // RichSync
      if (!ignoreSyllable) {
        final dynamic trackGet = calls['track.richsync.get'];
        if (checkHeader200(trackGet)) {
          final String? lyrics =
              trackGet?['message']?['body']?['richsync']?['richsync_body'];
          if (lyrics != null && lyrics.isNotEmpty) {
            final List<dynamic> list = json.decode(lyrics);
            final richSyncLines =
                list.map((e) => RichSyncedLine.fromJson(e)).toList();

            var lines = <ILineInfo>[];
            for (var line in richSyncLines) {
              var syllables = <SyllableInfo>[];
              var start = (line.timeStart * 1000).toInt();
              for (int i = 0; i < line.words.length; i++) {
                syllables.add(SyllableInfo.create(
                  line.words[i].chars,
                  start + (line.words[i].position * 1000).toInt(),
                  i + 1 < line.words.length
                      ? start + (line.words[i + 1].position * 1000).toInt()
                      : (line.timeEnd * 1000).toInt(),
                ));
              }
              lines.add(SyllableLineInfo.fromSyllables(syllables));
            }
            return LyricsData()
              ..file = (FileInfo()
                ..type = LyricsTypes.musixmatch
                ..syncTypes = SyncTypes.syllableSynced)
              ..lines = lines;
          }
        }
      }

      // Subtitles (LRC)
      final dynamic trackGetSubs = calls['track.subtitles.get'];
      if (checkHeader200(trackGetSubs)) {
        final List<dynamic>? list =
            trackGetSubs?['message']?['body']?['subtitle_list'];
        if (list != null && list.isNotEmpty) {
          final String? subtitle = list[0]?['subtitle']?['subtitle_body'];
          if (subtitle != null && subtitle.isNotEmpty) {
            var lrcData = LrcParser.parse(subtitle);
            lrcData.file?.type = LyricsTypes.musixmatch;
            return lrcData;
          }
        }
      }

      // Unsynced
      final dynamic trackGetLyrics = calls['track.lyrics.get'];
      if (checkHeader200(trackGetLyrics)) {
        final String? lyrics =
            trackGetLyrics?['message']?['body']?['lyrics']?['lyrics_body'];
        if (lyrics != null && lyrics.isNotEmpty) {
          var lines = lyrics
              .trim()
              .split('\n')
              .map((line) => LineInfo.fromText(line))
              .toList();
          return LyricsData()
            ..file = (FileInfo()
              ..type = LyricsTypes.musixmatch
              ..syncTypes = SyncTypes.unsynced)
            ..lines = lines;
        }
      }
    } catch (e) {
      // Ignore parsing errors
    }
    return null;
  }
}
