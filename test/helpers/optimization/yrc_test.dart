import 'package:lyricify_lyrics_helper/helpers/optimization/yrc.dart';
import 'package:lyricify_lyrics_helper/models/line_info.dart';
import 'package:lyricify_lyrics_helper/models/syllable_info.dart';
import 'package:test/test.dart';

void main() {
  group('Yrc Optimizer', () {
    test('removes trailing space syllables', () {
      final line = SyllableLineInfo.fromSyllables([
        SyllableInfo.create('Hello', 0, 100),
        SyllableInfo.create(' ', 100, 200),
      ]);
      Yrc.standardizeYrcLyricsForSyllableLine(line);
      expect(line.syllables, hasLength(1));
      expect(line.text, 'Hello');
    });

    test('removes empty syllables', () {
      final line = SyllableLineInfo.fromSyllables([
        SyllableInfo.create('Hello', 0, 100),
        SyllableInfo.create('', 100, 200),
        SyllableInfo.create('World', 200, 300),
      ]);
      Yrc.standardizeYrcLyricsForSyllableLine(line);
      expect(line.syllables, hasLength(2));
      expect(line.text, 'HelloWorld');
    });

    test('merges space syllables into previous syllable', () {
      final line = SyllableLineInfo.fromSyllables([
        SyllableInfo.create('Hello', 0, 100),
        SyllableInfo.create(' ', 100, 200),
        SyllableInfo.create('World', 200, 300),
      ]);
      Yrc.standardizeYrcLyricsForSyllableLine(line);
      expect(line.syllables, hasLength(2));
      expect(line.syllables.first.text, 'Hello ');
      expect(line.text, 'Hello World');
    });

    test('merges punctuation syllables into previous syllable', () {
      final line = SyllableLineInfo.fromSyllables([
        SyllableInfo.create('Hello', 0, 100),
        SyllableInfo.create(',', 100, 200),
        SyllableInfo.create(' World', 200, 300),
      ]);
      Yrc.standardizeYrcLyricsForSyllableLine(line);
      expect(line.syllables, hasLength(2));
      expect(line.syllables.first.text, 'Hello,');
      expect(line.text, 'Hello, World');
    });
  });
}
