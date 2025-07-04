import 'package:lyricify_lyrics_helper/helpers/generator_helper.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_data.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_types.dart';
import 'package:lyricify_lyrics_helper/models/line_info.dart';
import 'package:lyricify_lyrics_helper/models/syllable_info.dart';
import 'package:test/test.dart';

void main() {
  group('GenerateHelper', () {
    late LyricsData sampleLyrics;

    setUp(() {
      sampleLyrics = LyricsData()
        ..lines = [
          SyllableLineInfo.fromSyllables([
            SyllableInfo.create('Hello', 0, 500),
            SyllableInfo.create('World', 500, 1000),
          ]),
        ];
    });

    test('generateString returns LRC format string', () {
      final result =
          GenerateHelper.generateString(sampleLyrics, LyricsTypes.lrc);
      expect(result, isNotNull);
      expect(result, startsWith('[00:00.00]'));
      expect(result, contains('HelloWorld'));
    });

    test('generateString returns Lyricify Lines format string', () {
      final result = GenerateHelper.generateString(
          sampleLyrics, LyricsTypes.lyricifyLines);
      expect(result, isNotNull);
      expect(result, startsWith('[0,1000]'));
      expect(result, contains('HelloWorld'));
    });

    test('generateString returns Lyricify Syllable format string', () {
      final result = GenerateHelper.generateString(
          sampleLyrics, LyricsTypes.lyricifySyllable);
      expect(result, isNotNull);
      expect(result, contains('Hello(0,500)'));
      expect(result, contains('World(500,500)'));
    });

    test('generateString returns YRC format string', () {
      final result =
          GenerateHelper.generateString(sampleLyrics, LyricsTypes.yrc);
      expect(result, isNotNull);
      expect(result, contains('(0,500,0)Hello')); // YRC format check
    });

    test('generateString returns null for unknown type', () {
      final result =
          GenerateHelper.generateString(sampleLyrics, LyricsTypes.unknown);
      expect(result, isNull);
    });
  });
}
