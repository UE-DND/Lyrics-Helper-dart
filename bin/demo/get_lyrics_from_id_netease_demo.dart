import 'package:lyricify_lyrics_helper/providers/web/netease/api.dart';

Future<void> main(List<String> args) async {
  // 第一个参数为歌曲 ID，默认为 1991012773
  final songId = args.isNotEmpty ? args.first : '1991012773';

  final api = Api();

  // 尝试使用新版接口获取歌词，若失败则回退旧版
  final res = await api.getLyricNew(songId) ?? await api.getLyric(songId);

  final lyric = res?.lrc?.lyric;
  final tLyric = res?.tlyric?.lyric;

  if (lyric == null && tLyric == null) {
    print('未获取到歌词（包含翻译）。歌曲 ID: $songId');
    return;
  }

  if (lyric != null) {
    print('【原文歌词】');
    print(lyric);
  }

  if (tLyric != null) {
    print('\n【翻译歌词】');
    print(tLyric);
  } else {
    print('\n（该歌曲暂无官方翻译）');
  }
}
