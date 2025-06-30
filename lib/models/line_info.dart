import 'i_line_info.dart';
import 'i_syllable_info.dart';
import 'syllable_info.dart';
import '../helpers/general/math_helper.dart';
import '../helpers/general/string_helper.dart';

/// 歌词行信息类
class LineInfo implements ILineInfo {
  /// 创建一个空的歌词行信息实例
  LineInfo();

  /// 使用文本创建歌词行信息实例
  LineInfo.fromText(this.text);

  /// 使用文本和开始时间创建歌词行信息实例
  LineInfo.fromTextAndStartTime(this.text, this.startTime);

  /// 使用文本、开始时间和结束时间创建歌词行信息实例
  LineInfo.fromTextAndTimes(this.text, this.startTime, this.endTime);

  @override
  String text = '';

  @override
  int? startTime;

  @override
  int? endTime;

  @override
  int? get duration => endTime != null && startTime != null ? endTime! - startTime! : null;

  @override
  int? get startTimeWithSubLine => MathHelper.min(startTime, subLine?.startTime);

  @override
  int? get endTimeWithSubLine => MathHelper.max(endTime, subLine?.endTime);

  @override
  int? get durationWithSubLine => 
    endTimeWithSubLine != null && startTimeWithSubLine != null 
      ? endTimeWithSubLine! - startTimeWithSubLine!
      : null;

  @override
  LyricsAlignment lyricsAlignment = LyricsAlignment.unspecified;

  @override
  ILineInfo? subLine;

  @override
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

  @override
  int compareTo(ILineInfo other) {
    if (startTime == null || other.startTime == null) return 0;
    if (startTime == other.startTime) return 0;
    if (startTime! < other.startTime!) return -1;
    return 1;
  }

  /// 将当前行信息转成可 JSON 化 Map
  Map<String, dynamic> toJson() => {
        'text': text,
        'startTime': startTime,
        'endTime': endTime,
        'lyricsAlignment': lyricsAlignment.name,
        'subLine': subLine is LineInfo
            ? (subLine as LineInfo).toJson()
            : subLine is SyllableLineInfo
                ? (subLine as SyllableLineInfo).toJson()
                : subLine?.toString(),
      };

  @override
  String toString() => toJson().toString();
}

/// 音节行信息类
class SyllableLineInfo implements ILineInfo {
  /// 创建一个空的音节行信息实例
  SyllableLineInfo();

  /// 从音节列表创建音节行信息实例
  SyllableLineInfo.fromSyllables(Iterable<ISyllableInfo> syllables) {
    this.syllables = syllables.toList();
  }

  String? _text;
  @override
  String get text => _text ??= SyllableHelper.getTextFromSyllableList(syllables);

  int? _startTime;
  @override
  int? get startTime => _startTime ??= syllables.isNotEmpty ? syllables.first.startTime : null;

  int? _endTime;
  @override
  int? get endTime => _endTime ??= syllables.isNotEmpty ? syllables.last.endTime : null;

  @override
  int? get duration => endTime != null && startTime != null ? endTime! - startTime! : null;

  @override
  int? get startTimeWithSubLine => MathHelper.min(startTime, subLine?.startTime);

  @override
  int? get endTimeWithSubLine => MathHelper.max(endTime, subLine?.endTime);

  @override
  int? get durationWithSubLine => 
    endTimeWithSubLine != null && startTimeWithSubLine != null 
      ? endTimeWithSubLine! - startTimeWithSubLine!
      : null;

  @override
  LyricsAlignment lyricsAlignment = LyricsAlignment.unspecified;

  @override
  ILineInfo? subLine;

  @override
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

  /// 音节列表
  List<ISyllableInfo> syllables = [];

  /// 是否包含音节信息
  bool get isSyllable => syllables.isNotEmpty;

  @override
  int compareTo(ILineInfo other) {
    if (startTime == null || other.startTime == null) return 0;
    if (startTime == other.startTime) return 0;
    if (startTime! < other.startTime!) return -1;
    return 1;
  }

  /// 刷新预加载的属性（当syllables更新后调用）
  void refreshProperties() {
    _text = null;
    _startTime = null;
    _endTime = null;
  }

  /// 将当前行信息转成可 JSON 化 Map
  Map<String, dynamic> toJson() => {
        'text': text,
        'startTime': startTime,
        'endTime': endTime,
        'lyricsAlignment': lyricsAlignment.name,
        'subLine': subLine is LineInfo
            ? (subLine as LineInfo).toJson()
            : subLine is SyllableLineInfo
                ? (subLine as SyllableLineInfo).toJson()
                : subLine?.toString(),
      };

  @override
  String toString() => toJson().toString();
}

/// 完整歌词行信息类
class FullLineInfo extends LineInfo implements IFullLineInfo {
  /// 创建一个空的完整歌词行信息实例
  FullLineInfo();

  /// 从普通歌词行创建完整歌词行
  FullLineInfo.fromLineInfo(LineInfo lineInfo) {
    text = lineInfo.text;
    startTime = lineInfo.startTime;
    endTime = lineInfo.endTime;
    lyricsAlignment = lineInfo.lyricsAlignment;
    subLine = lineInfo.subLine;
  }

  @override
  Map<String, String> translations = {};

  @override
  String? get chineseTranslation => translations.containsKey('zh') ? translations['zh'] : null;
  
  @override
  set chineseTranslation(String? value) {
    if (value == null || value.isEmpty) {
      translations.remove('zh');
    } else {
      translations['zh'] = value;
    }
  }

  @override
  String? pronunciation;
}

/// 完整音节行信息类
class FullSyllableLineInfo extends SyllableLineInfo implements IFullLineInfo {
  /// 创建一个空的完整音节行信息实例
  FullSyllableLineInfo();

  /// 从普通音节行创建完整音节行
  FullSyllableLineInfo.fromSyllableLineInfo(SyllableLineInfo lineInfo) {
    lyricsAlignment = lineInfo.lyricsAlignment;
    subLine = lineInfo.subLine;
    syllables = lineInfo.syllables;
  }

  /// 从普通音节行创建完整音节行，可选添加中文翻译和发音指南
  FullSyllableLineInfo.fromSyllableLineInfoWithExtra(SyllableLineInfo lineInfo, {
    String? chineseTranslation,
    String? pronunciation,
  }) {
    lyricsAlignment = lineInfo.lyricsAlignment;
    subLine = lineInfo.subLine;
    syllables = lineInfo.syllables;
    
    if (chineseTranslation != null && chineseTranslation.isNotEmpty) {
      translations['zh'] = chineseTranslation;
    }

    if (pronunciation != null && pronunciation.isNotEmpty) {
      this.pronunciation = pronunciation;
    }
  }

  @override
  Map<String, String> translations = {};

  @override
  String? get chineseTranslation => translations.containsKey('zh') ? translations['zh'] : null;
  
  @override
  set chineseTranslation(String? value) {
    if (value == null || value.isEmpty) {
      translations.remove('zh');
    } else {
      translations['zh'] = value;
    }
  }

  @override
  String? pronunciation;
} 