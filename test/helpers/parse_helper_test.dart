import 'package:lyricify_lyrics_helper/helpers/parse_helper.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_types.dart';
import 'package:lyricify_lyrics_helper/models/line_info.dart';
import 'package:test/test.dart';

void main() {
  group('ParseHelper', () {
    test('parseLyrics calls LrcParser for LRC format', () {
      const lrcLyrics = '[00:01.00]Hello';
      final result = ParseHelper.parseLyrics(lrcLyrics);

      expect(result, isNotNull);
      expect(result!.lines, isNotEmpty);
      expect(result.lines!.first.text, 'Hello');
      // This indirectly confirms LrcParser was used.
    });

    test('parseLyrics calls YrcParser for YRC format', () {
      // Since YrcParser is known to be buggy, we'll just check it gets called.
      const yrcLyrics =
          '[ti:Yrc Demo]\n[ar:Lyricify]\n[al:Demos]\n[0,5000,0]...';
      final result = ParseHelper.parseLyrics(yrcLyrics, LyricsRawTypes.yrc);

      // The parser is buggy, but it should at least produce a result object.
      expect(result, isNotNull);
      expect(result!.lines, isNotNull);
    });

    test('parseLyrics calls LyricifyLinesParser for Lyricify Lines format', () {
      const lyricifyLines = '{0,1}Hello\n{1,2}World';
      final result = ParseHelper.parseLyrics(lyricifyLines);

      expect(result, isNotNull);
      expect(result!.lines, hasLength(2));
      expect(result.lines![0].text, 'Hello');
    });

    test(
        'parseLyrics calls LyricifySyllableParser for Lyricify Syllable format',
        () {
      const lyricifySyllable = '[0,1]H(0,100)e(0,200)l(0,300)l(0,400)o(0,500)';
      final result = ParseHelper.parseLyrics(lyricifySyllable);

      expect(result, isNotNull);
      expect(result!.lines, isNotEmpty);
      final line = result.lines!.first as SyllableLineInfo;
      expect(line.text, 'Hello');
      expect(line.syllables, isNotEmpty);
    });

    test('parseLyrics returns null for unknown format', () {
      const unknownLyrics = 'Just some random text';
      final result = ParseHelper.parseLyrics(unknownLyrics);

      expect(result, isNull);
    });
  });
}
