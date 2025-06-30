import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

//-=-=-=-=-=-=-= EAPI Search Result Models =-=-=-=-=-=-=-

@JsonSerializable(createToJson: false)
class EapiSearchResult {
  final int code;
  final EapiSearchResultData? result;
  @JsonKey(name: 'needLogin')
  final bool? needLogin;

  EapiSearchResult({required this.code, this.result, this.needLogin});

  factory EapiSearchResult.fromJson(Map<String, dynamic> json) =>
      _$EapiSearchResultFromJson(json);
}

@JsonSerializable(createToJson: false)
class EapiSearchResultData {
  final List<EapiSong>? songs;

  EapiSearchResultData({this.songs});

  factory EapiSearchResultData.fromJson(Map<String, dynamic> json) =>
      _$EapiSearchResultDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class EapiSong {
  final String name;
  final int id;
  @JsonKey(name: 'ar')
  final List<Ar>? artists;
  @JsonKey(name: 'alia')
  final List<dynamic>? alias;
  @JsonKey(name: 'al')
  final Al? album;
  @JsonKey(name: 'dt')
  final int duration;
  final int? publishTime;
  final Privilege? privilege;

  EapiSong(
      {required this.name,
      required this.id,
      this.artists,
      this.alias,
      this.album,
      required this.duration,
      this.publishTime,
      this.privilege});

  factory EapiSong.fromJson(Map<String, dynamic> json) =>
      _$EapiSongFromJson(json);
}

@JsonSerializable(createToJson: false)
class Ar {
  // Artist
  final int id;
  final String name;

  Ar({required this.id, required this.name});

  factory Ar.fromJson(Map<String, dynamic> json) => _$ArFromJson(json);
}

@JsonSerializable(createToJson: false)
class Al {
  // Album
  final int id;
  final String name;
  final String? picUrl;

  Al({required this.id, required this.name, this.picUrl});

  factory Al.fromJson(Map<String, dynamic> json) => _$AlFromJson(json);
}

//-=-=-=-=-=-=-= Lyric Result Models =-=-=-=-=-=-=-

@JsonSerializable(createToJson: false)
class LyricResult {
  final int code;
  final bool? sgc;
  final bool? sfy;
  final bool? qfy;
  final bool? nolyric;
  final bool? uncollected;
  final LyricUser? transUser;
  final LyricUser? lyricUser;
  @JsonKey(name: 'lrc')
  final Lyrics? lrc;
  @JsonKey(name: 'klyric')
  final Lyrics? klyric;
  @JsonKey(name: 'tlyric')
  final Lyrics? tlyric;
  @JsonKey(name: 'romalrc')
  final Lyrics? romalrc;
  @JsonKey(name: 'yrc')
  final Lyrics? yrc;
  @JsonKey(name: 'ytlrc')
  final Lyrics? ytlrc;
  @JsonKey(name: 'yromalrc')
  final Lyrics? yromalrc;

  LyricResult(
      {required this.code,
      this.sgc,
      this.sfy,
      this.qfy,
      this.nolyric,
      this.uncollected,
      this.transUser,
      this.lyricUser,
      this.lrc,
      this.klyric,
      this.tlyric,
      this.romalrc,
      this.yrc,
      this.ytlrc,
      this.yromalrc});

  factory LyricResult.fromJson(Map<String, dynamic> json) =>
      _$LyricResultFromJson(json);
}

@JsonSerializable(createToJson: false)
class Lyrics {
  final int? version;
  final String? lyric;

  Lyrics({this.version, this.lyric});

  factory Lyrics.fromJson(Map<String, dynamic> json) => _$LyricsFromJson(json);
}

//-=-=-=-=-=-=-= Legacy Search Result Models =-=-=-=-=-=-=

@JsonSerializable(createToJson: false)
class SearchResult {
  @JsonKey(name: 'result')
  final SearchResultData? result;
  @JsonKey(name: 'code')
  final int code;
  @JsonKey(name: 'needLogin')
  final bool? needLogin;

