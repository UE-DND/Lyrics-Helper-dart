import 'file_info.dart';
import 'i_line_info.dart';
import 'i_track_metadata.dart';
import 'line_info.dart';

/// 歌词数据类
class LyricsData {
  /// 歌词文件信息
  FileInfo? file;

  /// 歌词行信息列表
  List<ILineInfo>? lines;

  /// 歌词作者列表
  List<String>? writers;

  /// 音轨元数据
  ITrackMetadata? trackMetadata;

  /// 序列化为 Map，便于 jsonEncode
  Map<String, dynamic> toJson() => {
        'file': file?.toJson(),
        'lines': lines?.map((e) {
          if (e is LineInfo) return e.toJson();
          if (e is SyllableLineInfo) return e.toJson();
          return e.toString();
        }).toList(),
        'writers': writers,
        'trackMetadata':
            trackMetadata == null ? null : (trackMetadata as dynamic).toJson(),
      };

  @override
  String toString() => toJson().toString();
}
