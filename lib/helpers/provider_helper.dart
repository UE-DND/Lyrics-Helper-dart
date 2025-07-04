import '../providers/web/netease/api.dart' as netease;
import '../providers/web/providers.dart' as providers;

/// <summary>
/// 提供 API 实例化后的静态类
/// </summary>
class ProviderHelper {
  ProviderHelper._();

  static netease.Api get neteaseApi => providers.Providers.neteaseApi;
}
