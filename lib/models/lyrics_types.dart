/// 歌词类型枚举
enum LyricsTypes {
  unknown(0),
  lyricifySyllable(1),
  lyricifyLines(2),
  lrc(3),
  yrc(4);

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

  /// 主要YRC
  yrc(4);

  final int value;
  const LyricsRawTypes(this.value);
}
