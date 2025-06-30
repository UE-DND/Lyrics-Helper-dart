import 'i_syllable_info.dart';

/// 音节信息类
class SyllableInfo implements ISyllableInfo {
  /// 创建一个空的音节信息实例
  SyllableInfo();

  /// 使用文本、开始时间和结束时间创建音节信息实例
  SyllableInfo.create(this.text, this.startTime, this.endTime);

  @override
  String text = '';

  @override
  int startTime = 0;

  @override
  int endTime = 0;

  @override
  int get duration => endTime - startTime;

  Map<String, dynamic> toJson() => {
        'text': text,
        'startTime': startTime,
        'endTime': endTime,
      };

  @override
  String toString() => toJson().toString();
}

/// 完整音节信息类（包含子音节）
class FullSyllableInfo implements ISyllableInfo {
  /// 创建一个空的完整音节信息实例
  FullSyllableInfo();

  /// 使用音节信息列表创建完整音节信息实例
  FullSyllableInfo.fromSyllableInfos(Iterable<SyllableInfo> syllableInfos) {
    subItems = syllableInfos.toList();
  }

  String? _text;
  @override
  String get text => _text ??= SyllableHelper.getTextFromSyllableList(subItems);

  int? _startTime;
  @override
  int get startTime => _startTime ??= subItems.first.startTime;

  int? _endTime;
  @override
  int get endTime => _endTime ??= subItems.last.endTime;

  @override
  int get duration => endTime - startTime;

  /// 子音节列表
  List<SyllableInfo> subItems = [];

  /// 刷新预加载的属性（当subItems更新后调用）
  void refreshProperties() {
    _text = null;
    _startTime = null;
    _endTime = null;
  }

  Map<String, dynamic> toJson() => {
        'text': text,
        'startTime': startTime,
        'endTime': endTime,
      };

  @override
  String toString() => toJson().toString();
}

/// 音节辅助类
class SyllableHelper {
  /// 从音节列表获取完整文本
  static String getTextFromSyllableList(List<ISyllableInfo> syllableList) {
    return syllableList.map((s) => s.text).join('');
  }

  /// 从SyllableInfo列表获取完整文本
  static String getTextFromSyllableInfoList(List<SyllableInfo> syllableList) {
    return syllableList.map((s) => s.text).join('');
  }

  /// 从FullSyllableInfo列表获取完整文本
  static String getTextFromFullSyllableInfoList(
      List<FullSyllableInfo> syllableList) {
    return syllableList.map((s) => s.text).join('');
  }
}
