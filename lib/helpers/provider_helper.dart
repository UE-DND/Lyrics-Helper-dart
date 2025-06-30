import '../providers/web/kugou/api.dart' as kugou;
import '../providers/web/musixmatch/api.dart' as musixmatch;
import '../providers/web/netease/api.dart' as netease;
import '../providers/web/qqmusic/api.dart' as qqmusic;
import '../providers/web/providers.dart' as providers;

/// <summary>
/// 提供 API 实例化后的静态类
/// </summary>
class ProviderHelper {
  ProviderHelper._();

  static qqmusic.Api get qqMusicApi => providers.Providers.qqMusicApi;

  static netease.Api get neteaseApi => providers.Providers.neteaseApi;

  static kugou.Api get kugouApi => providers.Providers.kugouApi;

  static musixmatch.Api get musixmatchApi => providers.Providers.musixmatchApi;
} 