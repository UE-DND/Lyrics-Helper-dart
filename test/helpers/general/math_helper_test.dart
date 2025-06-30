import 'package:test/test.dart';
import 'package:lyricify_lyrics_helper/helpers/general/math_helper.dart';

void main() {
  group('最值函数', () {
    test('min', () {
      expect(MathHelper.min(1, 3), 1);
      expect(MathHelper.min(null, 2), 2);
      expect(MathHelper.min(5, null), 5);
    });

    test('max', () {
      expect(MathHelper.max(1, 3), 3);
      expect(MathHelper.max(null, 2), 2);
      expect(MathHelper.max(5, null), 5);
    });
  });

  group('阈值函数', () {
    test('greaterThanZero', () {
      expect(MathHelper.greaterThanZero(-5), 0);
      expect(MathHelper.greaterThanZero(7), 7);
    });

    test('greaterThan', () {
      expect(MathHelper.greaterThan(5, 10), 10);
      expect(MathHelper.greaterThan(15, 10), 15);
    });

    test('greaterThanZeroDouble / greaterThanDouble', () {
      expect(MathHelper.greaterThanZeroDouble(-5.5), 0);
      expect(MathHelper.greaterThanZeroDouble(3.3), 3.3);
      expect(MathHelper.greaterThanDouble(1.1, 2.2), 2.2);
    });
  });

  group('swap', () {
    test('交换列表元素', () {
      final list = ['a', 'b', 'c'];
      MathHelper.swap(list, 0, 2);
      expect(list, ['c', 'b', 'a']);
    });
  });
}
