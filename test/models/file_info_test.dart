import 'package:lyricify_lyrics_helper/models/file_info.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_types.dart';
import 'package:lyricify_lyrics_helper/models/sync_types.dart';
import 'package:lyricify_lyrics_helper/models/additional_file_info.dart';
import 'package:test/test.dart';

void main() {
  group('FileInfo', () {
    test('default values are correct', () {
      final fileInfo = FileInfo();
      expect(fileInfo.type, LyricsTypes.unknown);
      expect(fileInfo.syncTypes, SyncTypes.unknown);
      expect(fileInfo.additionalInfo, isNull);
    });

    test('toJson returns correct map', () {
      final generalInfo = GeneralAdditionalInfo()
        ..attributes = [const MapEntry('artist', 'Test Artist')];
      final fileInfo = FileInfo()
        ..type = LyricsTypes.lrc
        ..syncTypes = SyncTypes.lineSynced
        ..additionalInfo = generalInfo;

      final json = fileInfo.toJson();

      expect(json['type'], 'lrc');
      expect(json['syncTypes'], 'lineSynced');
      expect(json['additionalInfo'], isA<Map>());
      expect(json['additionalInfo']['attributes'][0]['key'], 'artist');
    });

    test('toJson handles null additionalInfo', () {
      final fileInfo = FileInfo();
      final json = fileInfo.toJson();
      expect(json['additionalInfo'], isNull);
    });

    test('toString returns correct string', () {
      final fileInfo = FileInfo();
      final expectedString = fileInfo.toJson().toString();
      expect(fileInfo.toString(), expectedString);
    });
  });
}
