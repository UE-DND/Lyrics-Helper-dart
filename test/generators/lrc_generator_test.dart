import 'package:lyricify_lyrics_helper/generators/lrc_generator.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_data.dart';
import 'package:lyricify_lyrics_helper/models/line_info.dart';
import 'package:test/test.dart';

void main() {
  group('LrcGenerator', () {
    test('generates basic LRC', () {
      final data = LyricsData()
        ..lines = [
          LineInfo.fromTextAndStartTime('Line 1', 1230),
          LineInfo.fromTextAndStartTime('Line 2', 2450),
        ];
      final expected = '[00:01.23]Line 1\n[00:02.45]Line 2\n';
      final result = LrcGenerator.generate(data);
      expect(result, expected);
    });

    test('generates with endTimeOutputType.all', () {
      final data = LyricsData()
        ..lines = [
          LineInfo.fromTextAndTimes('Line 1', 1000, 2000),
        ];
      final expected = '[00:01.00]Line 1\n[00:02.00]\n';
      final result =
          LrcGenerator.generate(data, endTimeOutputType: EndTimeOutputType.all);
      expect(result, expected);
    });

    test('generates with endTimeOutputType.huge', () {
      final data = LyricsData()
        ..lines = [
          LineInfo.fromTextAndTimes('Line 1', 1000, 2000),
          LineInfo.fromTextAndTimes('Line 2', 8000, 9000), // > 5s gap
        ];
      final expected =
          '[00:01.00]Line 1\n[00:02.00]\n[00:08.00]Line 2\n[00:09.00]\n';
      final result = LrcGenerator.generate(data,
          endTimeOutputType: EndTimeOutputType.huge);
      expect(result, expected);
    });

    test('generates with subLinesOutputType.inDiffLine', () {
      final line = LineInfo.fromTextAndTimes('Main', 2000, 3000)
        ..subLine = LineInfo.fromTextAndTimes('Sub', 1000, 1500);
      final data = LyricsData()..lines = [line];
      final expected =
          '[00:02.00]Main\n[00:03.00]\n[00:01.00]Sub\n[00:01.50]\n';
      final result = LrcGenerator.generate(data,
          subLinesOutputType: SubLinesOutputType.inDiffLine,
          endTimeOutputType: EndTimeOutputType.all);
      expect(result, expected);
    });

    test('generates with subLinesOutputType.inMainLine', () {
      final line = LineInfo.fromTextAndTimes('Main', 2000, 3000)
        ..subLine = LineInfo.fromTextAndTimes('Sub', 1000, 1500);
      final data = LyricsData()..lines = [line];
      final expected = '[00:01.00](Sub) Main\n[00:03.00]\n';
      final result = LrcGenerator.generate(data,
          subLinesOutputType: SubLinesOutputType.inMainLine,
          endTimeOutputType: EndTimeOutputType.all);
      expect(result, expected);
    });

    test('handles empty data', () {
      final result = LrcGenerator.generate(LyricsData());
      expect(result, isEmpty);
    });
  });
}
