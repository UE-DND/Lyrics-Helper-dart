
class KugouLyricsResponse {
  final String? content;
  final String? info;
  final String? source;
  final int status;
  final int contentType;
  final int errorCode;
  final String? format;

  KugouLyricsResponse({
    this.content,
    this.info,
    this.source,
    this.status = 0,
    this.contentType = 0,
    this.errorCode = 0,
    this.format,
  });

  factory KugouLyricsResponse.fromJson(Map<String, dynamic> json) {
    return KugouLyricsResponse(
      content: json['content'] as String?,
      info: json['info'] as String?,
      source: json['_source'] as String?,
      status: json['status'] as int? ?? 0,
      contentType: json['contenttype'] as int? ?? 0,
      errorCode: json['error_code'] as int? ?? 0,
      format: json['fmt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'info': info,
      '_source': source,
      'status': status,
      'contenttype': contentType,
      'error_code': errorCode,
      'fmt': format,
    };
  }
}

class KugouTranslation {
  final List<ContentItem>? content;
  final int version;

  KugouTranslation({
    this.content,
    this.version = 0,
  });

  factory KugouTranslation.fromJson(Map<String, dynamic> json) {
    return KugouTranslation(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => ContentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      version: json['version'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content?.map((e) => e.toJson()).toList(),
      'version': version,
    };
  }
}

class ContentItem {
  final int language;
  final int type;
  final List<List<String?>?>? lyricContent;

  ContentItem({
    this.language = 0,
    this.type = 0,
    this.lyricContent,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      language: json['language'] as int? ?? 0,
      type: json['type'] as int? ?? 0,
      lyricContent: (json['lyricContent'] as List<dynamic>?)?.map((e) {
        if (e is List) {
          return e.map((item) => item as String?).toList();
        }
        return <String?>[];
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'type': type,
      'lyricContent': lyricContent,
    };
  }
} 