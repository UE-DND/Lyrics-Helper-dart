/// 数学辅助类
class MathHelper {
  /// 返回两个可空整数中的最小值
  static int? min(int? a, int? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a < b ? a : b;
  }

  /// 返回两个可空整数中的最大值
  static int? max(int? a, int? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a > b ? a : b;
  }
  
  /// 如果 x 大于零，则返回 x，否则返回零
  static int greaterThanZero(int x) {
    return x < 0 ? 0 : x;
  }

  /// 如果 x 大于零，则返回 x，否则返回零
  static double greaterThanZeroDouble(double x) {
    return x < 0 ? 0 : x;
  }

  /// 如果 x 大于min，则返回 x，否则返回min
  static int greaterThan(int x, int min) {
    return x < min ? min : x;
  }

  /// 如果 x 大于min，则返回 x，否则返回min
  static double greaterThanDouble(double x, double min) {
    return x < min ? min : x;
  }

  /// 交换两个变量的值
  static void swap<T>(List<T> list, int i, int j) {
    final T temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }
}

/// 扩展整数方法
extension IntExtensions on int {
  /// 判断是否在 a 和 b 之间
  bool isBetween(int a, int b, {bool containEdge = true}) {
    if (a > b) {
      final temp = a;
      a = b;
      b = temp;
    }
    
    if (!containEdge) {
      return this < b && this > a;
    }
    return this <= b && this >= a;
  }
}

/// 扩展双精度浮点数方法
extension DoubleExtensions on double {
  /// 判断是否在 a 和 b 之间
  bool isBetween(double a, double b, {bool containEdge = true}) {
    if (a > b) {
      final temp = a;
      a = b;
      b = temp;
    }
    
    if (!containEdge) {
      return this < b && this > a;
    }
    return this <= b && this >= a;
  }
} 