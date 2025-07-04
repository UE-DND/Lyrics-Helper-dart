import 'dart:convert';
import 'dart:io';

import 'package:lyricify_lyrics_helper/helpers/generator_helper.dart';
import 'package:lyricify_lyrics_helper/helpers/parse_helper.dart';
import 'package:lyricify_lyrics_helper/helpers/search_helper.dart';
import 'package:lyricify_lyrics_helper/helpers/type_helper.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_types.dart';
import 'package:lyricify_lyrics_helper/models/track_metadata.dart';
import 'package:lyricify_lyrics_helper/searchers/helpers/compare_helper.dart';
import 'package:lyricify_lyrics_helper/searchers/searchers.dart' as searchers;
import 'package:lyricify_lyrics_helper/searchers/netease_search_result.dart';

/// Dart 版本的 Demo，功能与 `sourcecode/Lyricify.Lyrics.Demo/Program.cs`

void main(List<String> arguments) async {
  await parsersDemo();
  await generatorsDemo();
  typeDetectorDemo();
  await searchDemo();
}

/// 解析示例：演示 ParseHelper 对多个原始歌词的解析能力。
Future<void> parsersDemo() async {
  const path = 'bin/demo/RawLyrics/YrcDemo.txt';
  final content = File(path).readAsStringSync();
  final data = ParseHelper.parseLyrics(content, LyricsRawTypes.yrc);

  final pretty = const JsonEncoder.withIndent('  ').convert(data);
  stdout
    ..writeln('===== $path (YRC) =====')
    ..writeln(pretty)
    ..writeln();

  // === LRC 示例 ===
  const lrcPath = 'bin/demo/RawLyrics/LrcDemo.txt';
  final lrcContent = File(lrcPath).readAsStringSync();
  final lrcData = ParseHelper.parseLyrics(lrcContent); // 自动识别为 LRC

  final lrcPretty = const JsonEncoder.withIndent('  ').convert(lrcData);
  stdout
    ..writeln('===== $lrcPath (LRC) =====')
    ..writeln(lrcPretty)
    ..writeln();

  // === Lyricify Lines 示例 ===
  const linesPath = 'bin/demo/RawLyrics/LyricifyLinesDemo.txt';
  final linesContent = File(linesPath).readAsStringSync();
  final linesData = ParseHelper.parseLyrics(linesContent);

  final linesPretty = const JsonEncoder.withIndent('  ').convert(linesData);
  stdout
    ..writeln('===== $linesPath (Lyricify Lines) =====')
    ..writeln(linesPretty)
    ..writeln();

  // === Lyricify Syllable 示例 ===
  const syllablePath = 'bin/demo/RawLyrics/LyricifySyllableDemo.txt';
  final syllableContent = File(syllablePath).readAsStringSync();
  final syllableData = ParseHelper.parseLyrics(syllableContent);

  final syllablePretty =
      const JsonEncoder.withIndent('  ').convert(syllableData);
  stdout
    ..writeln('===== $syllablePath (Lyricify Syllable) =====')
    ..writeln(syllablePretty)
    ..writeln();
}

/// 生成示例：演示 GenerateHelper 将解析结果转换为不同歌词格式。
Future<void> generatorsDemo() async {
  const src = 'bin/demo/RawLyrics/YrcDemo.txt';
  final content = File(src).readAsStringSync();
  final lyricsData = ParseHelper.parseLyrics(content, LyricsRawTypes.yrc)!;

  final targets = <LyricsTypes>[
    LyricsTypes.lrc,
    LyricsTypes.lyricifyLines,
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
  final yrc = File('bin/demo/RawLyrics/YrcDemo.txt').readAsStringSync();

  stdout.writeln('Is YRC? ${TypeHelper.isLyricsType(yrc, LyricsTypes.yrc)}');
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
    searchers.Searchers.netease,
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
