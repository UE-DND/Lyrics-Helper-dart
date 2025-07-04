import 'package:lyricify_lyrics_helper/helpers/search_helper.dart';
import 'package:lyricify_lyrics_helper/models/track_metadata.dart';
import 'package:lyricify_lyrics_helper/providers/web/providers.dart';
import 'package:lyricify_lyrics_helper/searchers/helpers/compare_helper.dart';
import 'package:lyricify_lyrics_helper/searchers/searchers.dart';
import 'package:lyricify_lyrics_helper/searchers/netease_search_result.dart';

/// 根据歌名在网易云音乐搜索并输出歌词的示例。
///
/// 用法：
/// ```bash
/// dart run bin/demo/search_lyrics_netease.dart "転がる岩、君に朝が降る"
/// ```
Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    print('请在命令行参数中提供歌曲名称。');
    print(
        '示例: dart run bin/demo/search_lyrics_from_title_netease.dart "転がる岩、君に朝が降る"');
    return;
  }

  final title = args.join(' ');

  final meta = TrackMultiArtistMetadata()..title = title;

  final result = await SearchHelper.search(
    meta,
    Searchers.netease,
    minimumMatch: CompareMatchType.low, // 允许较宽松匹配，必要时可调
  );

  if (result == null) {
    print('在网易云未找到匹配曲目: $title');
    return;
  }

  String? songId;
  if (result is NeteaseSearchResult) songId = result.id;

  print(
      '找到曲目: ${result.title} - ${result.artists.join(', ')} (ID: ${songId ?? '未知'})');

  if (songId == null) {
    print('无法获取歌曲 ID，无法拉取歌词。');
    return;
  }

  try {
    final lyricRes = await Providers.neteaseApi.getLyricNew(songId) ??
        await Providers.neteaseApi.getLyric(songId);

    final original = lyricRes?.lrc?.lyric;
    final translation = lyricRes?.tlyric?.lyric;

    if (original == null && translation == null) {
      print('该曲目无歌词信息（包含翻译）。');
      return;
    }

    if (original != null) {
      print('\n===== 原文歌词 =====\n');
      print(original);
    }

    if (translation != null) {
      print('\n===== 翻译歌词 =====\n');
      print(translation);
    } else {
      print('\n（该歌曲暂无官方翻译）');
    }
  } catch (e) {
    print('获取歌词时发生错误: $e');
  }
}