  SearchResult({this.result, required this.code, this.needLogin});

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

@JsonSerializable(createToJson: false)
class SearchResultData {
  final List<Song>? songs;
  @JsonKey(name: 'songCount')
  final int? songCount;
  final List<AlbumMini>? albums;
  @JsonKey(name: 'albumCount')
  final int? albumCount;
  @JsonKey(name: 'playlists')
  final List<SimplePlaylist>? playlists;
  @JsonKey(name: 'playlistCount')
  final int? playlistCount;

  SearchResultData(
      {this.songs,
      this.songCount,
      this.albums,
      this.albumCount,
      this.playlists,
      this.playlistCount});

  factory SearchResultData.fromJson(Map<String, dynamic> json) =>
      _$SearchResultDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class Song {
  final String name;
  @JsonKey(name: 'id', fromJson: _dynamicToString)
  final String id;
  @JsonKey(name: 'ar')
  final List<ArtistMini>? artists;
  @JsonKey(name: 'alia')
  final List<dynamic>? alias;
  @JsonKey(name: 'al')
  final AlbumMini? album;
  @JsonKey(name: 'dt')
  final int? duration;
  final int? publishTime;
  final Privilege? privilege;

  Song(
      {required this.name,
      required this.id,
      this.artists,
      this.alias,
      this.album,
      this.duration,
      this.publishTime,
      this.privilege});

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
}

String _dynamicToString(dynamic value) => value?.toString() ?? '';

@JsonSerializable(createToJson: false)
class ArtistMini {
  final int id;
  final String name;

  ArtistMini({required this.id, required this.name});

  factory ArtistMini.fromJson(Map<String, dynamic> json) =>
      _$ArtistMiniFromJson(json);
}

@JsonSerializable(createToJson: false)
class AlbumMini {
  final int id;
  final String name;
  final String? picUrl;

  AlbumMini({required this.id, required this.name, this.picUrl});

  factory AlbumMini.fromJson(Map<String, dynamic> json) =>
      _$AlbumMiniFromJson(json);
}

@JsonSerializable(createToJson: false)
class SimplePlaylist {
  final String id;
  final String name;
  @JsonKey(name: 'coverImgUrl')
  final String? coverImgUrl;
  final int? trackCount;
  final int? userId;
  final Creator? creator;
  final String? description;
  final int? playCount;

  SimplePlaylist(
      {required this.id,
      required this.name,
      this.coverImgUrl,
      this.trackCount,
      this.userId,
      this.creator,
      this.description,
      this.playCount});

  factory SimplePlaylist.fromJson(Map<String, dynamic> json) =>
      _$SimplePlaylistFromJson(json);
}

//-=-=-=-=-=-=-= Album / Playlist Result Models (simplified) =-=-=-=-=-=-=

@JsonSerializable(createToJson: false)
class AlbumResult {
  final int code;
  final AlbumMini? album;
  final List<Song>? songs;

  AlbumResult({required this.code, this.album, this.songs});

  factory AlbumResult.fromJson(Map<String, dynamic> json) =>
      _$AlbumResultFromJson(json);
}

@JsonSerializable(createToJson: false)
class PlaylistResult {
  final int code;
  final String? urls;
  final String? relatedVideos;
  @JsonKey(name: 'playlist')
  final Playlist? playlist;
  final List<Privilege>? privileges;

  PlaylistResult(
      {required this.code,
      this.urls,
      this.relatedVideos,
      this.playlist,
      this.privileges});

  factory PlaylistResult.fromJson(Map<String, dynamic> json) =>
      _$PlaylistResultFromJson(json);
}

@JsonSerializable(createToJson: false)
class PlaylistDetail {
  final String id;
  final String name;
  @JsonKey(name: 'tracks')
  final List<Song>? tracks;
  @JsonKey(name: 'trackCount')
  final int? trackCount;

