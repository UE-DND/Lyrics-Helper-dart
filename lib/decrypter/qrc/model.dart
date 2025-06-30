class QqLyricsResponse {
  final String? lyrics;
  final String? trans;

  QqLyricsResponse({
    this.lyrics,
    this.trans,
  });

  factory QqLyricsResponse.fromJson(Map<String, dynamic> json) {
    return QqLyricsResponse(
      lyrics: json['lyrics'] as String?,
      trans: json['trans'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lyrics': lyrics,
      'trans': trans,
    };
  }
}

class Song {
  final String? id;

  Song({
    this.id,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}

class SongResponse {
  final int code;
  final List<Song>? data;

  SongResponse({
    this.code = 0,
    this.data,
  });

  factory SongResponse.fromJson(Map<String, dynamic> json) {
    return SongResponse(
      code: json['code'] as int? ?? 0,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}
