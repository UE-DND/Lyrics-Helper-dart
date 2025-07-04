import 'netease_searcher.dart';

/// 实例化搜索提供者的静态类
class SearcherHelper {
  static NeteaseSearcher? _neteaseSearcher;

  static NeteaseSearcher get neteaseSearcher =>
      _neteaseSearcher ??= NeteaseSearcher();
}
