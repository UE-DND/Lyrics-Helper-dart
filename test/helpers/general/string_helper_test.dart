import 'package:test/test.dart';
import 'package:lyricify_lyrics_helper/helpers/general/string_helper.dart';

void main() {
  group('括号移除', () {
    test('移除包裹括号', () {
      expect('(hello)'.removeFrontBackBrackets(), equals('hello'));
    });

    test('无括号返回原值', () {
      expect('hello'.removeFrontBackBrackets(), equals('hello'));
    });
  });

  group('字符串比较', () {
    test('isSame 判断', () {
      expect(StringHelper.isSame(null, ''), isTrue);
      expect(StringHelper.isSame('abc', 'abc'), isTrue);
      expect(StringHelper.isSame('abc', 'def'), isFalse);
    });

    test('isSameWhiteSpace 判断', () {
      expect(StringHelper.isSameWhiteSpace(null, ' '), isTrue);
      expect(StringHelper.isSameWhiteSpace(' a ', 'a'), isFalse);
    });

    test('isSameTrim 判断', () {
      expect(StringHelper.isSameTrim(' abc ', 'abc'), isTrue);
      expect(StringHelper.isSameTrim('abc', 'def'), isFalse);
    });
  });

  group('时间格式与解析', () {
    test('formatTimeMsToTimestampString 毫秒', () {
      expect(StringHelper.formatTimeMsToTimestampString(61000), '01:01.000');
    });

    test('formatTimeMsToTimestampString 秒', () {
      expect(
          StringHelper.formatTimeMsToTimestampString(61000, millisecond: false),
          '1:01');
    });

    test('getMillisecondsFromString 解析混合格式', () {
      expect(StringHelper.getMillisecondsFromString('1:01.000'), 61000);
      expect(StringHelper.getMillisecondsFromString('1.500'), 1500);
      expect(StringHelper.getMillisecondsFromString('100'), 100);
      expect(StringHelper.getMillisecondsFromString('invalid'), isNull);
    });
  });

  group('空格与符号处理', () {
    test('removeDuoSpaces', () {
      expect(StringHelper.removeDuoSpaces('a  b   c'), 'a b c');
    });

    test('removeTripleSpaces', () {
      expect(StringHelper.removeTripleSpaces('a   b    c'), 'a  b  c');
    });

    test('fixCommaAfterSpace', () {
      expect(StringHelper.fixCommaAfterSpace('a,b, c'), 'a, b, c');
    });
  });

  group('换行与回车处理', () {
    test('removeDuoBackslashN', () {
      expect(StringHelper.removeDuoBackslashN('a\n\n\nb'), 'a\nb');
    });

    test('removeBackslashR', () {
      expect(StringHelper.removeBackslashR('a\r\nb'), 'a\nb');
    });
  });

  group('其它工具', () {
    test('between', () {
      expect(
          StringHelper.between('abc[start]middle[end]xyz', '[start]', '[end]'),
          'middle');
    });

    test('reverse', () {
      expect(StringHelper.reverse('abc'), 'cba');
    });

    test('isNumber', () {
      expect(StringHelper.isNumber('123'), isTrue);
      expect(StringHelper.isNumber('12.3'), isTrue);
      expect(StringHelper.isNumber('abc'), isFalse);
    });

    test('computeTextSame 高相似度', () {
      final sim = StringHelper.computeTextSame('hello', 'HELLO');
      expect(sim, greaterThanOrEqualTo(99));
    });

    test('computeTextSame 低相似度', () {
      final sim = StringHelper.computeTextSame('hello', 'world');
      expect(sim, lessThan(30));
    });
  });
}
