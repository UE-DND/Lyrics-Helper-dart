import '../models/i_line_info.dart';
import '../models/line_info.dart';
import '../models/lyrics_data.dart';
import '../models/lyrics_types.dart';
import '../models/sync_types.dart';
import '../models/track_metadata.dart';
import '../models/additional_file_info.dart';
import '../models/file_info.dart';

class LrcParser {
  LrcParser._();

  static LyricsData parse(String input) {
    var lines = <LineInfo>[];
    var attributeName = '';
    var attributes = <MapEntry<String, String>>[];
    var trackMetadata = TrackMetadata();
    var curStateStartPosition = 0;
    var timeCalculationCache = 0;
    var curTimestamps = List.filled(64, -1, growable: true);
    var curTimestamp = 0;
    var currentTimestampPosition = 0;
    var offset = 0;
    var reachesEnd = false;
    var lastCharacterIsLineBreak = false;
    var state = _CurrentState.none;
    var timeStampType = _TimeStampType.none;

    for (var i = 0; i < input.length; i++) {
      var curChar = input[i];

      if (state == _CurrentState.lyric) {
        if (curChar != '\n' && curChar != '\r' && i + 1 < input.length) {
          continue;
        } else {
          if (i + 1 < input.length) {
            for (int j = 0; j < curTimestamps.length; j++) {
              if (curTimestamps[j] == -1) break;
              lines.add(LineInfo.fromTextAndStartTime(
                  input.substring(curStateStartPosition + 1, i).trim(),
                  curTimestamps[j] - offset));
            }
            if (input[i + 1] == '\n' || input[i + 1] == '\r') i++;
            currentTimestampPosition = 0;
            state = _CurrentState.none;
            continue;
          }
          if (i + 1 == input.length) {
            reachesEnd = true;
            if (curChar == '\r' || curChar == '\n') {
              lastCharacterIsLineBreak = true;
            }
          }
        }
      }

      if (reachesEnd && state == _CurrentState.lyric) {
        for (int j = 0; j < curTimestamps.length; j++) {
          if (curTimestamps[j] == -1) break;
          lines.add(LineInfo.fromTextAndStartTime(
              input
                  .substring(curStateStartPosition + 1,
                      lastCharacterIsLineBreak ? i : i + 1)
                  .trim(),
              curTimestamps[j] - offset));
        }
        continue;
      }

      switch (state) {
        case _CurrentState.possiblyLyric:
          if (curChar == '[') {
            state = _CurrentState.awaitingStateLyric;
          } else {
            i -= 1;
            state = _CurrentState.lyric;
          }
          break;
        case _CurrentState.none:
          curTimestamps.fillRange(0, curTimestamps.length, -1);
          if (curChar == '[') {
            state = _CurrentState.awaitingState;
          }
          break;
        case _CurrentState.awaitingState:
          if ('0'.codeUnitAt(0) <= curChar.codeUnitAt(0) &&
              curChar.codeUnitAt(0) <= '9'.codeUnitAt(0)) {
            state = _CurrentState.timestamp;
            timeStampType = _TimeStampType.minutes;
            curStateStartPosition = i;
            curTimestamp = 0;
            i--;
          } else {
            state = _CurrentState.attribute;
            curStateStartPosition = i;
          }
          break;
        case _CurrentState.awaitingStateLyric:
          if ('0'.codeUnitAt(0) <= curChar.codeUnitAt(0) &&
              curChar.codeUnitAt(0) <= '9'.codeUnitAt(0)) {
            state = _CurrentState.timestamp;
            timeStampType = _TimeStampType.minutes;
            curStateStartPosition = i;
            curTimestamp = 0;
            i--;
          } else {
            state = _CurrentState.lyric;
            curStateStartPosition = i - 2;
          }
          break;
        case _CurrentState.attribute:
          if (curChar == ':') {
            attributeName = input.substring(curStateStartPosition, i);
            curStateStartPosition = i + 1;
            state = _CurrentState.attributeContent;
          }
          break;
        case _CurrentState.attributeContent:
          if (curChar == ']') {
            String attributeValue;
            if (attributeName == "offset") {
              offset = timeCalculationCache;
              timeCalculationCache = 0;
              attributeValue = offset.toString();
            } else {
              attributeValue = input.substring(curStateStartPosition, i);
            }
            var attribute =
                MapEntry<String, String>(attributeName, attributeValue);
            switch (attribute.key) {
              case "ar":
                trackMetadata.artist = attribute.value;
                break;
              case "al":
                trackMetadata.album = attribute.value;
                break;
              case "ti":
                trackMetadata.title = attribute.value;
                break;
              case "length":
                trackMetadata.durationMs = int.tryParse(attribute.value);
                break;
            }
            attributes.add(attribute);
            attributeName = '';
            state = _CurrentState.none;
            break;
          }
          if (attributeName == "offset") {
            timeCalculationCache =
                timeCalculationCache * 10 + int.parse(curChar);
            continue;
          }
          break;
        case _CurrentState.timestamp:
          if (timeStampType == _TimeStampType.milliseconds) {
            if (curChar != ']') {
              timeCalculationCache =
                  timeCalculationCache * 10 + int.parse(curChar);
              continue;
            } else {
              var pow = i - curStateStartPosition - 1;
              curTimestamp += timeCalculationCache * pow_10(3 - pow);
              if (currentTimestampPosition + 1 >= curTimestamps.length)
                curTimestamps.add(-1);
              curTimestamps[currentTimestampPosition++] = curTimestamp;
              timeStampType = _TimeStampType.none;
              timeCalculationCache = 0;
              curStateStartPosition = i;
              curTimestamp = 0;
              state = _CurrentState.possiblyLyric;
              continue;
            }
          }
          switch (curChar) {
            case ':':
            case '.':
              if (timeStampType == _TimeStampType.minutes) {
                curTimestamp = (curTimestamp + timeCalculationCache) * 60;
                timeCalculationCache = 0;
                timeStampType = _TimeStampType.seconds;
                continue;
              }
              if (timeStampType == _TimeStampType.seconds) {
                curTimestamp = (curTimestamp + timeCalculationCache) * 1000;
                curStateStartPosition = i;
                timeCalculationCache = 0;
                timeStampType = _TimeStampType.milliseconds;
                continue;
              }
              throw ArgumentError("Invalid LRC format");
            case ']':
              if (currentTimestampPosition + 1 >= curTimestamps.length)
                curTimestamps.add(-1);
              curTimestamps[currentTimestampPosition++] =
                  (curTimestamp + timeCalculationCache) * 1000;
              timeCalculationCache = 0;
              curStateStartPosition = i;
              curTimestamp = 0;
              state = _CurrentState.possiblyLyric;
              timeStampType = _TimeStampType.none;
              continue;
            default:
              timeCalculationCache =
                  timeCalculationCache * 10 + int.parse(curChar);
              break;
          }
          break;
        default:
          throw ArgumentError("Invalid state");
      }
    }

    lines.sort((a, b) => a.compareTo(b));

    var lyricsData = LyricsData()
      ..trackMetadata = trackMetadata
      ..lines = lines.cast<ILineInfo>().toList()
      ..file = (FileInfo()
        ..type = LyricsTypes.lrc
        ..syncTypes = SyncTypes.lineSynced
        ..additionalInfo = (GeneralAdditionalInfo()..attributes = attributes));

    return lyricsData;
  }
}

int pow_10(int n) {
  int result = 1;
  for (int i = 0; i < n; i++) {
    result *= 10;
  }
  return result;
}

enum _CurrentState {
  none,
  awaitingState,
  awaitingStateLyric,
  attribute,
  attributeContent,
  timestamp,
  possiblyLyric,
  lyric
}

enum _TimeStampType {
  minutes,
  seconds,
  milliseconds,
  none,
}
