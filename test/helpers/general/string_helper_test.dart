import 'package:lyricify_lyrics_helper/helpers/general/string_helper.dart';
import 'package:test/test.dart';

void main() {
  group('StringHelper', () {
    test('removeFrontBackBrackets', () {
      expect(StringHelper.removeFrontBackBrackets('(text)'), 'text');
      expect(StringHelper.removeFrontBackBrackets('text'), 'text');
      expect(StringHelper.removeFrontBackBrackets(''), '');
    });

    test('isSame', () {
      expect(StringHelper.isSame('a', 'a'), isTrue);
      expect(StringHelper.isSame('a', 'b'), isFalse);
      expect(StringHelper.isSame(null, ''), isTrue);
      expect(StringHelper.isSame('', null), isTrue);
      expect(StringHelper.isSame(null, null), isTrue);
    });

    test('isSameWhiteSpace', () {
      expect(StringHelper.isSameWhiteSpace(' a ', 'a'), isFalse);
      expect(StringHelper.isSameWhiteSpace(null, ' '), isTrue);
    });

    test('isSameTrim', () {
      expect(StringHelper.isSameTrim(' a ', 'a'), isTrue);
      expect(StringHelper.isSameTrim(' a ', ' b '), isFalse);
      expect(StringHelper.isSameTrim(null, ' '), isTrue);
    });

    test('formatTimeMsToTimestampString', () {
      expect(StringHelper.formatTimeMsToTimestampString(61500), '01:01.500');
      expect(
          StringHelper.formatTimeMsToTimestampString(61500, millisecond: false),
          '1:01');
      expect(StringHelper.formatTimeMsToTimestampString(-1), '0:00');
    });

    test('getMillisecondsFromString', () {
      expect(StringHelper.getMillisecondsFromString('01:01.500'), 61500);
      expect(StringHelper.getMillisecondsFromString('1:01'), 61000);
      expect(StringHelper.getMillisecondsFromString('12.345'), 12345);
      expect(StringHelper.getMillisecondsFromString('invalid'), isNull);
    });

    test('removeDuoSpaces', () {
      expect(StringHelper.removeDuoSpaces('a  b   c'), 'a b c');
    });

    test('removeTripleSpaces', () {
      expect(StringHelper.removeTripleSpaces('a  b   c'), 'a  b  c');
    });

    test('fixCommaAfterSpace', () {
      expect(StringHelper.fixCommaAfterSpace('a,b, c'), 'a, b, c');
    });

    test('removeDuoBackslashN', () {
      expect(StringHelper.removeDuoBackslashN('a\n\nb'), 'a\nb');
    });

    test('removeBackslashR', () {
      expect(StringHelper.removeBackslashR('a\rb'), 'ab');
    });

    test('toUpperFirst', () {
      expect(StringHelper.toUpperFirst('word'), 'Word');
      expect(StringHelper.toUpperFirst(''), '');
    });

    test('between', () {
      expect(StringHelper.between('<a>text</a>', '<a>', '</a>'), 'text');
      expect(StringHelper.between('<a>text', '<a>', '</a>'), '');
    });

    test('reverse', () {
      expect(StringHelper.reverse('hello'), 'olleh');
    });

    test('remove', () {
      expect(StringHelper.remove('hello world', ' world'), 'hello');
    });

    test('isNumber', () {
      expect(StringHelper.isNumber('123'), isTrue);
      expect(StringHelper.isNumber('12.3'), isTrue);
      expect(StringHelper.isNumber('abc'), isFalse);
    });

    test('computeTextSame', () {
      expect(StringHelper.computeTextSame('abc', 'abc'), 100.0);
      expect(StringHelper.computeTextSame('abc', 'axbyc', isCase: true),
          closeTo(60.0, 0.1));
      expect(StringHelper.computeTextSame('abc', 'ABC'), 100.0);
    });
  });

  group('StringExtensions', () {
    test('removeFrontBackBrackets extension', () {
      expect('(text)'.removeFrontBackBrackets(), 'text');
    });

    test('isSame extension', () {
      expect('a'.isSame('a'), isTrue);
    });
  });
}
