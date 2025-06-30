/// 音节信息接口
abstract class ISyllableInfo {
  /// 文本内容
  String get text;

  /// 开始时间（毫秒）
  int get startTime;

  /// 结束时间（毫秒）
  int get endTime;

  /// 持续时间（毫秒）
  int get duration => endTime - startTime;
} 