  PlaylistDetail(
      {required this.id, required this.name, this.tracks, this.trackCount});

  factory PlaylistDetail.fromJson(Map<String, dynamic> json) =>
      _$PlaylistDetailFromJson(json);
}

//-=-=-=-=-=-=-= Song URL & Detail Models =-=-=-=-=-=-=

@JsonSerializable(createToJson: false)
class SongUrls {
  final List<Datum>? data;
  final int code;

  SongUrls({this.data, required this.code});

  factory SongUrls.fromJson(Map<String, dynamic> json) =>
      _$SongUrlsFromJson(json);
}

@JsonSerializable(createToJson: false)
class Datum {
  @JsonKey(name: 'id', fromJson: _dynamicToString)
  final String id;
  final String? url;
  final int? br;
  final int? size;
  final String? md5;
  final int? code;
  final int? expi;
  final String? type;
  final double? gain;
  final int? fee;
  final dynamic uf;
  final int? payed;
  final int? flag;
  final bool? canExtend;

  Datum(
      {required this.id,
      this.url,
      this.br,
      this.size,
      this.md5,
      this.code,
      this.expi,
      this.type,
      this.gain,
      this.fee,
      this.uf,
      this.payed,
      this.flag,
      this.canExtend});

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}

@JsonSerializable(createToJson: false)
class DetailResult {
  final List<Song>? songs;
  final List<Privilege>? privileges;
  final int code;

  DetailResult({this.songs, this.privileges, required this.code});

  factory DetailResult.fromJson(Map<String, dynamic> json) =>
      _$DetailResultFromJson(json);
}

@JsonSerializable(createToJson: false)
class Privilege {
  @JsonKey(name: 'id', fromJson: _dynamicToString)
  final String id;
  final int? fee;
  final int? payed;
  final int? st;
  final int? pl;
  final int? dl;
  final int? sp;
  final int? cp;
  final int? subp;
  final bool? cs;
  final int? maxbr;
  final int? fl;
  final bool? toast;
  final int? flag;

  Privilege(
      {required this.id,
      this.fee,
      this.payed,
      this.st,
      this.pl,
      this.dl,
      this.sp,
      this.cp,
      this.subp,
      this.cs,
      this.maxbr,
      this.fl,
      this.toast,
      this.flag});

  factory Privilege.fromJson(Map<String, dynamic> json) =>
      _$PrivilegeFromJson(json);
}

// === New Classes Added for Full Mirror ===

@JsonSerializable(createToJson: false)
class LyricUser {
  final int? id;
  final int? status;
  final int? demand;
  @JsonKey(name: 'userid')
  final int? userId;
  final String? nickname;
  final int? uptime;

  LyricUser(
      {this.id,
      this.status,
      this.demand,
      this.userId,
      this.nickname,
      this.uptime});

  factory LyricUser.fromJson(Map<String, dynamic> json) =>
      _$LyricUserFromJson(json);
}

@JsonSerializable(createToJson: false)
class Creator {
  @JsonKey(name: 'userId')
  final int? userId;
  final String? nickname;
  final String? signature;
  final String? description;
  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;

  Creator(
      {this.userId,
      this.nickname,
      this.signature,
      this.description,
      this.avatarUrl});

  factory Creator.fromJson(Map<String, dynamic> json) =>
      _$CreatorFromJson(json);
}

@JsonSerializable(createToJson: false)
class ResourceInfo {
  final int? id;
  final int? userId;
  final String? name;
  final String? imgUrl;
  final Creator? creator;

  ResourceInfo({this.id, this.userId, this.name, this.imgUrl, this.creator});

  factory ResourceInfo.fromJson(Map<String, dynamic> json) =>
      _$ResourceInfoFromJson(json);
}

@JsonSerializable(createToJson: false)
class CommentThread {
  final String? id;
  final ResourceInfo? resourceInfo;
  final int? resourceType;
  final int? commentCount;
  final int? likedCount;
  final int? shareCount;
  final int? hotCount;
  final dynamic latestLikedUsers;
  final int? resourceId;
  final int? resourceOwnerId;
  final String? resourceTitle;

