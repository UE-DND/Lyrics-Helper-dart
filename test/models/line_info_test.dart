import 'package:test/test.dart';
import 'package:lyricify_lyrics_helper/models/line_info.dart';

void main() {
  group('LineInfo.fullText', () {
    test('subLine 时间在前', () {
      final mainLine = LineInfo.fromTextAndStartTime('Main', 2000);
      final subLine = LineInfo.fromTextAndStartTime('Sub', 1000);
      mainLine.subLine = subLine;
      expect(mainLine.fullText, '(Sub) Main');
    });

    test('subLine 时间在后', () {
      final mainLine = LineInfo.fromTextAndStartTime('Main', 1000);
      final subLine = LineInfo.fromTextAndStartTime('Sub', 2000);
      mainLine.subLine = subLine;
      expect(mainLine.fullText, 'Main (Sub)');
    });
  });

  group('LineInfo.compareTo', () {
    test('时间比较', () {
      final l1 = LineInfo.fromTextAndStartTime('L1', 1000);
      final l2 = LineInfo.fromTextAndStartTime('L2', 2000);
      expect(l1.compareTo(l2) < 0, isTrue);
      expect(l2.compareTo(l1) > 0, isTrue);
      // 同时间返回 0
      final l3 = LineInfo.fromTextAndStartTime('L3', 1000);
      expect(l1.compareTo(l3), 0);
    });
  });
}
