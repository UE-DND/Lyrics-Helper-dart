import '../providers/web/musixmatch/response.dart' show Track;
import 'helpers/compare_helper.dart';
import 'i_search_result.dart';
import 'i_searcher.dart';
import 'musixmatch_searcher.dart';

// ignore_for_file: dead_null_aware_expression

class MusixmatchSearchResult implements ISearchResult {
  @override
  ISearcher get searcher => MusixmatchSearcher();

  MusixmatchSearchResult(String title, List<String> artists, String album, List<String>? albumArtists, int durationMs, int id, String isrc, String vanityId) {
    _title = title;
    _artists = artists;
    _album = album;
    _albumArtists = albumArtists;
    _durationMs = durationMs;
    _id = id;
    _isrc = isrc;
    _vanityId = vanityId;
  }

  MusixmatchSearchResult.fromTrack(Track track) : this(
    track.trackName ?? "",
    (track.artistName ?? "").split(RegExp(r" feat. | & ")).where((s) => s.isNotEmpty).toList(),
    track.albumName ?? "",
    null,
    track.trackLength != null ? track.trackLength! * 1000 : 0,
    track.trackId,
    track.trackIsrc ?? "",
    track.albumVanityId ?? ""
  );

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

  late final int _id;
  int get id => _id;

  late final String _isrc;
  String get isrc => _isrc;

  late final List<String>? _albumArtists;
  @override
  List<String>? get albumArtists => _albumArtists;

  @override
  String? get albumArtist => _albumArtists?.join(", ");

  late final int _durationMs;
  @override
  int? get durationMs => _durationMs;

  late String _vanityId;
  String get vanityId => _vanityId;
  set vanityId(String value) => _vanityId = value;

  CompareMatchType? _matchType;
  @override
  CompareMatchType? get matchType => _matchType;

  @override
  void setMatchType(CompareMatchType? matchType) {
    _matchType = matchType;
  }
} 