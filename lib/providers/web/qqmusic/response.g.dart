// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Singer _$SingerFromJson(Map<String, dynamic> json) => Singer(
      id: (json['id'] as num).toInt(),
      mid: json['mid'] as String,
      name: json['name'] as String,
      title: json['title'] as String?,
      type: (json['type'] as num?)?.toInt(),
      pmid: json['pmid'] as String?,
    );

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      id: (json['id'] as num).toInt(),
      mid: json['mid'] as String,
      name: json['name'] as String,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      timePublic: json['time_public'] as String?,
      pmid: json['pmid'] as String?,
    );

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      album: json['album'] == null
          ? null
          : Album.fromJson(json['album'] as Map<String, dynamic>),
      id: json['id'] as String,
      interval: (json['interval'] as num).toInt(),
      mid: json['mid'] as String,
      name: json['name'] as String,
      desc: json['desc'] as String?,
      singer: (json['singer'] as List<dynamic>?)
          ?.map((e) => Singer.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      timePublic: json['time_public'] as String?,
      language: (json['language'] as num?)?.toInt(),
      genre: (json['genre'] as num?)?.toInt(),
    );

MusicFcgApiResult _$MusicFcgApiResultFromJson(Map<String, dynamic> json) =>
    MusicFcgApiResult(
      code: (json['code'] as num).toInt(),
      ts: (json['ts'] as num?)?.toInt(),
      startTs: (json['start_ts'] as num?)?.toInt(),
      traceid: json['traceid'] as String?,
      req: json['req'] == null
          ? null
          : MusicReq.fromJson(json['req'] as Map<String, dynamic>),
      req0: json['req_0'] == null
          ? null
          : MusicReq0.fromJson(json['req_0'] as Map<String, dynamic>),
      req1: json['req_1'] == null
          ? null
          : MusicFcgReq1.fromJson(json['req_1'] as Map<String, dynamic>),
    );

MusicFcgReq1 _$MusicFcgReq1FromJson(Map<String, dynamic> json) => MusicFcgReq1(
      code: (json['code'] as num).toInt(),
      data: json['data'] == null
          ? null
          : MusicFcgReq1Data.fromJson(json['data'] as Map<String, dynamic>),
    );

MusicFcgReq1Data _$MusicFcgReq1DataFromJson(Map<String, dynamic> json) =>
    MusicFcgReq1Data(
      body: json['body'] == null
          ? null
          : MusicFcgReq1DataBody.fromJson(json['body'] as Map<String, dynamic>),
    );

MusicFcgReq1DataBody _$MusicFcgReq1DataBodyFromJson(
        Map<String, dynamic> json) =>
    MusicFcgReq1DataBody(
      song: json['Song'] == null
          ? null
          : MusicFcgReq1DataBodySong.fromJson(
              json['Song'] as Map<String, dynamic>),
    );

