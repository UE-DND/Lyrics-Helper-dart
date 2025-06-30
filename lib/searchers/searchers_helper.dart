import 'i_searcher.dart';
import 'kugou_searcher.dart';
import 'musixmatch_searcher.dart';
import 'netease_searcher.dart';
import 'qqmusic_searcher.dart';
import 'searcher_helper.dart';
import 'searchers.dart';

/// 搜索提供者的静态帮助类
class SearchersHelper {
  /// 获取枚举的对应类实例
  static ISearcher getSearcher(Searchers searcher) {
    switch (searcher) {
      case Searchers.qqMusic:
        return SearcherHelper.qqMusicSearcher;
      case Searchers.netease:
        return SearcherHelper.neteaseSearcher;
      case Searchers.kugou:
        return SearcherHelper.kugouSearcher;
      case Searchers.musixmatch:
        return SearcherHelper.musixmatchSearcher;
      // 所有枚举情况已覆盖，无需 default
    }
  }

  /// 获取枚举的对应类新实例
  static ISearcher getNewSearcher(Searchers searcher) {
    switch (searcher) {
      case Searchers.qqMusic:
        return QQMusicSearcher();
      case Searchers.netease:
        return NeteaseSearcher();
      case Searchers.kugou:
        return KugouSearcher();
      case Searchers.musixmatch:
        return MusixmatchSearcher();
      // 所有枚举情况已覆盖，无需 default
    }
  }

  /// 获取搜索类的对应枚举
  static Searchers? getSearchers(ISearcher searcher) {
    if (searcher is QQMusicSearcher) return Searchers.qqMusic;
    if (searcher is NeteaseSearcher) return Searchers.netease;
    if (searcher is KugouSearcher) return Searchers.kugou;
    if (searcher is MusixmatchSearcher) return Searchers.musixmatch;
    return null;
  }
}
