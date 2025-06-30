import 'dart:convert';

import '../models/file_info.dart';
import '../models/i_line_info.dart';
import '../models/i_syllable_info.dart';
import '../models/line_info.dart';
import '../models/lyrics_data.dart';
import '../models/lyrics_types.dart';
import '../models/syllable_info.dart';
import '../models/sync_types.dart';
import 'models/yrc.dart';

class YrcParser {
  YrcParser._();

  static LyricsData parse(String input) {
    var lyricsData = LyricsData()
      ..file = (FileInfo()
        ..type = LyricsTypes.yrc
        ..syncTypes = SyncTypes.syllableSynced);
    var lines = <ILineInfo>[];

    // Find first lyric line
    var firstLyricIndex = 0;
    for (var i = 0; i < input.length; i++) {
      if (input[i] == '[') {
        firstLyricIndex = i;
        break;
      }
    }

    // Parse credits from start
    if (firstLyricIndex > 0) {
      final creditsJson =
          input.substring(0, firstLyricIndex).trim().split('\n');
      for (final line in creditsJson) {
        try {
          final credits = CreditsInfo.fromJson(json.decode(line));
          lines.add(LineInfo.fromTextAndStartTime(
              credits.credits.map((c) => c.text).join(), credits.timestamp));
        } catch (e) {
          // ignore
        }
      }
    }

    // Find last lyric line
    var lastLyricIndex = input.length;
    for (var i = input.length - 1; i >= 0; i--) {
      if (input[i] == ')') {
        lastLyricIndex = i + 1;
        break;
      }
    }

    // Parse credits from end
    if (lastLyricIndex < input.length) {
      final creditsJson = input.substring(lastLyricIndex).trim().split('\n');
      final endCredits = <ILineInfo>[];
      for (final line in creditsJson) {
        try {
          final credits = CreditsInfo.fromJson(json.decode(line));
          endCredits.add(LineInfo.fromTextAndStartTime(
              credits.credits.map((c) => c.text).join(), credits.timestamp));
        } catch (e) {
          // ignore
        }
      }
      lines.addAll(endCredits);
    }

    // Parse lyrics
    final lyricsList = _parseOnlyLyrics(input, firstLyricIndex, lastLyricIndex);
    lines.addAll(lyricsList);

    lines.sort((a, b) => a.compareTo(b));
    lyricsData.lines = lines;
    return lyricsData;
  }

