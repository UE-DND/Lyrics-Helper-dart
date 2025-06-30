import 'i_track_metadata.dart';

/// 音轨元数据类
class TrackMetadata implements ITrackMetadata {
  @override
  String? title;

  @override
  String? artist;

  @override
  String? album;

  @override
  String? albumArtist;

  @override
  int? durationMs;

  @override
  String? isrc;

  @override
  List<String>? language;

  Map<String, dynamic> toJson() => {
        'title': title,
        'artist': artist,
        'album': album,
        'albumArtist': albumArtist,
        'durationMs': durationMs,
        'isrc': isrc,
        'language': language,
      };

  @override
  String toString() => toJson().toString();
}

/// 多艺术家音轨元数据类
class TrackMultiArtistMetadata implements ITrackMetadata {
  @override
  String? title;

  @override
  String? get artist => artists.join(', ');

  @override
  set artist(String? value) {
    artists = (value ?? '').isEmpty ? [] : (value ?? '').split(', ').toList();
  }

  /// 艺术家列表
  List<String> artists = [];

  @override
  String? album;

  @override
  String? get albumArtist => albumArtists.join(', ');

  @override
  set albumArtist(String? value) {
    albumArtists =
        (value ?? '').isEmpty ? [] : (value ?? '').split(', ').toList();
  }

  /// 专辑艺术家列表
  List<String> albumArtists = [];

  @override
  int? durationMs;

  @override
  String? isrc;

  @override
  List<String>? language;

  /// 从一般音轨元数据获取多艺术家元数据
  static TrackMultiArtistMetadata fromTrackMetadata(ITrackMetadata track) {
    if (track is TrackMultiArtistMetadata) {
      return track;
    }

    final trackMultiArtist = TrackMultiArtistMetadata();
    trackMultiArtist.artist = track.artist;
    trackMultiArtist.album = track.album;
    trackMultiArtist.albumArtist = track.albumArtist;
    trackMultiArtist.durationMs = track.durationMs;
    trackMultiArtist.isrc = track.isrc;
    trackMultiArtist.language = track.language;
    trackMultiArtist.title = track.title;

    return trackMultiArtist;
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'artist': artist,
        'album': album,
        'albumArtist': albumArtist,
        'durationMs': durationMs,
        'isrc': isrc,
        'language': language,
      };

  @override
  String toString() => toJson().toString();
}

/// Spotify音轨元数据类
class SpotifyTrackMetadata extends TrackMultiArtistMetadata {
  /// Spotify音轨ID
  String? id;

  /// Spotify音轨URI
  String? get uri => id != null ? "spotify:track:$id" : null;
}
