import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

//-=-=-=-=-=-=-= COMMOM MODELS =-=-=-=-=-=-=-

@JsonSerializable(createToJson: false)
class Singer {
  final int id;
  final String mid;
  final String name;
  final String? title;
  final int? type;
  final String? pmid;

  Singer(
      {required this.id,
      required this.mid,
      required this.name,
      this.title,
      this.type,
      this.pmid});

  factory Singer.fromJson(Map<String, dynamic> json) => _$SingerFromJson(json);
}

@JsonSerializable(createToJson: false)
class Album {
  final int id;
  final String mid;
  final String name;
  final String? title;
  final String? subtitle;
  @JsonKey(name: 'time_public')
  final String? timePublic;
  final String? pmid;

  Album(
      {required this.id,
      required this.mid,
      required this.name,
      this.title,
      this.subtitle,
      this.timePublic,
      this.pmid});

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
}

@JsonSerializable(createToJson: false)
class Song {
  final Album? album;
  final String id;
  final int interval;
  final String mid;
  final String name;
  final String? desc;
  final List<Singer>? singer;
  final String? title;
  final String? subtitle;
  @JsonKey(name: 'time_public')
  final String? timePublic;
  final int? language;
  final int? genre;

  Song(
      {this.album,
      required this.id,
      required this.interval,
      required this.mid,
      required this.name,
      this.desc,
      this.singer,
      this.title,
      this.subtitle,
      this.timePublic,
      this.language,
      this.genre});

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
}

//-=-=-=-=-=-=-= MusicFcgApiResult (Search) =-=-=-=-=-=-=-

@JsonSerializable(createToJson: false)
class MusicFcgApiResult {
  final int code;
  final int? ts;
  @JsonKey(name: 'start_ts')
  final int? startTs;
  final String? traceid;
  final MusicReq? req;
  @JsonKey(name: 'req_0')
  final MusicReq0? req0;
  @JsonKey(name: 'req_1')
  final MusicFcgReq1? req1;

  MusicFcgApiResult(
      {required this.code,
      this.ts,
      this.startTs,
      this.traceid,
      this.req,
      this.req0,
      this.req1});

  factory MusicFcgApiResult.fromJson(Map<String, dynamic> json) =>
      _$MusicFcgApiResultFromJson(json);
}

@JsonSerializable(createToJson: false)
class MusicFcgReq1 {
  final int code;
  final MusicFcgReq1Data? data;

  MusicFcgReq1({required this.code, this.data});

  factory MusicFcgReq1.fromJson(Map<String, dynamic> json) =>
      _$MusicFcgReq1FromJson(json);
}

@JsonSerializable(createToJson: false)
class MusicFcgReq1Data {
  final MusicFcgReq1DataBody? body;

  MusicFcgReq1Data({this.body});

  factory MusicFcgReq1Data.fromJson(Map<String, dynamic> json) =>
      _$MusicFcgReq1DataFromJson(json);
}

@JsonSerializable(createToJson: false)
class MusicFcgReq1DataBody {
  @JsonKey(name: 'Song')
  final MusicFcgReq1DataBodySong? song;

  MusicFcgReq1DataBody({this.song});

  factory MusicFcgReq1DataBody.fromJson(Map<String, dynamic> json) =>
      _$MusicFcgReq1DataBodyFromJson(json);
}

@JsonSerializable(createToJson: false)
class MusicFcgReq1DataBodySong {
  @JsonKey(name: 'list')
  final List<Song>? list;

  MusicFcgReq1DataBodySong({this.list});

  factory MusicFcgReq1DataBodySong.fromJson(Map<String, dynamic> json) =>
      _$MusicFcgReq1DataBodySongFromJson(json);
}

//-=-=-=-=-=-=-= LyricResult =-=-=-=-=-=-=-

@JsonSerializable(createToJson: false)
class LyricResult {
  final int code;
  final String? lyric;
  final String? trans;

  LyricResult({required this.code, this.lyric, this.trans});

  factory LyricResult.fromJson(Map<String, dynamic> json) =>
      _$LyricResultFromJson(json);
}

// === Additional models for mirror completeness (minimal stubs; to be fully expanded later) ===

@JsonSerializable(createToJson: false)
class MusicFcgApiAlternativeResult {
  final int? code;
  final _SearchCgiService? search;
  MusicFcgApiAlternativeResult({this.code, this.search});
  factory MusicFcgApiAlternativeResult.fromJson(Map<String, dynamic> json) =>
      MusicFcgApiAlternativeResult(
        code: json['code'] as int?,
        search: json['music.search.SearchCgiService'] != null
            ? _SearchCgiService.fromJson(json['music.search.SearchCgiService'])
            : null,
      );
}

