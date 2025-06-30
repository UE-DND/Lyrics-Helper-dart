import 'kugou_searcher.dart';
import 'musixmatch_searcher.dart';
import 'netease_searcher.dart';
import 'qqmusic_searcher.dart';

/// 实例化搜索提供者的静态类
class SearcherHelper {
  static QQMusicSearcher? _qqMusicSearcher;

  static QQMusicSearcher get qqMusicSearcher =>
      _qqMusicSearcher ??= QQMusicSearcher();

  static NeteaseSearcher? _neteaseSearcher;

  static NeteaseSearcher get neteaseSearcher =>
      _neteaseSearcher ??= NeteaseSearcher();

  static KugouSearcher? _kugouSearcher;

  static KugouSearcher get kugouSearcher => _kugouSearcher ??= KugouSearcher();

  static MusixmatchSearcher? _musixmatchSearcher;

  static MusixmatchSearcher get musixmatchSearcher =>
      _musixmatchSearcher ??= MusixmatchSearcher();
}
