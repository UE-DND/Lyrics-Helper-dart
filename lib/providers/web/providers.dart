import 'netease/api.dart' as netease;

/// Mirror of C# static class `Providers` for lazy API instantiation.
class Providers {
  Providers._();

  static netease.Api? _neteaseApi;

  static netease.Api get neteaseApi => _neteaseApi ??= netease.Api();

  /// For test only
  static set neteaseApi(netease.Api api) {
    _neteaseApi = api;
  }
}
