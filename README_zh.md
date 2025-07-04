# Lyricify Lyrics Helper – Dart 精简版移植

> **简体中文 / [English](README.md)**

本仓库为 [Lyricify Lyrics Helper](https://github.com/WXRIW/Lyricify-Lyrics-Helper) 的 **纯 Dart 迁移**，并已根据移动端播放器需求做精简，只保留"网易云歌词在线搜索 + 解析"核心能力。

## 功能概览

| 模块 | 状态 |
|------|------|
| 歌词解析 / 生成 | ✅ Lyricify Syllable / Lines、LRC、YRC 等 |
| 歌词优化 | ✅ Explicit 过滤、YRC 行内合并 |
| 在线搜索 / 获取 | ✅ 网易云 (Netease Cloud Music) |
| 统一接口 | ✅ `LyricsHelper.fetchLyricsFull()` |

> ⚠️  其它平台（QQMusic、Kugou、Musixmatch 等）及 KRC/QRC 解密相关代码已移除。

## 快速上手

```bash
# 克隆仓库
$ git clone https://github.com/UE-DND/Lyrics-Helper-dart.git
$ cd Lyrics-Helper-dart

# 获取依赖
$ dart pub get  # 或 flutter pub get
```

### 在项目中使用

```yaml
# pubspec.yaml
dependencies:
  lyricify_lyrics_helper:
    git:
      url: https://github.com/UE-DND/Lyrics-Helper-dart
```

调用示例：

```dart
import 'package:lyricify_lyrics_helper/lyrics_helper.dart';

// 完整调用，带状态与错误信息
final result = await LyricsHelper.fetchLyricsFull(
  TrackMetadata()
    ..title = '晴天'
    ..artist = '周杰伦',
);
if (result.status == FetchStatus.success) {
  // result.lyricsData 即解析后的歌词结构
}
```

## 目录结构（简）
```
lib/                 – 核心库代码
├─ helpers/          – 各类工具 & 优化器
├─ parsers/          – 歌词解析器
├─ providers/        – 网易云 API 调用封装
├─ searchers/        – 网易云搜索器
└─ lyrics_helper.dart– 对外统一接口
```

## 许可协议
本项目沿用上游仓库 License，详见 `LICENSE` 文件。

## 致谢
* [Lyricify Lyrics Helper (C#)](https://github.com/WXRIW/Lyricify-Lyrics-Helper) – 原始实现
* [LyricParser](https://github.com/HyPlayer/LyricParser) – 歌词解析参考实现
* [163MusicLyrics](https://github.com/jitwxs/163MusicLyrics) – 网易云歌词参考实现