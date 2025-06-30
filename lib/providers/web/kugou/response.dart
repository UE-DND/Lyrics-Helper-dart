import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable(createToJson: false)
class SearchSongResponse {
  @JsonKey(name: 'status')
  final int status;

  @JsonKey(name: 'error')
  final String? error;

  @JsonKey(name: 'data')
  final DataItem? data;

  @JsonKey(name: 'errcode')
  final int errorCode;

  SearchSongResponse({required this.status, this.error, this.data, required this.errorCode});

  factory SearchSongResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchSongResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class DataItem {
  @JsonKey(name: 'timestamp')
  final int timestamp;

  @JsonKey(name: 'total')
  final int total;

  @JsonKey(name: 'info')
  final List<InfoItem> info;

  DataItem({required this.timestamp, required this.total, required this.info});

  factory DataItem.fromJson(Map<String, dynamic> json) =>
      _$DataItemFromJson(json);
}

@JsonSerializable(createToJson: false)
class InfoItem {
  @JsonKey(name: 'hash')
  final String hash;

  @JsonKey(name: 'songname')
  final String songName;

  @JsonKey(name: 'album_name')
  final String? albumName;

  @JsonKey(name: 'songname_original')
  final String? songNameOriginal;

  @JsonKey(name: 'singername')
  final String singerName;

  @JsonKey(name: 'duration')
  final int duration;

  @JsonKey(name: 'filename')
  final String filename;

  @JsonKey(name: 'group')
  final List<InfoItem>? group;

  InfoItem({
    required this.hash,
    required this.songName,
    this.albumName,
    this.songNameOriginal,
    required this.singerName,
    required this.duration,
    required this.filename,
    this.group,
  });

  factory InfoItem.fromJson(Map<String, dynamic> json) =>
      _$InfoItemFromJson(json);
}


@JsonSerializable(createToJson: false)
class SearchLyricsResponse {
  @JsonKey(name: 'status')
  final int status;

  @JsonKey(name: 'info')
  final String? info;

  @JsonKey(name: 'errcode')
  final int errorCode;

  @JsonKey(name: 'errmsg')
  final String? errorMessage;

  @JsonKey(name: 'keywork')
  final String? keywork;

  @JsonKey(name: 'proposal')
  final String? proposal;

  @JsonKey(name: 'has_complete_right')
  final int? hasCompleteRight;

  @JsonKey(name: 'ugc')
  final int? ugc;

  @JsonKey(name: 'ugccount')
  final int? ugcCount;

  @JsonKey(name: 'expire')
  final int? expire;

  @JsonKey(name: 'candidates')
  final List<Candidate> candidates;

  SearchLyricsResponse({
    required this.status,
    this.info,
    required this.errorCode,
    this.errorMessage,
    this.keywork,
    this.proposal,
    this.hasCompleteRight,
    this.ugc,
    this.ugcCount,
    this.expire,
    required this.candidates,
  });

  factory SearchLyricsResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchLyricsResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class Candidate {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'product_from')
  final String? productFrom;

  @JsonKey(name: 'accesskey')
  final String? accessKey;

  @JsonKey(name: 'can_score')
  final bool? canScore;

  @JsonKey(name: 'singer')
  final String singer;

  @JsonKey(name: 'song')
  final String song;

  @JsonKey(name: 'duration')
  final int duration;

  @JsonKey(name: 'uid')
  final String? uid;

  @JsonKey(name: 'nickname')
  final String? nickname;

  @JsonKey(name: 'origiuid')
  final String? origiuid;

  @JsonKey(name: 'originame')
  final String? originame;

  @JsonKey(name: 'transuid')
  final String? transuid;

  @JsonKey(name: 'transname')
  final String? transname;

  @JsonKey(name: 'sounduid')
  final String? sounduid;

  @JsonKey(name: 'soundname')
  final String? soundname;

  @JsonKey(name: 'language')
  final String? language;

  @JsonKey(name: 'krctype')
  final int? krcType;

  @JsonKey(name: 'hitlayer')
  final int? hitlayer;

  @JsonKey(name: 'hitcasemask')
  final int? hitcasemask;

  @JsonKey(name: 'adjust')
  final int? adjust;

  @JsonKey(name: 'score')
  final int? score;

  @JsonKey(name: 'contenttype')
  final int? contentType;

  @JsonKey(name: 'content_format')
  final int? contentFormat;

  @JsonKey(name: 'trans_id')
  final String? transId;

  Candidate({
    required this.id,
    this.productFrom,
    this.accessKey,
    this.canScore,
    required this.singer,
    required this.song,
    required this.duration,
    this.uid,
    this.nickname,
    this.origiuid,
    this.originame,
    this.transuid,
    this.transname,
    this.sounduid,
    this.soundname,
    this.language,
    this.krcType,
    this.hitlayer,
    this.hitcasemask,
    this.adjust,
    this.score,
    this.contentType,
    this.contentFormat,
    this.transId,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) =>
      _$CandidateFromJson(json);
} 