import 'package:lyricify_lyrics_helper/parsers/lyricify_lines_parser.dart';
import 'package:test/test.dart';

void main() {
  group('LyricifyLinesParser', () {
    test('parses basic format', () {
      final lyrics = '[1000,2000]Line 1\n[2000,3000]Line 2';
      final result = LyricifyLinesParser.parse(lyrics);

      expect(result.lines!.length, 2);
      expect(result.lines![0].text, 'Line 1');
      expect(result.lines![0].startTime, 1000);
      expect(result.lines![0].endTime, 2000);
      expect(result.lines![1].text, 'Line 2');
      expect(result.lines![1].startTime, 2000);
      expect(result.lines![1].endTime, 3000);
    });

    test('parses with type tag and attributes', () {
      final lyrics =
          '[type:LyricifyLines]\n[ar:Artist]\n[ti:Title]\n[offset:500]\n[1000,2000]Line 1';
      final result = LyricifyLinesParser.parse(lyrics);

      expect(result.trackMetadata!.artist, 'Artist');
      expect(result.trackMetadata!.title, 'Title');
      expect(result.lines!.length, 1);
      expect(result.lines![0].startTime, 500); // 1000 - 500
      expect(result.lines![0].endTime, 1500); // 2000 - 500
    });

    test('ignores malformed lines', () {
      final lyrics = '[1000,2000]Line 1\nnot a valid line\n[3000,4000]Line 2';
      final result = LyricifyLinesParser.parse(lyrics);

      expect(result.lines!.length, 2);
      expect(result.lines![0].text, 'Line 1');
      expect(result.lines![1].text, 'Line 2');
    });

    test('handles empty input', () {
      final result = LyricifyLinesParser.parse('');
      expect(result.lines, isEmpty);
      expect(result.trackMetadata, isNotNull);
      expect(result.trackMetadata!.title, isNull);
    });

    test('handles input with only attributes', () {
      final lyrics = '[ar:Artist]\n[ti:Title]';
      final result = LyricifyLinesParser.parse(lyrics);

      expect(result.lines, isEmpty);
      expect(result.trackMetadata!.artist, 'Artist');
    });
  });
}
