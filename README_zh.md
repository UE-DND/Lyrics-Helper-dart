# Lyricify Lyrics Helper（Dart 版移植）

> **简体中文 / [English](README.md)**

## 仓库地址
| 项目 | 说明 | 链接 |
|------|------|------|
| Dart 移植版 | 本仓库，使用 Dart 重新实现并持续维护 | https://github.com/UE-DND/Lyrics-Helper-dart |
| C# 原版 | 上游 C# 实现 | https://github.com/WXRIW/Lyricify-Lyrics-Helper |

## 项目简介
本仓库是 **C# 版 Lyricify Lyrics Helper** 的 **纯 Dart 移植**，功能与原版保持一致，
可在 Dart / Flutter 全平台使用。

本仓库现仅包含 Dart 版本实现，原 C# 仓库请参阅下方链接。

## 功能覆盖
- **歌词解析 / 生成**  
  支持 Lyricify Syllable / Lines、LRC、QRC、KRC、YRC 等格式
- **歌词优化**  
  Explicit、YRC、Musixmatch
- **歌曲搜索**  
  网易云、酷狗、QQ 音乐、Musixmatch（Spotify 尚未移植）
- **歌词解密**  
  QRC、KRC

## 快速开始
```bash
# 克隆仓库
$ git clone https://github.com/UE-DND/Lyrics-Helper-dart.git
$ cd Lyrics-Helper-dart

# 安装依赖
$ dart pub get  # 或 flutter pub get

# 运行示例（解析 / 生成 / 搜索）
$ dart run bin/demo/lyricify_lyrics_demo.dart
```

### 作为依赖引入
```yaml
# pubspec.yaml
dependencies:
  lyricify_lyrics_helper:
    git:
      url: https://github.com/UE-DND/Lyrics-Helper-dart
```
示例：
```dart
import 'package:lyricify_lyrics_helper/helpers/parse_helper.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_types.dart';

final data = ParseHelper.parseLyrics(rawText, LyricsRawTypes.lrc);
```

## 目录结构（简）
```
lib/                 – 核心库代码
bin/                 – 命令行示例 / 工具
test/                – 单元测试（如有）
.github/             – CI
README*.md           – 文档
```

## 许可协议
与上游项目保持一致，详见 `LICENSE`。

## 致谢
* [Lyricify Lyrics Helper (C#)](https://github.com/WXRIW/Lyricify-Lyrics-Helper) – 本项目的原始实现
* [LyricParser](https://github.com/HyPlayer/LyricParser) (MIT)
* [163MusicLyrics](https://github.com/jitwxs/163MusicLyrics) (Apache-2.0)
* 以及所有为两个版本做出贡献的人！ 