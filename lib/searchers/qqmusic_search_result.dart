import '../providers/web/qqmusic/response.dart';
import 'helpers/compare_helper.dart';
import 'i_search_result.dart';
import 'i_searcher.dart';
import 'qqmusic_searcher.dart';

// ignore_for_file: dead_null_aware_expression

class QQMusicSearchResult implements ISearchResult {
  @override
  ISearcher get searcher => QQMusicSearcher();

  QQMusicSearchResult(String title, List<String> artists, String album,
      List<String>? albumArtists, int durationMs, String id, String mid) {
    _title = title;
    _artists = artists;
    _album = album;
    _albumArtists = albumArtists;
    _durationMs = durationMs;
    _id = id;
    _mid = mid;
  }

  QQMusicSearchResult.fromSong(Song song)
      : this(
            song.title ?? "",
            song.singer?.map((s) => s.name ?? "").toList() ?? [],
            song.album?.title ?? "",
            null,
            song.interval * 1000,
            song.id ?? "",
            song.mid ?? "");

  late final String _title;
  @override
  String get title => _title;

  late final List<String> _artists;
  @override
  List<String> get artists => _artists;

  @override
  String get artist => _artists.join(", ");

  late final String _album;
  @override
  String get album => _album;

  late final String _id;
  String get id => _id;

  late final String _mid;
  String get mid => _mid;

  late final List<String>? _albumArtists;
  @override
  List<String>? get albumArtists => _albumArtists;

  @override
  String? get albumArtist => _albumArtists?.join(", ");

  late final int _durationMs;
  @override
  int? get durationMs => _durationMs;

  CompareMatchType? _matchType;
  @override
  CompareMatchType? get matchType => _matchType;

  @override
  void setMatchType(CompareMatchType? matchType) {
    _matchType = matchType;
  }
}
