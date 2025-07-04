# Lyricify Lyrics Helper – Dart (Slimmed Edition)

> **English / [简体中文](README_zh.md)**

A pure-Dart port of the original [Lyricify Lyrics Helper](https://github.com/WXRIW/Lyricify-Lyrics-Helper), now slimmed down for mobile-app scenarios: it focuses on **Netease Cloud Music lyric search, download and parsing**.

## Feature Matrix

| Module | Status |
|--------|--------|
| Parsers / Generators | ✅ Lyricify Syllable & Lines, LRC, YRC |
| Optimisers | ✅ Explicit filter, YRC tidy-up |
| Online Search & Retrieval | ✅ Netease Cloud Music |
| Unified API | ✅ `LyricsHelper.fetchLyricsFull()` |

> ⚠️  Code for QQMusic, Kugou, Musixmatch, KRC/QRC decryption etc. has been removed in this edition.

## Quick Start

```bash
# Clone repository
$ git clone https://github.com/UE-DND/Lyrics-Helper-dart.git
$ cd Lyrics-Helper-dart

# Fetch packages
$ dart pub get       # or: flutter pub get
```

### Use as a dependency

```yaml
# pubspec.yaml
dependencies:
  lyricify_lyrics_helper:
    git:
      url: https://github.com/UE-DND/Lyrics-Helper-dart
```

Example:

```dart
import 'package:lyricify_lyrics_helper/lyrics_helper.dart';
final result = await LyricsHelper.fetchLyricsFull(
  TrackMetadata()
    ..title = 'Shape of You'
    ..artist = 'Ed Sheeran',
);
if (result.status == FetchStatus.success) {
  print(result.lyricsData);
}
```

## Directory Layout (simplified)
```
lib/
├─ helpers/          – Tooling & optimisers
├─ parsers/          – Lyric parsers
├─ providers/        – Netease API wrapper
├─ searchers/        – Netease searcher
└─ lyrics_helper.dart – Unified public API
```

## License
Same license as the upstream project – see `LICENSE`.

## Acknowledgements
* [Lyricify Lyrics Helper (C#)](https://github.com/WXRIW/Lyricify-Lyrics-Helper)
* [LyricParser](https://github.com/HyPlayer/LyricParser)
* [163MusicLyrics](https://github.com/jitwxs/163MusicLyrics)