MusicFcgReq1DataBodySong _$MusicFcgReq1DataBodySongFromJson(
        Map<String, dynamic> json) =>
    MusicFcgReq1DataBodySong(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

LyricResult _$LyricResultFromJson(Map<String, dynamic> json) => LyricResult(
      code: (json['code'] as num).toInt(),
      lyric: json['lyric'] as String?,
      trans: json['trans'] as String?,
    );

MusicFcgApiAlternativeResult _$MusicFcgApiAlternativeResultFromJson(
        Map<String, dynamic> json) =>
    MusicFcgApiAlternativeResult(
      code: (json['code'] as num?)?.toInt(),
      search: json['search'] == null
          ? null
          : _SearchCgiService.fromJson(json['search'] as Map<String, dynamic>),
    );

_SearchCgiService _$SearchCgiServiceFromJson(Map<String, dynamic> json) =>
    _SearchCgiService(
      data: json['data'] == null
          ? null
          : _SearchDataBody.fromJson(json['data'] as Map<String, dynamic>),
    );

_SearchDataBody _$SearchDataBodyFromJson(Map<String, dynamic> json) =>
    _SearchDataBody(
      body: json['body'] == null
          ? null
          : _SearchSongBody.fromJson(json['body'] as Map<String, dynamic>),
    );

_SearchSongBody _$SearchSongBodyFromJson(Map<String, dynamic> json) =>
    _SearchSongBody(
      song: json['Song'] == null
          ? null
          : _SearchSongList.fromJson(json['Song'] as Map<String, dynamic>),
    );

_SearchSongList _$SearchSongListFromJson(Map<String, dynamic> json) =>
    _SearchSongList(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

AlbumResult _$AlbumResultFromJson(Map<String, dynamic> json) => AlbumResult(
      code: (json['code'] as num).toInt(),
      data: json['data'] == null
          ? null
          : AlbumInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

AlbumInfo _$AlbumInfoFromJson(Map<String, dynamic> json) => AlbumInfo(
      aDate: json['ADate'] as String?,
      company: json['company'] as String?,
      desc: json['desc'] as String?,
      id: (json['id'] as num?)?.toInt(),
      mid: json['mid'] as String?,
      lan: json['lan'] as String?,
      name: json['name'] as String?,
      total: (json['total'] as num?)?.toInt(),
      singerid: (json['singerid'] as num?)?.toInt(),
      singermid: json['singermid'] as String?,
      singername: json['singername'] as String?,
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => AlbumSong.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

AlbumSong _$AlbumSongFromJson(Map<String, dynamic> json) => AlbumSong(
      singer: (json['singer'] as List<dynamic>?)
          ?.map((e) => Singer.fromJson(e as Map<String, dynamic>))
          .toList(),
      songid: (json['songid'] as num?)?.toInt(),
      songmid: json['songmid'] as String?,
      songname: json['songname'] as String?,
    );

PlaylistResult _$PlaylistResultFromJson(Map<String, dynamic> json) =>
    PlaylistResult(
      code: (json['code'] as num).toInt(),
      cdlist: (json['cdlist'] as List<dynamic>?)
          ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist(
      disstid: json['disstid'] as String?,
      dissname: json['dissname'] as String?,
      nickname: json['nickname'] as String?,
      logo: json['logo'] as String?,
      desc: json['desc'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      songnum: (json['songnum'] as num?)?.toInt(),
      songids: json['songids'] as String?,
      songList: (json['songlist'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      visitnum: (json['visitnum'] as num?)?.toInt(),
      ctime: (json['ctime'] as num?)?.toInt(),
    );

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      pid: (json['pid'] as num?)?.toInt(),
    );

SongResult _$SongResultFromJson(Map<String, dynamic> json) => SongResult(
      code: (json['code'] as num).toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ToplistResult _$ToplistResultFromJson(Map<String, dynamic> json) =>
    ToplistResult(
      code: (json['code'] as num).toInt(),
      ts: (json['ts'] as num?)?.toInt(),
      startTs: (json['start_ts'] as num?)?.toInt(),
      traceid: json['traceid'] as String?,
      detail: json['detail'] == null
          ? null
          : DetailData.fromJson(json['detail'] as Map<String, dynamic>),
    );

DetailData _$DetailDataFromJson(Map<String, dynamic> json) => DetailData(
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : ToplistData.fromJson(json['data'] as Map<String, dynamic>),
    );

ToplistData _$ToplistDataFromJson(Map<String, dynamic> json) => ToplistData(
      data: json['data'] == null
          ? null
          : ToplistInfo.fromJson(json['data'] as Map<String, dynamic>),
      songInfoList: json['songInfoList'] as List<dynamic>?,
    );

ToplistInfo _$ToplistInfoFromJson(Map<String, dynamic> json) => ToplistInfo(
      topId: (json['topId'] as num?)?.toInt(),
      title: json['title'] as String?,
      period: json['period'] as String?,
      updateTime: json['updateTime'] as String?,
      song: (json['song'] as List<dynamic>?)
          ?.map((e) => SongData.fromJson(e as Map<String, dynamic>))
          .toList(),
      history: json['history'] == null
          ? null
          : HistoryData.fromJson(json['history'] as Map<String, dynamic>),
    );

HistoryData _$HistoryDataFromJson(Map<String, dynamic> json) => HistoryData(
      year: json['year'] as List<dynamic>?,
      subPeriod: json['subPeriod'] as List<dynamic>?,
    );

SongData _$SongDataFromJson(Map<String, dynamic> json) => SongData(
      rank: (json['rank'] as num?)?.toInt(),
      songId: (json['songId'] as num?)?.toInt(),
      title: json['title'] as String?,
      singerName: json['singerName'] as String?,
      albumMid: json['albumMid'] as String?,
    );

MagicColor _$MagicColorFromJson(Map<String, dynamic> json) => MagicColor(
      r: (json['r'] as num?)?.toInt(),
      g: (json['g'] as num?)?.toInt(),
      b: (json['b'] as num?)?.toInt(),
    );

SingerSongResult _$SingerSongResultFromJson(Map<String, dynamic> json) =>
    SingerSongResult(
      code: (json['code'] as num).toInt(),
      ts: (json['ts'] as num?)?.toInt(),
      startTs: (json['start_ts'] as num?)?.toInt(),
      traceid: json['traceid'] as String?,
      singer: json['singer'] == null
          ? null
          : SingerData.fromJson(json['singer'] as Map<String, dynamic>),
    );

SingerData _$SingerDataFromJson(Map<String, dynamic> json) => SingerData(
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : SingerInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

SingerInfo _$SingerInfoFromJson(Map<String, dynamic> json) => SingerInfo(
      songlist: (json['songlist'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalSong: (json['total_song'] as num?)?.toInt(),
      singerBrief: json['singer_brief'] as String?,
    );

AlbumSongListResult _$AlbumSongListResultFromJson(Map<String, dynamic> json) =>
    AlbumSongListResult(
      code: (json['code'] as num).toInt(),
      ts: (json['ts'] as num?)?.toInt(),
      startTs: (json['start_ts'] as num?)?.toInt(),
      traceId: json['traceId'] as String?,
      albumSonglist: json['albumSonglist'] == null
          ? null
          : AlbumSonglistInfo.fromJson(
              json['albumSonglist'] as Map<String, dynamic>),
    );

AlbumSonglistInfo _$AlbumSonglistInfoFromJson(Map<String, dynamic> json) =>
    AlbumSonglistInfo(
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : DataInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

DataInfo _$DataInfoFromJson(Map<String, dynamic> json) => DataInfo(
      albumMid: json['albumMid'] as String?,
      totalNum: (json['totalNum'] as num?)?.toInt(),
      songList: (json['songList'] as List<dynamic>?)
          ?.map((e) => SongItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

SongItem _$SongItemFromJson(Map<String, dynamic> json) => SongItem(
      songInfo: json['songInfo'] == null
          ? null
          : Song.fromJson(json['songInfo'] as Map<String, dynamic>),
      listenCount: (json['listenCount'] as num?)?.toInt(),
    );

MusicReq _$MusicReqFromJson(Map<String, dynamic> json) => MusicReq(
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : MusicReqData.fromJson(json['data'] as Map<String, dynamic>),
    );

MusicReqData _$MusicReqDataFromJson(Map<String, dynamic> json) => MusicReqData(
      sip: (json['sip'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

MusicReq0 _$MusicReq0FromJson(Map<String, dynamic> json) => MusicReq0(
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : MusicReq0Data.fromJson(json['data'] as Map<String, dynamic>),
    );

MusicReq0Data _$MusicReq0DataFromJson(Map<String, dynamic> json) =>
    MusicReq0Data(
      sip: (json['sip'] as List<dynamic>?)?.map((e) => e as String).toList(),
      midurlinfo: (json['midurlinfo'] as List<dynamic>?)
          ?.map((e) => MidUrlInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

MidUrlInfo _$MidUrlInfoFromJson(Map<String, dynamic> json) => MidUrlInfo(
      songmid: json['songmid'] as String?,
      purl: json['purl'] as String?,
    );

FileInfoDto _$FileInfoDtoFromJson(Map<String, dynamic> json) => FileInfoDto(
      size128: (json['size_128mp3'] as num?)?.toInt(),
      size320: (json['size_320mp3'] as num?)?.toInt(),
      sizeFlac: (json['size_flac'] as num?)?.toInt(),
    );

PayDto _$PayDtoFromJson(Map<String, dynamic> json) => PayDto(
      payPlay: (json['pay_play'] as num?)?.toInt(),
      payDown: (json['pay_down'] as num?)?.toInt(),
    );

ActionDto _$ActionDtoFromJson(Map<String, dynamic> json) => ActionDto(
      switchVal: (json['switch'] as num?)?.toInt(),
      alert: (json['alert'] as num?)?.toInt(),
    );

KsongDto _$KsongDtoFromJson(Map<String, dynamic> json) => KsongDto(
      id: (json['id'] as num?)?.toInt(),
      mid: json['mid'] as String?,
    );

VolumeDto _$VolumeDtoFromJson(Map<String, dynamic> json) => VolumeDto(
      gain: (json['gain'] as num?)?.toDouble(),
      peak: (json['peak'] as num?)?.toDouble(),
    );

MvDto _$MvDtoFromJson(Map<String, dynamic> json) => MvDto(
      id: (json['id'] as num?)?.toInt(),
      vid: json['vid'] as String?,
    );
