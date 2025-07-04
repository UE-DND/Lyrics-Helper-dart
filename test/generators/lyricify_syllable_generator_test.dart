import 'package:lyricify_lyrics_helper/generators/lyricify_syllable_generator.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_data.dart';
import 'package:lyricify_lyrics_helper/models/line_info.dart';
import 'package:lyricify_lyrics_helper/models/syllable_info.dart';
import 'package:lyricify_lyrics_helper/models/i_line_info.dart';
import 'package:test/test.dart';

void main() {
  group('LyricifySyllableGenerator', () {
    test('generates basic syllable format', () {
      final line = SyllableLineInfo.fromSyllables([
        SyllableInfo.create('Hel', 100, 200),
        SyllableInfo.create('lo', 200, 300),
      ]);
      final data = LyricsData()..lines = [line];
      final expected = '[3]Hel(100,100)lo(200,100)\n';
      final result = LyricifySyllableGenerator.generate(data);
      expect(result, expected);
    });

    test('generates with alignment', () {
      final line =
          SyllableLineInfo.fromSyllables([SyllableInfo.create('a', 1, 2)])
            ..lyricsAlignment = LyricsAlignment.left;
      final data = LyricsData()..lines = [line];
      final expected = '[4]a(1,1)\n';
      final result = LyricifySyllableGenerator.generate(data);
      expect(result, expected);
    });

    test('generates with subline', () {
      final mainLine =
          SyllableLineInfo.fromSyllables([SyllableInfo.create('main', 1, 2)]);
      final subLine =
          SyllableLineInfo.fromSyllables([SyllableInfo.create('sub', 3, 4)]);
      mainLine.subLine = subLine;
      final data = LyricsData()..lines = [mainLine];
      final expected = '[3]main(1,1)\n[6]sub(3,1)\n';
      final result = LyricifySyllableGenerator.generate(data);
      expect(result, expected);
    });

    test('generates with FullSyllableInfo', () {
      final fullSyllable = FullSyllableInfo.fromSyllableInfos([
        SyllableInfo.create('a', 1, 2),
        SyllableInfo.create('b', 2, 3),
      ]);
      final line = SyllableLineInfo.fromSyllables([fullSyllable]);
      final data = LyricsData()..lines = [line];
      final expected = '[3]a(1,1)b(2,1)\n';
      final result = LyricifySyllableGenerator.generate(data);
      expect(result, expected);
    });

    test('ignores non-syllable lines', () {
      final data = LyricsData()..lines = [LineInfo.fromText('just a line')];
      final result = LyricifySyllableGenerator.generate(data);
      expect(result, isEmpty);
    });
  });
}
