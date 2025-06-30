/// 歌词同步类型枚举
enum SyncTypes {
  /// 未知同步类型
  unknown(0),

  /// 歌词行是音节同步的
  syllableSynced(1),

  /// 歌词是行同步的
  lineSynced(2),

  /// 歌词行是混合同步的(同时包含行和音节同步)
  mixedSynced(3),

  /// 歌词未同步
  unsynced(4);

  final int value;
  const SyncTypes(this.value);
}
