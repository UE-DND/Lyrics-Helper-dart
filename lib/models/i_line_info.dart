import '../helpers/general/math_helper.dart';
import '../helpers/general/string_helper.dart';

/// 歌词行信息接口
abstract class ILineInfo implements Comparable<ILineInfo> {
  /// 文本内容
  String get text;

  /// 开始时间（毫秒）
  int? get startTime;

  /// 结束时间（毫秒）
  int? get endTime;

  /// 持续时间（毫秒）
  int? get duration =>
      endTime != null && startTime != null ? endTime! - startTime! : null;

  /// 包含副行时的开始时间（取主行和副行的较小值）
  int? get startTimeWithSubLine =>
      MathHelper.min(startTime, subLine?.startTime);

  /// 包含副行时的结束时间（取主行和副行的较大值）
  int? get endTimeWithSubLine => MathHelper.max(endTime, subLine?.endTime);

  /// 包含副行时的持续时间
  int? get durationWithSubLine =>
      endTimeWithSubLine != null && startTimeWithSubLine != null
          ? endTimeWithSubLine! - startTimeWithSubLine!
          : null;

  /// 歌词对齐方式
  LyricsAlignment get lyricsAlignment;

  /// 副行歌词（如翻译）
  ILineInfo? get subLine;

  /// 完整文本，如果没有副行则返回text，否则返回主行和带括号的副行文本
  String get fullText {
    if (subLine == null) {
      return text;
    } else {
      final buffer = StringBuffer();
      if (subLine!.startTime != null &&
          startTime != null &&
          subLine!.startTime! < startTime!) {
        buffer.write('(');
        buffer.write(subLine!.text.removeFrontBackBrackets());
        buffer.write(") ");
        buffer.write(text.trim());
      } else {
        buffer.write(text.trim());
        buffer.write(" (");
        buffer.write(subLine!.text.removeFrontBackBrackets());
        buffer.write(')');
      }
      return buffer.toString();
    }
  }
}

/// 扩展的歌词行信息接口，包含翻译和发音标注
abstract class IFullLineInfo implements ILineInfo {
  /// 翻译内容（按语言代码索引）
  Map<String, String> get translations;

  /// 中文翻译
  String? get chineseTranslation =>
      translations.containsKey('zh') ? translations['zh'] : null;
  set chineseTranslation(String? value) {
    if (value == null || value.isEmpty) {
      translations.remove('zh');
    } else {
      translations['zh'] = value;
    }
  }

  /// 发音指南
  String? get pronunciation;
  set pronunciation(String? value);
}

/// 歌词对齐方式枚举（原 C# 为 LineInfo 内嵌枚举）
enum LyricsAlignment {
  unspecified,
  left,
  right,
}
