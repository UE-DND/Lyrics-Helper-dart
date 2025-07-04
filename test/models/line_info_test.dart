import 'package:lyricify_lyrics_helper/models/line_info.dart';
import 'package:lyricify_lyrics_helper/models/syllable_info.dart';
import 'package:test/test.dart';

void main() {
  group('LineInfo', () {
    test('constructors work correctly', () {
      final line1 = LineInfo();
      expect(line1.text, '');

      final line2 = LineInfo.fromText('Hello');
      expect(line2.text, 'Hello');

      final line3 = LineInfo.fromTextAndStartTime('World', 1000);
      expect(line3.text, 'World');
      expect(line3.startTime, 1000);

      final line4 = LineInfo.fromTextAndTimes('!', 2000, 3000);
      expect(line4.text, '!');
      expect(line4.startTime, 2000);
      expect(line4.endTime, 3000);
    });

    test('duration is calculated correctly', () {
      final line = LineInfo.fromTextAndTimes('test', 1000, 2500);
      expect(line.duration, 1500);
    });

    test('fullText works with subLine', () {
      final mainLine = LineInfo.fromTextAndStartTime('Main', 2000);
      mainLine.subLine = LineInfo.fromTextAndStartTime('Sub', 1000);
      expect(mainLine.fullText, '(Sub) Main');

      mainLine.subLine = LineInfo.fromTextAndStartTime('Sub', 3000);
      expect(mainLine.fullText, 'Main (Sub)');
    });

    test('compareTo works correctly', () {
      final line1 = LineInfo.fromTextAndStartTime('a', 1000);
      final line2 = LineInfo.fromTextAndStartTime('b', 2000);
      final line3 = LineInfo.fromTextAndStartTime('c', 1000);
      expect(line1.compareTo(line2), -1);
      expect(line2.compareTo(line1), 1);
      expect(line1.compareTo(line3), 0);
    });
  });

  group('SyllableLineInfo', () {
    final syllables = [
      SyllableInfo.create('Hel', 1000, 1200),
      SyllableInfo.create('lo', 1200, 1500),
    ];
    final line = SyllableLineInfo.fromSyllables(syllables);

    test('derived properties are correct', () {
      expect(line.text, 'Hello');
      expect(line.startTime, 1000);
      expect(line.endTime, 1500);
      expect(line.duration, 500);
      expect(line.isSyllable, isTrue);
    });

    test('refreshProperties works', () {
      line.syllables.add(SyllableInfo.create('!', 1500, 1600));
      line.refreshProperties();
      expect(line.text, 'Hello!');
      expect(line.endTime, 1600);
    });
  });

  group('FullLineInfo', () {
    test('constructor and properties work', () {
      final baseLine = LineInfo.fromTextAndTimes('Hello', 1000, 2000);
      final fullLine = FullLineInfo.fromLineInfo(baseLine);

      fullLine.chineseTranslation = '你好';
      fullLine.pronunciation = 'ni hao';

      expect(fullLine.text, 'Hello');
      expect(fullLine.startTime, 1000);
      expect(fullLine.chineseTranslation, '你好');
      expect(fullLine.translations['zh'], '你好');
      expect(fullLine.pronunciation, 'ni hao');

      fullLine.chineseTranslation = null;
      expect(fullLine.translations.containsKey('zh'), isFalse);
    });

    test('toJson includes extra data', () {
      final fullLine = FullLineInfo()
        ..text = 'Hi'
        ..chineseTranslation = '嗨'
        ..pronunciation = 'hai';

      final json = fullLine.toJson();

      expect(json['text'], 'Hi');
      expect(json['translations']['zh'], '嗨');
      expect(json['pronunciation'], 'hai');
    });
  });
}
