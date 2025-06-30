# Lyricify Lyrics Helper (Dart Port)

> **English / [简体中文](README_zh.md)**

## Overview
This repository is a **pure-Dart** migration of the original C# project "Lyricify Lyrics Helper".
It offers the same feature set – lyric parsing / generation / optimisation, online search and decryption –
but can be consumed on every platform supported by Dart & Flutter.

This repository now hosts the Dart implementation only. (The original C# repo lives separately; see below.)

| Module | Status |
|--------|--------|
| Parsers / Generators | ✅ Feature-parity with C# |
| Searchers (Netease, Kugou, QQMusic, Musixmatch) | ✅ Working |
| Spotify support | ⚠️ Not yet ported |
| Optimisers (Explicit, YRC, Musixmatch) | ✅ Working |
| Decrypters (QRC, KRC) | ✅ Working |

## Repositories
| Project | Description | URL |
|---------|-------------|-----|
| Dart Port | This repository (actively maintained) | https://github.com/UE-DND/Lyrics-Helper-dart |
| C# Original | Up-stream implementation in C# | https://github.com/WXRIW/Lyricify-Lyrics-Helper |

## Getting Started
```bash
# Clone
$ git clone https://github.com/UE-DND/Lyrics-Helper-dart.git
$ cd Lyrics-Helper-dart

# Fetch packages
$ dart pub get  # or: flutter pub get

# Run the demo (parsing / generating / searching)
$ dart run bin/demo/lyricify_lyrics_demo.dart
```

### Use as a dependency
```yaml
# pubspec.yaml of your project
dependencies:
  lyricify_lyrics_helper:
    git:
      url: https://github.com/UE-DND/Lyrics-Helper-dart
```
Then import the modules you need:
```dart
import 'package:lyricify_lyrics_helper/helpers/parse_helper.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_types.dart';

final data = ParseHelper.parseLyrics(rawText, LyricsRawTypes.lrc);
```

## Directory Layout (simplified)
```
lib/                 – Core library code
bin/                 – Command-line demo & utilities
test/                – Tests (if any)
.github/             – CI
README*.md           – Documentation
```

## License
Same license as upstream project. See `LICENSE` for details.

## Acknowledgements
* [Lyricify Lyrics Helper (C#)](https://github.com/WXRIW/Lyricify-Lyrics-Helper) – the original codebase this port is based on.
* [LyricParser](https://github.com/HyPlayer/LyricParser) (MIT)
* [163MusicLyrics](https://github.com/jitwxs/163MusicLyrics) (Apache-2.0)
* And everyone who contributed to both versions of the project.