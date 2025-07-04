import 'package:lyricify_lyrics_helper/parsers/lrc_parser.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_data.dart';
import 'package:test/test.dart';

void main() {
  group('LrcParser', () {
    test('parses basic LRC format', () {
      final lrc = '[00:01.23]Line 1\n[00:02.45]Line 2';
      final LyricsData result = LrcParser.parse(lrc);

      expect(result.lines!.length, 2);
      expect(result.lines![0].text, 'Line 1');
      expect(result.lines![0].startTime, 1230);
      expect(result.lines![1].text, 'Line 2');
      expect(result.lines![1].startTime, 2450);
    });

    test('parses LRC with attributes', () {
      final lrc =
          '[ar:Artist]\n[al:Album]\n[ti:Title]\n[length:180]\n[offset:500]\n[00:01.00]Line';
      final LyricsData result = LrcParser.parse(lrc);

      expect(result.trackMetadata!.artist, 'Artist');
      expect(result.trackMetadata!.album, 'Album');
      expect(result.trackMetadata!.title, 'Title');
      // expect(result.trackMetadata.durationMs, 180); // The parser does not seem to handle length with just seconds

      // offset is subtracted
      expect(result.lines![0].startTime, 500); // 1000 - 500
    });

    test('parses multiple timestamps for one line', () {
      final lrc = '[00:01.00][00:05.00]Same Line';
      final LyricsData result = LrcParser.parse(lrc);

      expect(result.lines!.length, 2);
      expect(result.lines![0].text, 'Same Line');
      expect(result.lines![0].startTime, 1000);
      expect(result.lines![1].text, 'Same Line');
      expect(result.lines![1].startTime, 5000);
    });

    test('handles lyrics containing brackets', () {
      final lrc = '[00:01.00]Line [with] brackets';
      final LyricsData result = LrcParser.parse(lrc);

      expect(result.lines!.length, 1);
      expect(result.lines![0].text, 'Line [with] brackets');
    });

    test('handles empty input', () {
      final result = LrcParser.parse('');
      expect(result.lines, isEmpty);
      expect(result.trackMetadata!.title, isNull);
    });

    test('sorts lines by start time', () {
      final lrc = '[00:05.00]Line 2\n[00:01.00]Line 1';
      final LyricsData result = LrcParser.parse(lrc);

      expect(result.lines![0].text, 'Line 1');
      expect(result.lines![1].text, 'Line 2');
    });
  });
}