  static List<ILineInfo> _parseOnlyLyrics(
      String input, int startIndex, int endIndex) {
    var lines = <SyllableLineInfo>[];
    var karaokeWordInfos = <ISyllableInfo>[];
    var timeSpanBuilder = 0;
    var lyricStringBuilder = StringBuffer();
    var wordTimespan = 0;
    var wordDuration = 0;
    var state = _CurrentState.none;

    for (var i = startIndex; i < endIndex; i++) {
      var curChar = input[i];

      if (curChar == '\n' || curChar == '\r') {
        if (lyricStringBuilder.isNotEmpty) {
          karaokeWordInfos.add(SyllableInfo.create(
              lyricStringBuilder.toString(),
              wordTimespan,
              wordTimespan + wordDuration));
          lyricStringBuilder.clear();
        }
        if (karaokeWordInfos.isNotEmpty) {
          lines.add(SyllableLineInfo.fromSyllables(karaokeWordInfos));
          karaokeWordInfos = [];
        }
        state = _CurrentState.none;
        continue;
      }

      switch (curChar) {
        case '[':
          if (state == _CurrentState.lyric) {
            if (i + 1 < endIndex) {
              var nextChar = input[i + 1];
              if (nextChar.codeUnitAt(0) < '0'.codeUnitAt(0) ||
                  nextChar.codeUnitAt(0) > '9'.codeUnitAt(0)) {
                break;
              }
            }
          }
          state = _CurrentState.possiblyLyricTimestamp;
          continue;
        case ',':
          if (state == _CurrentState.lyric) {
            if (i + 1 < endIndex) {
              var nextChar = input[i + 1];
              if (nextChar.codeUnitAt(0) < '0'.codeUnitAt(0) ||
                  nextChar.codeUnitAt(0) > '9'.codeUnitAt(0)) {
                break;
              }
            }
          }
          if (state == _CurrentState.lyricTimestamp) {
            state = _CurrentState.possiblyLyricDuration;
            timeSpanBuilder = 0;
          } else if (state == _CurrentState.wordTimestamp) {
            state = _CurrentState.possiblyWordDuration;
            wordTimespan = timeSpanBuilder;
            timeSpanBuilder = 0;
          } else {
            state = _CurrentState.wordUnknownItem;
            wordDuration = timeSpanBuilder;
            timeSpanBuilder = 0;
          }
          continue;
        case ']':
          if (state == _CurrentState.lyric) {
            if (i + 1 < endIndex) {
              var nextChar = input[i + 1];
              if (nextChar.codeUnitAt(0) < '0'.codeUnitAt(0) ||
                  nextChar.codeUnitAt(0) > '9'.codeUnitAt(0)) {
                break;
              }
            }
          }
          state = _CurrentState.none;
          timeSpanBuilder = 0;
          continue;
        case '(':
          if (state == _CurrentState.lyric) {
            if (i + 1 < endIndex) {
              var nextChar = input[i + 1];
              if (nextChar.codeUnitAt(0) < '0'.codeUnitAt(0) ||
                  nextChar.codeUnitAt(0) > '9'.codeUnitAt(0)) {
                break;
              }
            }
            if (lyricStringBuilder.isNotEmpty) {
              karaokeWordInfos.add(SyllableInfo.create(
                  lyricStringBuilder.toString(),
                  wordTimespan,
                  wordTimespan + wordDuration));
              lyricStringBuilder.clear();
            }
          }
          state = _CurrentState.possiblyWordTimestamp;
          continue;
        case ')':
          if (state == _CurrentState.lyric) {
            if (i + 1 < endIndex) {
              var nextChar = input[i + 1];
              if (nextChar.codeUnitAt(0) < '0'.codeUnitAt(0) ||
                  nextChar.codeUnitAt(0) > '9'.codeUnitAt(0)) {
                break;
              }
            }
          }
          state = _CurrentState.lyric;
          continue;
      }

      var isDigit = curChar.codeUnitAt(0) >= '0'.codeUnitAt(0) &&
          curChar.codeUnitAt(0) <= '9'.codeUnitAt(0);

      switch (state) {
        case _CurrentState.possiblyLyricTimestamp:
        case _CurrentState.possiblyLyricDuration:
        case _CurrentState.possiblyWordTimestamp:
        case _CurrentState.possiblyWordDuration:
          if (isDigit) {
            if (state == _CurrentState.possiblyLyricTimestamp) {
              state = _CurrentState.lyricTimestamp;
            }
            if (state == _CurrentState.possiblyLyricDuration) {
              state = _CurrentState.lyricDuration;
            }
            if (state == _CurrentState.possiblyWordTimestamp) {
              state = _CurrentState.wordTimestamp;
            }
            if (state == _CurrentState.possiblyWordDuration) {
              state = _CurrentState.wordDuration;
            }
            timeSpanBuilder = timeSpanBuilder * 10 + int.parse(curChar);
          }
          break;
        case _CurrentState.lyric:
          lyricStringBuilder.write(curChar);
          break;
        case _CurrentState.lyricTimestamp:
        case _CurrentState.wordTimestamp:
        case _CurrentState.lyricDuration:
        case _CurrentState.wordDuration:
        case _CurrentState.wordUnknownItem:
          if (isDigit) {
            timeSpanBuilder = timeSpanBuilder * 10 + int.parse(curChar);
          }
          break;
        case _CurrentState.none:
          break;
      }
    }
    if (lyricStringBuilder.isNotEmpty) {
      karaokeWordInfos.add(SyllableInfo.create(lyricStringBuilder.toString(),
          wordTimespan, wordTimespan + wordDuration));
    }
    if (karaokeWordInfos.isNotEmpty) {
      lines.add(SyllableLineInfo.fromSyllables(karaokeWordInfos));
    }

    return lines;
  }
}

enum _CurrentState {
  none,
  lyricTimestamp,
  wordTimestamp,
  lyricDuration,
  wordDuration,
  possiblyLyricDuration,
  possiblyWordDuration,
  possiblyLyricTimestamp,
  possiblyWordTimestamp,
  wordUnknownItem,
  lyric
}
