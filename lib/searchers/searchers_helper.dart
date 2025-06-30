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
      case Searchers.QQMusic:
        return SearcherHelper.qqMusicSearcher;
      case Searchers.Netease:
        return SearcherHelper.neteaseSearcher;
      case Searchers.Kugou:
        return SearcherHelper.kugouSearcher;
      case Searchers.Musixmatch:
        return SearcherHelper.musixmatchSearcher;
      // 所有枚举情况已覆盖，无需 default
    }
  }

  /// 获取枚举的对应类新实例
  static ISearcher getNewSearcher(Searchers searcher) {
    switch (searcher) {
      case Searchers.QQMusic:
        return QQMusicSearcher();
      case Searchers.Netease:
        return NeteaseSearcher();
      case Searchers.Kugou:
        return KugouSearcher();
      case Searchers.Musixmatch:
        return MusixmatchSearcher();
      // 所有枚举情况已覆盖，无需 default
    }
  }

  /// 获取搜索类的对应枚举
  static Searchers? getSearchers(ISearcher searcher) {
    if (searcher is QQMusicSearcher) return Searchers.QQMusic;
    if (searcher is NeteaseSearcher) return Searchers.Netease;
    if (searcher is KugouSearcher) return Searchers.Kugou;
    if (searcher is MusixmatchSearcher) return Searchers.Musixmatch;
    return null;
  }
}
