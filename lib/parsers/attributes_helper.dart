// coverage:ignore-file

import '../helpers/general/string_helper.dart';
import '../models/lyrics_data.dart';
import '../models/track_metadata.dart';
import '../models/additional_file_info.dart';

class AttributesHelper {
  AttributesHelper._(); // coverage:ignore-line

  static int? parseGeneralAttributesToLyricsData(
      LyricsData data, List<String> lines) {
    int? offset;
    data.trackMetadata ??= TrackMetadata();
    for (var i = 0; i < lines.length; i++) {
      if (_isAttributeLine(lines[i])) {
        var attribute = _getAttribute(lines[i]);
        switch (attribute.key) {
          case "ar":
            data.trackMetadata!.artist = attribute.value;
            break;
          case "al":
            data.trackMetadata!.album = attribute.value;
            break;
          case "ti":
            data.trackMetadata!.title = attribute.value;
            break;
          case "length":
            data.trackMetadata!.durationMs = int.tryParse(attribute.value);
            break;
          case "offset":
            offset = int.tryParse(attribute.value);
            break;
        }
        if (attribute.key == "hash" &&
            data.file!.additionalInfo is KrcAdditionalInfo) {
          (data.file!.additionalInfo as KrcAdditionalInfo).hash =
              attribute.value;
        } else if (data.file!.additionalInfo is GeneralAdditionalInfo) {
          (data.file!.additionalInfo as GeneralAdditionalInfo)
              .attributes!
              .add(attribute);
        }
        lines.removeAt(i--);
      } else {
        break;
      }
    }
    return offset;
  }

  static bool _isAttributeLine(String line) {
    line = line.trim();
    return line.startsWith('[') && line.endsWith(']') && line.contains(':');
  }

  static MapEntry<String, String> _getAttribute(String line) {
    line = line.trim();
    String key = line.between("[", ":");
    String value = line.substring(line.indexOf(':') + 1, line.length - 1);
    return MapEntry(key, value);
  }
}