@JsonSerializable(createToJson: false)
class _SearchCgiService {
  final _SearchDataBody? data;
  _SearchCgiService({this.data});
  factory _SearchCgiService.fromJson(Map<String, dynamic> json) =>
      _SearchCgiService(
        data: json['data'] != null
            ? _SearchDataBody.fromJson(json['data'])
            : null,
      );
}

@JsonSerializable(createToJson: false)
class _SearchDataBody {
  final _SearchSongBody? body;
  _SearchDataBody({this.body});
  factory _SearchDataBody.fromJson(Map<String, dynamic> json) =>
      _SearchDataBody(
        body: json['body'] != null
            ? _SearchSongBody.fromJson(json['body'])
            : null,
      );
}

@JsonSerializable(createToJson: false)
class _SearchSongBody {
  @JsonKey(name: 'Song')
  final _SearchSongList? song;
  _SearchSongBody({this.song});
  factory _SearchSongBody.fromJson(Map<String, dynamic> json) =>
      _SearchSongBody(
        song: json['Song'] != null
            ? _SearchSongList.fromJson(json['Song'])
            : null,
      );
}

@JsonSerializable(createToJson: false)
class _SearchSongList {
  final List<Song>? list;
  _SearchSongList({this.list});
  factory _SearchSongList.fromJson(Map<String, dynamic> json) =>
      _SearchSongList(
        list: (json['list'] as List?)?.map((e) => Song.fromJson(e)).toList(),
      );
}

// ----------------  Mirror-complete models  ----------------

@JsonSerializable(createToJson: false)
class AlbumResult {
  final int code;
  final AlbumInfo? data;

  AlbumResult({required this.code, this.data});

  factory AlbumResult.fromJson(Map<String, dynamic> json) =>
      _$AlbumResultFromJson(json);
}

@JsonSerializable(createToJson: false)
class AlbumInfo {
  @JsonKey(name: 'ADate')
  final String? aDate;
  final String? company;
  final String? desc;
  final int? id;
  final String? mid;
  final String? lan;
  final String? name;
  final int? total;
  final int? singerid;
  final String? singermid;
  final String? singername;
  final List<AlbumSong>? list;

  AlbumInfo(
      {this.aDate,
      this.company,
      this.desc,
      this.id,
      this.mid,
      this.lan,
      this.name,
      this.total,
      this.singerid,
      this.singermid,
      this.singername,
      this.list});

  factory AlbumInfo.fromJson(Map<String, dynamic> json) =>
      _$AlbumInfoFromJson(json);
}

@JsonSerializable(createToJson: false)
class AlbumSong {
  final List<Singer>? singer;
  final int? songid;
  final String? songmid;
  final String? songname;

  AlbumSong({this.singer, this.songid, this.songmid, this.songname});

  factory AlbumSong.fromJson(Map<String, dynamic> json) =>
      _$AlbumSongFromJson(json);
}

@JsonSerializable(createToJson: false)
class PlaylistResult {
  final int code;
  @JsonKey(name: 'cdlist')
  final List<Playlist>? cdlist;

  PlaylistResult({required this.code, this.cdlist});

  factory PlaylistResult.fromJson(Map<String, dynamic> json) =>
      _$PlaylistResultFromJson(json);
}

@JsonSerializable(createToJson: false)
class Playlist {
  final String? disstid;
  final String? dissname;
  final String? nickname;
  final String? logo;
  final String? desc;
  final List<Tag>? tags;
  final int? songnum;
  final String? songids;
  @JsonKey(name: 'songlist')
  final List<Song>? songList;
  final int? visitnum;
  @JsonKey(name: 'ctime')
  final int? ctime;

  Playlist(
      {this.disstid,
      this.dissname,
      this.nickname,
      this.logo,
      this.desc,
      this.tags,
      this.songnum,
      this.songids,
      this.songList,
      this.visitnum,
      this.ctime});

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);
}

@JsonSerializable(createToJson: false)
class Tag {
  final int? id;
  final String? name;
  final int? pid;

  Tag({this.id, this.name, this.pid});

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

@JsonSerializable(createToJson: false)
class SongResult {
  final int code;
  final List<Song>? data;

  SongResult({required this.code, this.data});

  factory SongResult.fromJson(Map<String, dynamic> json) =>
      _$SongResultFromJson(json);

