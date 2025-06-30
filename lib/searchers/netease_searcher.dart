import '../providers/web/netease/api.dart' show SearchType;
import '../providers/web/providers.dart';
import 'i_search_result.dart';
import 'i_searcher.dart';
import 'netease_search_result.dart';
import 'searcher.dart';
import 'searchers.dart';
import '../providers/web/netease/response.dart' show Song, EapiSong;

class NeteaseSearcher extends Searcher implements ISearcher {
  @override
  String get name => "Netease";

  @override
  String get displayName => "Netease Cloud Music";

  @override
  Searchers get searcherType => Searchers.Netease;

  bool _useNewSearchFirst = false;

  @override
  Future<List<ISearchResult>?> searchForResultsByString(
      String searchString) async {
    var search = <ISearchResult>[];

    dynamic result;
    if (_useNewSearchFirst) {
      try {
        result = await Providers.neteaseApi.searchNew(searchString);
      } catch (e) {
        _useNewSearchFirst = !_useNewSearchFirst;
        try {
          result =
              await Providers.neteaseApi.search(searchString, SearchType.song);
          if (result?.code == -460) throw Exception();
        } catch (e) {
          _useNewSearchFirst = !_useNewSearchFirst;
        }
      }
    } else {
      try {
        result =
            await Providers.neteaseApi.search(searchString, SearchType.song);
        if (result?.code == -460) throw Exception();
      } catch (e) {
        _useNewSearchFirst = !_useNewSearchFirst;
        // 尝试新接口，可以在外网使用
        try {
          result = await Providers.neteaseApi.searchNew(searchString);
        } catch (e) {
          // 忽略异常
        }
      }
    }

    try {
      var results = result?.result?.songs;
      if (results == null) return null;
      for (var track in results) {
        if (track is Song) {
          search.add(NeteaseSearchResult.fromSong(track));
        } else if (track is EapiSong) {
          search.add(NeteaseSearchResult.fromEapiSong(track));
        } else {
          // fallback: try dynamic mapping
          try {
            search.add(NeteaseSearchResult.fromDynamic(track));
          } catch (_) {}
        }
      }
    } catch (e) {
      return null;
    }

    return search;
  }
}
