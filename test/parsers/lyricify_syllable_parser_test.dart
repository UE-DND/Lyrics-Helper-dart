import 'package:lyricify_lyrics_helper/models/line_info.dart';
import 'package:lyricify_lyrics_helper/parsers/lyricify_syllable_parser.dart';
import 'package:test/test.dart';

void main() {
  group('LyricifySyllableParser', () {
    test('parses basic syllable format', () {
      final lyrics = 'word(100,200) another(300,100)';
      final result = LyricifySyllableParser.parse(lyrics);
      final line = result.lines![0] as SyllableLineInfo;

      expect(result.lines!.length, 1);
      expect(line.syllables.length, 2);
      expect(line.text, 'wordanother');
      expect(line.startTime, 100);
      expect(line.endTime, 400);
      expect(line.syllables[0].text, 'word');
      expect(line.syllables[0].startTime, 100);
      expect(line.syllables[0].endTime, 300); // start + duration
      expect(line.syllables[1].text, 'another');
      expect(line.syllables[1].startTime, 300);
      expect(line.syllables[1].endTime, 400);
    });

    test('parses line properties', () {
      final lyrics = '[6]background(1,2)';
      final result = LyricifySyllableParser.parse(lyrics);
      expect(result.lines!.length, 1);
      expect(result.lines![0].text, 'background');
    });

    test('handles background vocals', () {
      final lyrics = 'main(100,100)\n[6]background(200,100)';
      final result = LyricifySyllableParser.parse(lyrics);
      expect(result.lines!.length, 1);

      final mainLine = result.lines![0] as SyllableLineInfo;
      expect(mainLine.text, 'main');
      expect(mainLine.subLine, isNotNull);
      expect(mainLine.subLine!.text, 'background');
      expect(mainLine.subLine!.startTime, 200);
    });

    test('handles bracketed lyrics as subline', () {
      final lyrics = 'main(100,100)\n(bracketed)(200,100)\nmain2(300,100)';
      final result = LyricifySyllableParser.parse(lyrics);
      expect(result.lines!.length, 2);

      final mainLine = result.lines![0] as SyllableLineInfo;
      expect(mainLine.text, 'main');
      expect(mainLine.subLine, isNotNull);
      expect(mainLine.subLine!.text, '(bracketed)');
      expect(result.lines![1].text, 'main2');
    });

    test('applies offset correctly', () {
      final lyrics = '[offset:50]\nword(100,200)';
      final result = LyricifySyllableParser.parse(lyrics);
      final line = result.lines![0];
      expect(line.startTime, 50); // 100 - 50
    });
  });
}