  bool get isIllegal => code != 0 || (data?.isEmpty ?? true);
}

class QqLyricsResponse {
  String? lyrics;
  String? trans;
  QqLyricsResponse({this.lyrics, this.trans});
  factory QqLyricsResponse.fromJson(Map<String, dynamic> json) =>
      QqLyricsResponse(
        lyrics: json['lyrics'] as String?,
        trans: json['trans'] as String?,
      );
}

// ---- remaining simple stubs to satisfy API references ----

@JsonSerializable(createToJson: false)
class ToplistResult {
  final int code;
  final int? ts;
  @JsonKey(name: 'start_ts')
  final int? startTs;
  final String? traceid;
  final DetailData? detail;

  ToplistResult(
      {required this.code, this.ts, this.startTs, this.traceid, this.detail});

  factory ToplistResult.fromJson(Map<String, dynamic> json) =>
      _$ToplistResultFromJson(json);
}

@JsonSerializable(createToJson: false)
class DetailData {
  final int? code;
  final ToplistData? data;
  DetailData({this.code, this.data});
  factory DetailData.fromJson(Map<String, dynamic> json) =>
      _$DetailDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class ToplistData {
  final ToplistInfo? data;
  @JsonKey(name: 'songInfoList')
  final List<dynamic>? songInfoList;
  ToplistData({this.data, this.songInfoList});
  factory ToplistData.fromJson(Map<String, dynamic> json) =>
      _$ToplistDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class ToplistInfo {
  @JsonKey(name: 'topId')
  final int? topId;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'period')
  final String? period;
  @JsonKey(name: 'updateTime')
  final String? updateTime;
  @JsonKey(name: 'song')
  final List<SongData>? song;
  @JsonKey(name: 'history')
  final HistoryData? history;
  ToplistInfo(
      {this.topId,
      this.title,
      this.period,
      this.updateTime,
      this.song,
      this.history});
  factory ToplistInfo.fromJson(Map<String, dynamic> json) =>
      _$ToplistInfoFromJson(json);
}

@JsonSerializable(createToJson: false)
class HistoryData {
  final List<dynamic>? year;
  @JsonKey(name: 'subPeriod')
  final List<dynamic>? subPeriod;
  HistoryData({this.year, this.subPeriod});
  factory HistoryData.fromJson(Map<String, dynamic> json) =>
      _$HistoryDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class SongData {
  final int? rank;
  @JsonKey(name: 'songId')
  final int? songId;
  final String? title;
  @JsonKey(name: 'singerName')
  final String? singerName;
  @JsonKey(name: 'albumMid')
  final String? albumMid;
  SongData(
      {this.rank, this.songId, this.title, this.singerName, this.albumMid});
  factory SongData.fromJson(Map<String, dynamic> json) =>
      _$SongDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class MagicColor {
  final int? r;
  final int? g;
  final int? b;
  MagicColor({this.r, this.g, this.b});
  factory MagicColor.fromJson(Map<String, dynamic> json) =>
      _$MagicColorFromJson(json);
}

@JsonSerializable(createToJson: false)
class SingerSongResult {
  final int code;
  final int? ts;
  @JsonKey(name: 'start_ts')
  final int? startTs;
  final String? traceid;
  final SingerData? singer;
  SingerSongResult(
      {required this.code, this.ts, this.startTs, this.traceid, this.singer});
  factory SingerSongResult.fromJson(Map<String, dynamic> json) =>
      _$SingerSongResultFromJson(json);
}

@JsonSerializable(createToJson: false)
class SingerData {
  final int? code;
  final SingerInfo? data;
  SingerData({this.code, this.data});
  factory SingerData.fromJson(Map<String, dynamic> json) =>
      _$SingerDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class SingerInfo {
  @JsonKey(name: 'songlist')
  final List<Song>? songlist;
  @JsonKey(name: 'total_song')
  final int? totalSong;
  @JsonKey(name: 'singer_brief')
  final String? singerBrief;
  SingerInfo({this.songlist, this.totalSong, this.singerBrief});
  factory SingerInfo.fromJson(Map<String, dynamic> json) =>
      _$SingerInfoFromJson(json);
}

@JsonSerializable(createToJson: false)
class AlbumSongListResult {
  final int code;
  final int? ts;
  @JsonKey(name: 'start_ts')
  final int? startTs;
  @JsonKey(name: 'traceId')
  final String? traceId;
  final AlbumSonglistInfo? albumSonglist;
  AlbumSongListResult(
      {required this.code,
      this.ts,
      this.startTs,
      this.traceId,
      this.albumSonglist});
  factory AlbumSongListResult.fromJson(Map<String, dynamic> json) =>
      _$AlbumSongListResultFromJson(json);
}

@JsonSerializable(createToJson: false)
class AlbumSonglistInfo {
  final int? code;
  final DataInfo? data;
  AlbumSonglistInfo({this.code, this.data});
  factory AlbumSonglistInfo.fromJson(Map<String, dynamic> json) =>
      _$AlbumSonglistInfoFromJson(json);
}

@JsonSerializable(createToJson: false)
class DataInfo {
  @JsonKey(name: 'albumMid')
  final String? albumMid;
  @JsonKey(name: 'totalNum')
  final int? totalNum;
  @JsonKey(name: 'songList')
  final List<SongItem>? songList;
  DataInfo({this.albumMid, this.totalNum, this.songList});
  factory DataInfo.fromJson(Map<String, dynamic> json) =>
      _$DataInfoFromJson(json);
}

@JsonSerializable(createToJson: false)
class SongItem {
  @JsonKey(name: 'songInfo')
  final Song? songInfo;
  @JsonKey(name: 'listenCount')
  final int? listenCount;
  SongItem({this.songInfo, this.listenCount});
  factory SongItem.fromJson(Map<String, dynamic> json) =>
      _$SongItemFromJson(json);
}

// ========== Deep mirror models ========== //

// --- MusicFcgApiResult (for song link etc.) ---

@JsonSerializable(createToJson: false)
class MusicReq {
  final int? code;
  final MusicReqData? data;
  MusicReq({this.code, this.data});
  factory MusicReq.fromJson(Map<String, dynamic> json) =>
      _$MusicReqFromJson(json);
}

@JsonSerializable(createToJson: false)
class MusicReqData {
  final List<String>? sip;
  MusicReqData({this.sip});
  factory MusicReqData.fromJson(Map<String, dynamic> json) =>
      _$MusicReqDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class MusicReq0 {
  final int? code;
  final MusicReq0Data? data;
  MusicReq0({this.code, this.data});
  factory MusicReq0.fromJson(Map<String, dynamic> json) =>
      _$MusicReq0FromJson(json);
}

@JsonSerializable(createToJson: false)
class MusicReq0Data {
  final List<String>? sip;
  final List<MidUrlInfo>? midurlinfo;
  MusicReq0Data({this.sip, this.midurlinfo});
  factory MusicReq0Data.fromJson(Map<String, dynamic> json) =>
      _$MusicReq0DataFromJson(json);
}

@JsonSerializable(createToJson: false)
class MidUrlInfo {
  final String? songmid;
  final String? purl;
  MidUrlInfo({this.songmid, this.purl});
  factory MidUrlInfo.fromJson(Map<String, dynamic> json) =>
      _$MidUrlInfoFromJson(json);
}

// MusicFcgReq1 已在上方定义 (MusicFcgReq1, MusicFcgReq1Data etc.)

// --- FileInfo / Pay / etc. common DTOs ---

@JsonSerializable(createToJson: false)
class FileInfoDto {
  @JsonKey(name: 'size_128mp3')
  final int? size128;
  @JsonKey(name: 'size_320mp3')
  final int? size320;
  @JsonKey(name: 'size_flac')
  final int? sizeFlac;
  FileInfoDto({this.size128, this.size320, this.sizeFlac});
  factory FileInfoDto.fromJson(Map<String, dynamic> json) =>
      _$FileInfoDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class PayDto {
  @JsonKey(name: 'pay_play')
  final int? payPlay;
  @JsonKey(name: 'pay_down')
  final int? payDown;
  PayDto({this.payPlay, this.payDown});
  factory PayDto.fromJson(Map<String, dynamic> json) => _$PayDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class ActionDto {
  @JsonKey(name: 'switch')
  final int? switchVal;
  final int? alert;
  ActionDto({this.switchVal, this.alert});
  factory ActionDto.fromJson(Map<String, dynamic> json) =>
      _$ActionDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class KsongDto {
  final int? id;
  final String? mid;
  KsongDto({this.id, this.mid});
  factory KsongDto.fromJson(Map<String, dynamic> json) =>
      _$KsongDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class VolumeDto {
  final double? gain;
  final double? peak;
  VolumeDto({this.gain, this.peak});
  factory VolumeDto.fromJson(Map<String, dynamic> json) =>
      _$VolumeDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class MvDto {
  final int? id;
  final String? vid;
  MvDto({this.id, this.vid});
  factory MvDto.fromJson(Map<String, dynamic> json) => _$MvDtoFromJson(json);
}
