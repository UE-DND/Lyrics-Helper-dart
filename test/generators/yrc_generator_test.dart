import 'package:lyricify_lyrics_helper/generators/yrc_generator.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_data.dart';
import 'package:lyricify_lyrics_helper/models/line_info.dart';
import 'package:lyricify_lyrics_helper/models/syllable_info.dart';
import 'package:test/test.dart';

void main() {
  group('YrcGenerator', () {
    test('generates basic YRC format', () {
      final line = SyllableLineInfo.fromSyllables([
        SyllableInfo.create('Hel', 100, 200),
        SyllableInfo.create('lo', 200, 300),
      ]);
      final data = LyricsData()..lines = [line];
      final expected = '[100,200](100,100,0)Hel(200,100,0)lo\n';
      final result = YrcGenerator.generate(data);
      expect(result, expected);
    });

    test('generates with subline', () {
      final mainLine =
          SyllableLineInfo.fromSyllables([SyllableInfo.create('main', 1, 2)]);
      final subLine =
          SyllableLineInfo.fromSyllables([SyllableInfo.create('sub', 3, 4)]);
      mainLine.subLine = subLine;
      final data = LyricsData()..lines = [mainLine];
      final expected = '[1,1](1,1,0)main\n[3,1](3,1,0)sub\n';
      final result = YrcGenerator.generate(data);
      expect(result, expected);
    });

    test('generates with FullSyllableInfo', () {
      final fullSyllable = FullSyllableInfo.fromSyllableInfos([
        SyllableInfo.create('a', 1, 2),
        SyllableInfo.create('b', 2, 3),
      ]);
      final line = SyllableLineInfo.fromSyllables([fullSyllable]);
      final data = LyricsData()..lines = [line];
      final expected = '[1,2](1,1,0)a(2,1,0)b\n';
      final result = YrcGenerator.generate(data);
      expect(result, expected);
    });

    test('ignores non-syllable lines', () {
      final data = LyricsData()..lines = [LineInfo.fromText('just a line')];
      final result = YrcGenerator.generate(data);
      expect(result, isEmpty);
    });
  });
}
