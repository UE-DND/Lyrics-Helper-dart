import '../providers/web/kugou/response.dart';
import 'helpers/compare_helper.dart';
import 'i_search_result.dart';
import 'i_searcher.dart';
import 'kugou_searcher.dart';

// ignore_for_file: dead_null_aware_expression

class KugouSearchResult implements ISearchResult {
  @override
  ISearcher get searcher => KugouSearcher();

  KugouSearchResult(String title, List<String> artists, String album,
      List<String>? albumArtists, int durationMs, String hash) {
    _title = title;
    _artists = artists;
    _album = album;
    _albumArtists = albumArtists;
    _durationMs = durationMs;
    _hash = hash;
  }

  KugouSearchResult.fromInfoItem(InfoItem song)
      : this(
            song.songName ?? "",
            (song.singerName ?? "")
                .split('、')
                .where((s) => s.isNotEmpty)
                .toList(),
            song.albumName ?? "", // 很可能会包含中文译名
            null,
            song.duration * 1000,
            song.hash ?? "");

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

  late final String _hash;
  String get hash => _hash;

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
