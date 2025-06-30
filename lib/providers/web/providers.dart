import 'kugou/api.dart' as kugou;
import 'musixmatch/api.dart' as musixmatch;
import 'netease/api.dart' as netease;
import 'qqmusic/api.dart' as qqmusic;

/// Mirror of C# static class `Providers` for lazy API instantiation.
class Providers {
  Providers._();

  static kugou.Api? _kugouApi;
  static musixmatch.Api? _musixmatchApi;
  static netease.Api? _neteaseApi;
  static qqmusic.Api? _qqMusicApi;

  static kugou.Api get kugouApi => _kugouApi ??= kugou.Api();

  static musixmatch.Api get musixmatchApi =>
      _musixmatchApi ??= musixmatch.Api();

  static netease.Api get neteaseApi => _neteaseApi ??= netease.Api();

  static qqmusic.Api get qqMusicApi => _qqMusicApi ??= qqmusic.Api();
}
