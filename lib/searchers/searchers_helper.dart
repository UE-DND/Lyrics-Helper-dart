import 'i_searcher.dart';
import 'netease_searcher.dart';
import 'searcher_helper.dart';
import 'searchers.dart';

/// 搜索提供者的静态帮助类
class SearchersHelper {
  /// 获取枚举的对应类实例
  static ISearcher getSearcher(Searchers searcher) {
    switch (searcher) {
      case Searchers.netease:
        return SearcherHelper.neteaseSearcher;
      // Musixmatch 搜索器已移除
      // 所有枚举情况已覆盖，无需 default
    }
  }

  /// 获取枚举的对应类新实例
  static ISearcher getNewSearcher(Searchers searcher) {
    switch (searcher) {
      case Searchers.netease:
        return NeteaseSearcher();
      // Musixmatch 搜索器已移除
      // 所有枚举情况已覆盖，无需 default
    }
  }

  /// 获取搜索类的对应枚举
  static Searchers? getSearchers(ISearcher searcher) {
    if (searcher is NeteaseSearcher) return Searchers.netease;
    // MusixmatchSearcher 已移除
    return null;
  }
}
