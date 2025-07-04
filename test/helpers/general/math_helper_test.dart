import 'package:lyricify_lyrics_helper/helpers/general/math_helper.dart';
import 'package:test/test.dart';

void main() {
  group('MathHelper', () {
    test('min returns the minimum of two integers', () {
      expect(MathHelper.min(1, 2), 1);
      expect(MathHelper.min(2, 1), 1);
      expect(MathHelper.min(null, 1), 1);
      expect(MathHelper.min(1, null), 1);
      expect(MathHelper.min(null, null), isNull);
    });

    test('max returns the maximum of two integers', () {
      expect(MathHelper.max(1, 2), 2);
      expect(MathHelper.max(2, 1), 2);
      expect(MathHelper.max(null, 1), 1);
      expect(MathHelper.max(1, null), 1);
      expect(MathHelper.max(null, null), isNull);
    });

    test('greaterThanZero returns correct values', () {
      expect(MathHelper.greaterThanZero(5), 5);
      expect(MathHelper.greaterThanZero(0), 0);
      expect(MathHelper.greaterThanZero(-5), 0);
    });

    test('greaterThanZeroDouble returns correct values', () {
      expect(MathHelper.greaterThanZeroDouble(5.5), 5.5);
      expect(MathHelper.greaterThanZeroDouble(0.0), 0.0);
      expect(MathHelper.greaterThanZeroDouble(-5.5), 0.0);
    });

    test('greaterThan returns correct values', () {
      expect(MathHelper.greaterThan(10, 5), 10);
      expect(MathHelper.greaterThan(5, 5), 5);
      expect(MathHelper.greaterThan(0, 5), 5);
    });

    test('greaterThanDouble returns correct values', () {
      expect(MathHelper.greaterThanDouble(10.5, 5.5), 10.5);
      expect(MathHelper.greaterThanDouble(5.5, 5.5), 5.5);
      expect(MathHelper.greaterThanDouble(0.5, 5.5), 5.5);
    });

    test('swap exchanges elements in a list', () {
      final list = [1, 2, 3];
      MathHelper.swap(list, 0, 2);
      expect(list, [3, 2, 1]);
    });
  });

  group('IntExtensions', () {
    test('isBetween works correctly', () {
      expect(5.isBetween(0, 10), isTrue);
      expect(0.isBetween(0, 10), isTrue);
      expect(10.isBetween(0, 10), isTrue);
      expect(11.isBetween(0, 10), isFalse);
      expect(5.isBetween(10, 0), isTrue);
    });

    test('isBetween without edge works correctly', () {
      expect(5.isBetween(0, 10, containEdge: false), isTrue);
      expect(0.isBetween(0, 10, containEdge: false), isFalse);
      expect(10.isBetween(0, 10, containEdge: false), isFalse);
    });
  });

  group('DoubleExtensions', () {
    test('isBetween works correctly', () {
      expect(5.5.isBetween(0.0, 10.0), isTrue);
      expect(0.0.isBetween(0.0, 10.0), isTrue);
      expect(10.0.isBetween(0.0, 10.0), isTrue);
      expect(11.1.isBetween(0.0, 10.0), isFalse);
      expect(5.5.isBetween(10.0, 0.0), isTrue);
    });

    test('isBetween without edge works correctly', () {
      expect(5.5.isBetween(0.0, 10.0, containEdge: false), isTrue);
      expect(0.0.isBetween(0.0, 10.0, containEdge: false), isFalse);
      expect(10.0.isBetween(0.0, 10.0, containEdge: false), isFalse);
    });
  });
}
