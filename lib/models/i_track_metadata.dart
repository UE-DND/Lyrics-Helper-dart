/// 音轨元数据接口
abstract class ITrackMetadata {
  /// 音轨标题
  String? get title;
  set title(String? value);

  /// 音轨艺术家
  String? get artist;
  set artist(String? value);

  /// 音轨所属专辑名称
  String? get album;
  set album(String? value);

  /// 专辑艺术家
  String? get albumArtist;
  set albumArtist(String? value);

  /// 音轨时长（毫秒）
  int? get durationMs;
  set durationMs(int? value);

  /// 音轨ISRC
  String? get isrc;
  set isrc(String? value);

  /// 歌词语言列表
  List<String>? get language;
  set language(List<String>? value);
} 