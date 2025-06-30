import '../providers/web/netease/response.dart' show Song, EapiSong;
import 'helpers/compare_helper.dart';
import 'i_search_result.dart';
import 'i_searcher.dart';
import 'netease_searcher.dart';
import 'dart:convert';

// ignore_for_file: dead_null_aware_expression

class NeteaseSearchResult implements ISearchResult {
  @override
  ISearcher get searcher => NeteaseSearcher();

  NeteaseSearchResult(String title, List<String> artists, String album, List<String>? albumArtists, int durationMs, String id) {
    _title = title;
    _artists = artists;
    _album = album;
    _albumArtists = albumArtists;
    _durationMs = durationMs;
    _id = id;
  }

  NeteaseSearchResult.fromSong(Song song) : this(
    song.name ?? "",
    song.artists?.map((s) => s.name ?? "").toList() ?? [],
    song.album?.name ?? "",
    null,
    song.duration ?? 0,
    song.id ?? ""
  );

  NeteaseSearchResult.fromEapiSong(EapiSong song) : this(
    song.name,
    song.artists?.map((s) => s.name).toList() ?? [],
    song.album?.name ?? "",
    null,
    song.duration,
    song.id.toString(),
  );

  // 根据动态类型创建
  factory NeteaseSearchResult.fromDynamic(dynamic track) {
    if (track is Song) {
      return NeteaseSearchResult.fromSong(track);
    } else if (track is EapiSong) {
      return NeteaseSearchResult.fromEapiSong(track);
    } else {
      throw ArgumentError("Unsupported track type");
    }
  }

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

  @override
  String toString() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'title': _title,
        'artists': _artists,
        'album': _album,
        'albumArtists': _albumArtists,
        'durationMs': _durationMs,
        'id': _id,
        'matchType': _matchType?.toString(),
      };
} 