  CommentThread(
      {this.id,
      this.resourceInfo,
      this.resourceType,
      this.commentCount,
      this.likedCount,
      this.shareCount,
      this.hotCount,
      this.latestLikedUsers,
      this.resourceId,
      this.resourceOwnerId,
      this.resourceTitle});

  factory CommentThread.fromJson(Map<String, dynamic> json) =>
      _$CommentThreadFromJson(json);
}

@JsonSerializable(createToJson: false)
class Info {
  final CommentThread? commentThread;
  final dynamic latestLikedUsers;
  final bool? liked;
  final dynamic comments;
  final int? resourceType;
  final int? resourceId;
  final int? commentCount;
  final int? likedCount;
  final int? shareCount;
  final String? threadId;

  Info(
      {this.commentThread,
      this.latestLikedUsers,
      this.liked,
      this.comments,
      this.resourceType,
      this.resourceId,
      this.commentCount,
      this.likedCount,
      this.shareCount,
      this.threadId});

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
}

@JsonSerializable(createToJson: false)
class Artist {
  final int? img1V1Id;
  final int? topicPerson;
  final int? picId;
  final dynamic briefDesc;
  final int? albumSize;
  final String? img1V1Url;
  final String? picUrl;
  final List<String>? alias;
  final String? trans;
  final int? musicSize;
  final String? name;
  final int? id;
  final int? publishTime;
  final int? mvSize;
  final bool? followed;

  Artist(
      {this.img1V1Id,
      this.topicPerson,
      this.picId,
      this.briefDesc,
      this.albumSize,
      this.img1V1Url,
      this.picUrl,
      this.alias,
      this.trans,
      this.musicSize,
      this.name,
      this.id,
      this.publishTime,
      this.mvSize,
      this.followed});

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
}

@JsonSerializable(createToJson: false)
class Album {
  final bool? paid;
  final bool? onSale;
  final int? picId;
  final List<dynamic>? alias;
  final String? commentThreadId;
  final int? publishTime;
  final String? company;
  final int? copyrightId;
  final String? picUrl;
  final Artist? artist;
  final dynamic briefDesc;
  final String? tags;
  final List<Artist>? artists;
  final int? status;
  final String? description;
  final dynamic subType;
  final String? blurPicUrl;
  final int? companyId;
  final int? pic;
  final String? name;
  final int? id;
  final String? type;
  final int? size;
  final String? picIdStr;
  final Info? info;

  Album(
      {this.paid,
      this.onSale,
      this.picId,
      this.alias,
      this.commentThreadId,
      this.publishTime,
      this.company,
      this.copyrightId,
      this.picUrl,
      this.artist,
      this.briefDesc,
      this.tags,
      this.artists,
      this.status,
      this.description,
      this.subType,
      this.blurPicUrl,
      this.companyId,
      this.pic,
      this.name,
      this.id,
      this.type,
      this.size,
      this.picIdStr,
      this.info});

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
}

@JsonSerializable(createToJson: false)
class Playlist extends SimplePlaylist {
  final int? coverImgId;
  final int? createTime;
  final int? status;
  final int? subscribedCount;
  final int? shareCount;
  final int? commentCount;
  final List<String>? tags;
  final List<Song>? tracks;

  Playlist(
      {required String id,
      required String name,
      String? coverImgUrl,
      int? trackCount,
      int? userId,
      Creator? creator,
      String? description,
      int? playCount,
      this.coverImgId,
      this.createTime,
      this.status,
      this.subscribedCount,
      this.shareCount,
      this.commentCount,
      this.tags,
      this.tracks})
      : super(
            id: id,
            name: name,
            coverImgUrl: coverImgUrl,
            trackCount: trackCount,
            userId: userId,
            creator: creator,
            description: description,
            playCount: playCount);

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);
}
