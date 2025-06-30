import '../providers/web/providers.dart';
import 'i_search_result.dart';
import 'i_searcher.dart';
import 'kugou_search_result.dart';
import 'searcher.dart';
import 'searchers.dart';

class KugouSearcher extends Searcher implements ISearcher {
  @override
  String get name => "Kugou";

  @override
  String get displayName => "Kugou Music";

  @override
  Searchers get searcherType => Searchers.Kugou;

  @override
  Future<List<ISearchResult>?> searchForResultsByString(String searchString) async {
    var search = <ISearchResult>[];

    try {
      var result = await Providers.kugouApi.getSearchSong(searchString);
      var results = result?.data?.info;
      if (results == null) return null;
      for (var track in results) {
        search.add(KugouSearchResult.fromInfoItem(track));
        if (track.group != null && track.group!.isNotEmpty) {
          for (var subTrack in track.group!) {
            search.add(KugouSearchResult.fromInfoItem(subTrack));
          }
        }
      }
    } catch (e) {
      return null;
    }

    return search;
  }
} 