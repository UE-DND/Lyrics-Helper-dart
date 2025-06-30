/// 歌词类型枚举
enum LyricsTypes {
  unknown(0),
  lyricifySyllable(1),
  lyricifyLines(2),
  lrc(3),
  qrc(4),
  krc(5),
  yrc(6),
  ttml(7),
  spotify(8),
  musixmatch(9);

  final int value;
  const LyricsTypes(this.value);
}

/// 歌词原始字符串类型枚举
enum LyricsRawTypes {
  /// 未知歌词
  unknown(0),

  /// Lyricify音节
  lyricifySyllable(1),

  /// Lyricify行
  lyricifyLines(2),

  /// 常规LRC
  lrc(3),

  /// 主要QRC
  qrc(4),

  /// 原始QRC (XML格式)
  qrcFull(10),

  /// 原始KRC
  krc(5),

  /// 主要YRC
  yrc(6),

  /// 网易云音乐API原始JSON数据(包含翻译等)
  yrcFull(11),

  /// TTML
  ttml(7),

  /// Apple Music API原始JSON数据(包含ID和更多信息)
  appleJson(12),

  /// Spotify桌面客户端API彩色歌词原始JSON数据
  spotify(8),

  /// Musixmatch桌面客户端API原始JSON数据
  musixmatch(9);

  final int value;
  const LyricsRawTypes(this.value);
} 