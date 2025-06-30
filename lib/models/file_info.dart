import 'additional_file_info.dart';
import 'lyrics_types.dart';
import 'sync_types.dart';

/// 歌词文件信息类
class FileInfo {
  /// 歌词类型
  LyricsTypes type = LyricsTypes.unknown;

  /// 歌词同步类型
  SyncTypes syncTypes = SyncTypes.unknown;

  /// 附加信息
  IAdditionalFileInfo? additionalInfo;

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'syncTypes': syncTypes.name,
        'additionalInfo': additionalInfo?.toJson(),
      };

  @override
  String toString() => toJson().toString();
}
