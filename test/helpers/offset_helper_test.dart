import 'package:lyricify_lyrics_helper/helpers/offset_helper.dart';
import 'package:lyricify_lyrics_helper/models/line_info.dart';
import 'package:lyricify_lyrics_helper/models/syllable_info.dart';
import 'package:lyricify_lyrics_helper/models/i_line_info.dart';
import 'package:test/test.dart';

void main() {
  group('OffsetHelper', () {
    test('addOffset for a single LineInfo', () {
      final line = LineInfo.fromTextAndTimes('test', 2000, 3000);
      OffsetHelper.addOffset(line, 500);
      expect(line.startTime, 1500);
      expect(line.endTime, 2500);
    });

    test('addOffset for a single SyllableLineInfo', () {
      final syllables = [
        SyllableInfo.create('a', 1000, 1200),
        SyllableInfo.create('b', 1200, 1500),
      ];
      final line = SyllableLineInfo.fromSyllables(syllables);

      OffsetHelper.addOffset(line, 200);

      expect(line.syllables[0].startTime, 800);
      expect(line.syllables[0].endTime, 1000);
      expect(line.syllables[1].startTime, 1000);
      expect(line.syllables[1].endTime, 1300);

      // Check if refreshProperties was implicitly called
      expect(line.startTime, 800);
      expect(line.endTime, 1300);
    });

    test('addOffset for a list of ILineInfo', () {
      final line1 = LineInfo.fromTextAndTimes('line1', 2000, 3000);
      final line2 = SyllableLineInfo.fromSyllables(
          [SyllableInfo.create('syl1', 4000, 4500)]);

      final lines = <ILineInfo>[line1, line2];
      OffsetHelper.addOffset(lines, 1000);

      expect(line1.startTime, 1000);
      expect(line1.endTime, 2000);

      expect(line2.startTime, 3000);
      expect(line2.syllables[0].startTime, 3000);
    });

    test('addOffset for SyllableLineInfo with FullSyllableInfo', () {
      final fullSyllable = FullSyllableInfo.fromSyllableInfos([
        SyllableInfo.create('sub1', 5000, 5200),
        SyllableInfo.create('sub2', 5200, 5500),
      ]);
      final line = SyllableLineInfo.fromSyllables([fullSyllable]);

      OffsetHelper.addOffset(line, 1500);

      expect(fullSyllable.subItems[0].startTime, 3500);
      expect(fullSyllable.subItems[0].endTime, 3700);
      expect(fullSyllable.subItems[1].startTime, 3700);
      expect(fullSyllable.subItems[1].endTime, 4000);

      expect(line.startTime, 3500);
    });
  });
}
