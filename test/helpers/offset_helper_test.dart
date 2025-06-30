import 'package:test/test.dart';
import 'package:lyricify_lyrics_helper/helpers/offset_helper.dart';
import 'package:lyricify_lyrics_helper/models/line_info.dart';
import 'package:lyricify_lyrics_helper/models/syllable_info.dart';

void main() {
  group('OffsetHelper.addOffset', () {
    test('单个 LineInfo', () {
      final line = LineInfo.fromTextAndTimes('Hello', 1000, 2000);
      OffsetHelper.addOffset(line, 500);
      expect(line.startTime, 500);
      expect(line.endTime, 1500);
    });

    test('SyllableLineInfo', () {
      final s1 = SyllableInfo.create('a', 1000, 1100);
      final s2 = SyllableInfo.create('b', 1100, 1200);
      final syllableLine = SyllableLineInfo.fromSyllables([s1, s2]);
      OffsetHelper.addOffset(syllableLine, 200);
      expect(s1.startTime, 800);
      expect(s2.endTime, 1000);
      // startTime getter should refresh after offset
      expect(syllableLine.startTime, 800);
      expect(syllableLine.endTime, 1000);
    });

    test('列表批量处理', () {
      final line1 = LineInfo.fromTextAndStartTime('Line1', 3000);
      final line2 = LineInfo.fromTextAndStartTime('Line2', 4000);
      final list = [line1, line2];
      OffsetHelper.addOffset(list, 1000);
      expect(line1.startTime, 2000);
      expect(line2.startTime, 3000);
    });
  });
}
