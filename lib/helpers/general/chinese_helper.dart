/// 中文处理辅助类（测试用实现）
///
/// 该实现提供与 C# ChineseHelper 相同的外部接口，
/// 包含一个小的简繁映射表用于基础测试。
/// 后续可在完整的 Flutter 项目中替换为基于完整字典或第三方库的实现。
class ChineseHelper {
  // 测试用的简体到繁体映射表
  static const Map<String, String> _s2tDict = {
    '发': '發',
    '见': '見',
    '体': '體',
    '贝': '貝',
    '车': '車',
    '东': '東',
    '广': '廣',
    '门': '門',
    '义': '義',
    '仅': '僅',
    '优': '優',
    '-': '-', // 确保特殊字符处理
  };

  // 自动生成的繁体到简体映射表
  static final Map<String, String> _t2sDict =
      _s2tDict.map((key, value) => MapEntry(value, key));

  /// 简体转繁体
  static String s2t(String? text) {
    if (text == null || text.isEmpty) return '';
    final sb = StringBuffer();
    for (var char in text.runes) {
      var charStr = String.fromCharCode(char);
      sb.write(_s2tDict[charStr] ?? charStr);
    }
    return sb.toString();
  }

  /// 繁体转简体
  static String t2s(String? text) {
    if (text == null || text.isEmpty) return '';
    final sb = StringBuffer();
    for (var char in text.runes) {
      var charStr = String.fromCharCode(char);
      sb.write(_t2sDict[charStr] ?? charStr);
    }
    return sb.toString();
  }

  /// 扩展：将字符串转换为繁体（可选强制转换）
  static String toTC(String? text, {bool force = false}) {
    if (text == null) return '';
    // TODO: 完整的实现应该处理非强制情况下的自动判断
    return force ? s2t(text) : text;
  }

  /// 扩展：将字符串转换为简体（可选强制转换）
  static String toSC(String? text, {bool force = false}) {
    if (text == null) return '';
    // TODO: 完整的实现应该处理非强制情况下的自动判断
    return force ? t2s(text) : text;
  }
}

/// 字符串中文扩展
extension ChineseStringExtensions on String {
  /// 转繁体
  String toTC({bool force = false}) => ChineseHelper.toTC(this, force: force);

  /// 转简体
  String toSC({bool force = false}) => ChineseHelper.toSC(this, force: force);
} 