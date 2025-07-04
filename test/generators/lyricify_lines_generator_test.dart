import 'package:lyricify_lyrics_helper/generators/lyricify_lines_generator.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_data.dart';
import 'package:lyricify_lyrics_helper/models/line_info.dart';
import 'package:test/test.dart';

void main() {
  group('LyricifyLinesGenerator', () {
    test('generates basic format', () {
      final data = LyricsData()
        ..lines = [
          LineInfo.fromTextAndTimes('Line 1', 1000, 2000),
          LineInfo.fromTextAndTimes('Line 2', 2000, 3000),
        ];
      final expected = '[1000,2000]Line 1\n[2000,3000]Line 2\n';
      final result = LyricifyLinesGenerator.generate(data);
      expect(result, expected);
    });

    test('generates with subLinesOutputType.inDiffLine', () {
      final line = LineInfo.fromTextAndTimes('Main', 2000, 3000)
        ..subLine = LineInfo.fromTextAndTimes('Sub', 1000, 1500);
      final data = LyricsData()..lines = [line];
      final expected = '[2000,3000]Main\n[1000,1500]Sub\n';
      final result = LyricifyLinesGenerator.generate(data,
          subLinesOutputType: SubLinesOutputType.inDiffLine);
      expect(result, expected);
    });

    test('generates with subLinesOutputType.inMainLine', () {
      final line = LineInfo.fromTextAndTimes('Main', 2000, 3000)
        ..subLine = LineInfo.fromTextAndTimes('Sub', 1000, 1500);
      final data = LyricsData()..lines = [line];
      final expected = '[1000,3000](Sub) Main\n';
      final result = LyricifyLinesGenerator.generate(data,
          subLinesOutputType: SubLinesOutputType.inMainLine);
      expect(result, expected);
    });

    test('handles null endTime', () {
      final data = LyricsData()
        ..lines = [
          LineInfo.fromTextAndStartTime('Line 1', 1000),
        ];
      final expected = '[1000,0]Line 1\n';
      final result = LyricifyLinesGenerator.generate(data);
      expect(result, expected);
    });

    test('handles empty data', () {
      final result = LyricifyLinesGenerator.generate(LyricsData());
      expect(result, isEmpty);
    });
  });
}
