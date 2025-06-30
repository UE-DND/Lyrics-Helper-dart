import '../providers/web/providers.dart';
import '../providers/web/qqmusic/api.dart';
import 'i_search_result.dart';
import 'i_searcher.dart';
import 'qqmusic_search_result.dart';
import 'searcher.dart';
import 'searchers.dart';

class QQMusicSearcher extends Searcher implements ISearcher {
  @override
  String get name => "QQ Music";

  @override
  String get displayName => "QQ Music";

  @override
  Searchers get searcherType => Searchers.qqMusic;

  @override
  Future<List<ISearchResult>?> searchForResultsByString(
      String searchString) async {
    var search = <ISearchResult>[];

    try {
      var result = await Providers.qqMusicApi
          .search(searchString, SearchTypeEnum.songId);
      var results = result?.req1?.data?.body?.song?.list;
      if (results == null) return null;
      for (var track in results) {
        search.add(QQMusicSearchResult.fromSong(track));
        // 处理可能存在的同组歌曲列表
        final dynamic group = (track as dynamic).group;
        if (group != null && group is List) {
          for (var subTrack in group) {
            search.add(QQMusicSearchResult.fromSong(subTrack));
          }
        }
      }
    } catch (e) {
      return null;
    }

    return search;
  }
}
