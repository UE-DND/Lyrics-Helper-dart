import 'package:lyricify_lyrics_helper/models/syllable_info.dart';
import 'package:lyricify_lyrics_helper/models/i_syllable_info.dart';
import 'package:test/test.dart';

void main() {
  group('SyllableInfo', () {
    test('constructors work correctly', () {
      final s1 = SyllableInfo();
      expect(s1.text, '');
      expect(s1.startTime, 0);

      final s2 = SyllableInfo.create('word', 100, 200);
      expect(s2.text, 'word');
      expect(s2.startTime, 100);
      expect(s2.endTime, 200);
    });

    test('duration is calculated correctly', () {
      final s = SyllableInfo.create('test', 500, 800);
      expect(s.duration, 300);
    });

    test('toJson returns correct map', () {
      final s = SyllableInfo.create('json', 1, 2);
      final json = s.toJson();
      expect(json['text'], 'json');
      expect(json['startTime'], 1);
      expect(json['endTime'], 2);
    });
  });

  group('FullSyllableInfo', () {
    final subItems = [
      SyllableInfo.create('Full', 1000, 1200),
      SyllableInfo.create('Syl', 1200, 1500),
    ];
    final fullSyllable = FullSyllableInfo.fromSyllableInfos(subItems);

    test('derived properties are correct', () {
      expect(fullSyllable.text, 'FullSyl');
      expect(fullSyllable.startTime, 1000);
      expect(fullSyllable.endTime, 1500);
      expect(fullSyllable.duration, 500);
    });

    test('refreshProperties works', () {
      fullSyllable.subItems.add(SyllableInfo.create('lable', 1500, 1800));
      fullSyllable.refreshProperties();
      expect(fullSyllable.text, 'FullSyllable');
      expect(fullSyllable.endTime, 1800);
    });
  });

  group('SyllableHelper', () {
    test('getTextFromSyllableList works', () {
      final syllables = <ISyllableInfo>[
        SyllableInfo.create('a', 1, 2),
        SyllableInfo.create('b', 2, 3),
      ];
      expect(SyllableHelper.getTextFromSyllableList(syllables), 'ab');
    });

    test('getTextFromSyllableInfoList works', () {
      final syllables = [
        SyllableInfo.create('c', 1, 2),
        SyllableInfo.create('d', 2, 3),
      ];
      expect(SyllableHelper.getTextFromSyllableInfoList(syllables), 'cd');
    });

    test('getTextFromFullSyllableInfoList works', () {
      final fullSyllables = [
        FullSyllableInfo.fromSyllableInfos([SyllableInfo.create('e', 1, 2)]),
        FullSyllableInfo.fromSyllableInfos([SyllableInfo.create('f', 2, 3)]),
      ];
      expect(
          SyllableHelper.getTextFromFullSyllableInfoList(fullSyllables), 'ef');
    });
  });
}
