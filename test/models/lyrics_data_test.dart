import 'package:lyricify_lyrics_helper/models/lyrics_data.dart';
import 'package:lyricify_lyrics_helper/models/file_info.dart';
import 'package:lyricify_lyrics_helper/models/line_info.dart';
import 'package:lyricify_lyrics_helper/models/track_metadata.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_types.dart';
import 'package:lyricify_lyrics_helper/models/syllable_info.dart';
import 'package:test/test.dart';

void main() {
  group('LyricsData', () {
    test('toJson returns correct map with various line types', () {
      final lyricsData = LyricsData();
      lyricsData.file = FileInfo()..type = LyricsTypes.lrc;
      lyricsData.lines = [
        LineInfo()
          ..startTime = 1000
          ..text = 'Line 1',
        SyllableLineInfo.fromSyllables([
          SyllableInfo.create('Line', 2000, 2500),
          SyllableInfo.create(' 2', 2500, 3000),
        ]),
      ];
      lyricsData.writers = ['Writer 1', 'Writer 2'];
      lyricsData.trackMetadata = TrackMetadata()..title = 'Test Song';

      final json = lyricsData.toJson();

      expect(json['file'], isA<Map>());
      expect(json['file']['type'], 'lrc');
      expect(json['lines'], isA<List>());
      expect(json['lines'].length, 2);
      expect(json['lines'][0]['text'], 'Line 1');
      expect(json['lines'][1]['text'], 'Line 2');
      expect(json['writers'], ['Writer 1', 'Writer 2']);
      expect(json['trackMetadata'], isA<Map>());
      expect(json['trackMetadata']['title'], 'Test Song');
    });

    test('toJson handles null values', () {
      final lyricsData = LyricsData();
      final json = lyricsData.toJson();

      expect(json['file'], isNull);
      expect(json['lines'], isNull);
      expect(json['writers'], isNull);
      expect(json['trackMetadata'], isNull);
    });

    test('toString returns correct string', () {
      final lyricsData = LyricsData();
      final expectedString = lyricsData.toJson().toString();
      expect(lyricsData.toString(), expectedString);
    });
  });
}
