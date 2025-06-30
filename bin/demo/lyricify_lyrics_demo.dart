import 'dart:convert';
import 'dart:io';

import 'package:lyricify_lyrics_helper/helpers/generator_helper.dart';
import 'package:lyricify_lyrics_helper/helpers/parse_helper.dart';
import 'package:lyricify_lyrics_helper/helpers/search_helper.dart';
import 'package:lyricify_lyrics_helper/helpers/type_helper.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_data.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_types.dart';
import 'package:lyricify_lyrics_helper/models/track_metadata.dart';
import 'package:lyricify_lyrics_helper/searchers/helpers/compare_helper.dart';
import 'package:lyricify_lyrics_helper/searchers/searchers.dart' as searchers;
import 'package:lyricify_lyrics_helper/searchers/netease_search_result.dart';

/// Dart 版本的 Demo，功能与 `sourcecode/Lyricify.Lyrics.Demo/Program.cs` 保持 1:1 对应。
///
/// 默认情况下与 C# 一样，仅声明各 Demo 方法但不执行；
/// 如需体验，将 `main()` 中对应调用解除注释即可。
void main(List<String> arguments) async {
  await parsersDemo();
  await generatorsDemo();
  typeDetectorDemo();
  await searchDemo();
}

/// 解析示例：演示 ParseHelper 对多个原始歌词的解析能力。
Future<void> parsersDemo() async {
  final cases = <String, LyricsRawTypes>{
    'bin/demo/RawLyrics/LyricifySyllableDemo.txt':
        LyricsRawTypes.lyricifySyllable,
    'bin/demo/RawLyrics/LsMixQrcDemo.txt':
        LyricsRawTypes.lyricifySyllable,
    'bin/demo/RawLyrics/LyricifyLinesDemo.txt':
        LyricsRawTypes.lyricifyLines,
    'bin/demo/RawLyrics/LrcDemo.txt': LyricsRawTypes.lrc,
    'bin/demo/RawLyrics/QrcDemo.txt': LyricsRawTypes.qrc,
    'bin/demo/RawLyrics/KrcDemo.txt': LyricsRawTypes.krc,
    'bin/demo/RawLyrics/YrcDemo.txt': LyricsRawTypes.yrc,
    'bin/demo/RawLyrics/SpotifyDemo.txt':
        LyricsRawTypes.spotify,
    'bin/demo/RawLyrics/SpotifySyllableDemo.txt':
        LyricsRawTypes.spotify,
    'bin/demo/RawLyrics/SpotifyUnsyncedDemo.txt':
        LyricsRawTypes.spotify,
    'bin/demo/RawLyrics/MusixmatchDemo.txt':
        LyricsRawTypes.musixmatch,
  };

  for (final entry in cases.entries) {
    final path = entry.key;
    final type = entry.value;
    final content = File(path).readAsStringSync();
    final LyricsData? data = ParseHelper.parseLyrics(content, type);

    // pretty-print，若模型未实现 toJson 则用对象字符串兜底。
    final pretty = const JsonEncoder.withIndent('  ').convert(data);
    stdout
      ..writeln('===== $path ($type) =====')
      ..writeln(pretty)
      ..writeln();
  }
}

/// 生成示例：演示 GenerateHelper 将解析结果转换为不同歌词格式。
Future<void> generatorsDemo() async {
  const src =
      'bin/demo/RawLyrics/LyricifySyllableDemo.txt';
  final content = File(src).readAsStringSync();
  final lyricsData =
      ParseHelper.parseLyrics(content, LyricsRawTypes.lyricifySyllable)!;

  final targets = <LyricsTypes>[
    LyricsTypes.lyricifySyllable,
    LyricsTypes.lyricifyLines,
    LyricsTypes.lrc,
    LyricsTypes.qrc,
    LyricsTypes.krc,
    LyricsTypes.yrc,
  ];

  for (final t in targets) {
    final generated = GenerateHelper.generateString(lyricsData, t);
    stdout
      ..writeln('===== Generated ${t.name} =====')
      ..writeln(generated)
      ..writeln();
  }
}

/// 类型检测示例：展示 TypeHelper 的判别结果。
void typeDetectorDemo() {
  final lrc = File(
          'bin/demo/RawLyrics/LrcDemo.txt')
      .readAsStringSync();
  final qrc = File(
          'bin/demo/RawLyrics/QrcDemo.txt')
      .readAsStringSync();

  stdout.writeln('Is LRC? ${TypeHelper.isLyricsType(lrc, LyricsTypes.lrc)}');
  stdout.writeln('Is LRC? ${TypeHelper.isLyricsType(qrc, LyricsTypes.lrc)}');
}

/// 搜索示例：调用网络搜索并比较匹配度。
Future<void> searchDemo() async {
  final meta = TrackMultiArtistMetadata()
    ..album = 'RUNAWAY'
    ..albumArtists = ['OneRepublic']
    ..artists = ['OneRepublic']
    ..durationMs = 143264
    ..title = 'RUNAWAY';

  final result = await SearchHelper.search(
    meta,
    searchers.Searchers.Netease,
    minimumMatch: CompareMatchType.medium,
  );

  final pretty = const JsonEncoder.withIndent('  ').convert(
    jsonDecode(jsonEncode(
      result,
      toEncodable: (obj) {
        if (obj is Map || obj is List) return obj;
        if (obj is NeteaseSearchResult) return obj.toJson();
        return obj.toString();
      },
    )),
  );
  stdout
    ..writeln('===== Search Result =====')
    ..writeln(pretty);
} 