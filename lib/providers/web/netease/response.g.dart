// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EapiSearchResult _$EapiSearchResultFromJson(Map<String, dynamic> json) =>
    EapiSearchResult(
      code: (json['code'] as num).toInt(),
      result: json['result'] == null
          ? null
          : EapiSearchResultData.fromJson(
              json['result'] as Map<String, dynamic>),
      needLogin: json['needLogin'] as bool?,
    );

EapiSearchResultData _$EapiSearchResultDataFromJson(
        Map<String, dynamic> json) =>
    EapiSearchResultData(
      songs: (json['songs'] as List<dynamic>?)
          ?.map((e) => EapiSong.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

EapiSong _$EapiSongFromJson(Map<String, dynamic> json) => EapiSong(
      name: json['name'] as String,
      id: (json['id'] as num).toInt(),
      artists: (json['ar'] as List<dynamic>?)
          ?.map((e) => Ar.fromJson(e as Map<String, dynamic>))
          .toList(),
      alias: json['alia'] as List<dynamic>?,
      album: json['al'] == null
          ? null
          : Al.fromJson(json['al'] as Map<String, dynamic>),
      duration: (json['dt'] as num).toInt(),
      publishTime: (json['publishTime'] as num?)?.toInt(),
      privilege: json['privilege'] == null
          ? null
          : Privilege.fromJson(json['privilege'] as Map<String, dynamic>),
    );

Ar _$ArFromJson(Map<String, dynamic> json) => Ar(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Al _$AlFromJson(Map<String, dynamic> json) => Al(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      picUrl: json['picUrl'] as String?,
    );

LyricResult _$LyricResultFromJson(Map<String, dynamic> json) => LyricResult(
      code: (json['code'] as num).toInt(),
      sgc: json['sgc'] as bool?,
      sfy: json['sfy'] as bool?,
      qfy: json['qfy'] as bool?,
      nolyric: json['nolyric'] as bool?,
      uncollected: json['uncollected'] as bool?,
      transUser: json['transUser'] == null
          ? null
          : LyricUser.fromJson(json['transUser'] as Map<String, dynamic>),
      lyricUser: json['lyricUser'] == null
          ? null
          : LyricUser.fromJson(json['lyricUser'] as Map<String, dynamic>),
      lrc: json['lrc'] == null
          ? null
          : Lyrics.fromJson(json['lrc'] as Map<String, dynamic>),
      klyric: json['klyric'] == null
          ? null
          : Lyrics.fromJson(json['klyric'] as Map<String, dynamic>),
      tlyric: json['tlyric'] == null
          ? null
          : Lyrics.fromJson(json['tlyric'] as Map<String, dynamic>),
      romalrc: json['romalrc'] == null
          ? null
          : Lyrics.fromJson(json['romalrc'] as Map<String, dynamic>),
      yrc: json['yrc'] == null
          ? null
          : Lyrics.fromJson(json['yrc'] as Map<String, dynamic>),
      ytlrc: json['ytlrc'] == null
          ? null
          : Lyrics.fromJson(json['ytlrc'] as Map<String, dynamic>),
      yromalrc: json['yromalrc'] == null
          ? null
          : Lyrics.fromJson(json['yromalrc'] as Map<String, dynamic>),
    );

Lyrics _$LyricsFromJson(Map<String, dynamic> json) => Lyrics(
      version: (json['version'] as num?)?.toInt(),
      lyric: json['lyric'] as String?,
    );

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
      result: json['result'] == null
          ? null
          : SearchResultData.fromJson(json['result'] as Map<String, dynamic>),
      code: (json['code'] as num).toInt(),
      needLogin: json['needLogin'] as bool?,
    );

SearchResultData _$SearchResultDataFromJson(Map<String, dynamic> json) =>
    SearchResultData(
      songs: (json['songs'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      songCount: (json['songCount'] as num?)?.toInt(),
      albums: (json['albums'] as List<dynamic>?)
          ?.map((e) => AlbumMini.fromJson(e as Map<String, dynamic>))
          .toList(),
      albumCount: (json['albumCount'] as num?)?.toInt(),
      playlists: (json['playlists'] as List<dynamic>?)
          ?.map((e) => SimplePlaylist.fromJson(e as Map<String, dynamic>))
          .toList(),
      playlistCount: (json['playlistCount'] as num?)?.toInt(),
    );

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      name: json['name'] as String,
      id: _dynamicToString(json['id']),
      artists: (json['ar'] as List<dynamic>?)
          ?.map((e) => ArtistMini.fromJson(e as Map<String, dynamic>))
          .toList(),
      alias: json['alia'] as List<dynamic>?,
      album: json['al'] == null
          ? null
          : AlbumMini.fromJson(json['al'] as Map<String, dynamic>),
      duration: (json['dt'] as num?)?.toInt(),
      publishTime: (json['publishTime'] as num?)?.toInt(),
      privilege: json['privilege'] == null
          ? null
          : Privilege.fromJson(json['privilege'] as Map<String, dynamic>),
    );

ArtistMini _$ArtistMiniFromJson(Map<String, dynamic> json) => ArtistMini(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

AlbumMini _$AlbumMiniFromJson(Map<String, dynamic> json) => AlbumMini(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      picUrl: json['picUrl'] as String?,
    );

SimplePlaylist _$SimplePlaylistFromJson(Map<String, dynamic> json) =>
    SimplePlaylist(
      id: json['id'] as String,
      name: json['name'] as String,
      coverImgUrl: json['coverImgUrl'] as String?,
      trackCount: (json['trackCount'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      creator: json['creator'] == null
          ? null
          : Creator.fromJson(json['creator'] as Map<String, dynamic>),
      description: json['description'] as String?,
      playCount: (json['playCount'] as num?)?.toInt(),
    );

AlbumResult _$AlbumResultFromJson(Map<String, dynamic> json) => AlbumResult(
      code: (json['code'] as num).toInt(),
      album: json['album'] == null
          ? null
          : AlbumMini.fromJson(json['album'] as Map<String, dynamic>),
      songs: (json['songs'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

PlaylistResult _$PlaylistResultFromJson(Map<String, dynamic> json) =>
    PlaylistResult(
      code: (json['code'] as num).toInt(),
      urls: json['urls'] as String?,
      relatedVideos: json['relatedVideos'] as String?,
      playlist: json['playlist'] == null
          ? null
          : Playlist.fromJson(json['playlist'] as Map<String, dynamic>),
      privileges: (json['privileges'] as List<dynamic>?)
          ?.map((e) => Privilege.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

PlaylistDetail _$PlaylistDetailFromJson(Map<String, dynamic> json) =>
    PlaylistDetail(
      id: json['id'] as String,
      name: json['name'] as String,
      tracks: (json['tracks'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      trackCount: (json['trackCount'] as num?)?.toInt(),
    );

SongUrls _$SongUrlsFromJson(Map<String, dynamic> json) => SongUrls(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: (json['code'] as num).toInt(),
    );

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: _dynamicToString(json['id']),
      url: json['url'] as String?,
      br: (json['br'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      md5: json['md5'] as String?,
      code: (json['code'] as num?)?.toInt(),
      expi: (json['expi'] as num?)?.toInt(),
      type: json['type'] as String?,
      gain: (json['gain'] as num?)?.toDouble(),
      fee: (json['fee'] as num?)?.toInt(),
      uf: json['uf'],
      payed: (json['payed'] as num?)?.toInt(),
      flag: (json['flag'] as num?)?.toInt(),
      canExtend: json['canExtend'] as bool?,
    );

DetailResult _$DetailResultFromJson(Map<String, dynamic> json) => DetailResult(
      songs: (json['songs'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      privileges: (json['privileges'] as List<dynamic>?)
          ?.map((e) => Privilege.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: (json['code'] as num).toInt(),
    );

Privilege _$PrivilegeFromJson(Map<String, dynamic> json) => Privilege(
      id: _dynamicToString(json['id']),
      fee: (json['fee'] as num?)?.toInt(),
      payed: (json['payed'] as num?)?.toInt(),
      st: (json['st'] as num?)?.toInt(),
      pl: (json['pl'] as num?)?.toInt(),
      dl: (json['dl'] as num?)?.toInt(),
      sp: (json['sp'] as num?)?.toInt(),
      cp: (json['cp'] as num?)?.toInt(),
      subp: (json['subp'] as num?)?.toInt(),
      cs: json['cs'] as bool?,
      maxbr: (json['maxbr'] as num?)?.toInt(),
      fl: (json['fl'] as num?)?.toInt(),
      toast: json['toast'] as bool?,
      flag: (json['flag'] as num?)?.toInt(),
    );

LyricUser _$LyricUserFromJson(Map<String, dynamic> json) => LyricUser(
      id: (json['id'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      demand: (json['demand'] as num?)?.toInt(),
      userId: (json['userid'] as num?)?.toInt(),
      nickname: json['nickname'] as String?,
      uptime: (json['uptime'] as num?)?.toInt(),
    );

Creator _$CreatorFromJson(Map<String, dynamic> json) => Creator(
      userId: (json['userId'] as num?)?.toInt(),
      nickname: json['nickname'] as String?,
      signature: json['signature'] as String?,
      description: json['description'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

ResourceInfo _$ResourceInfoFromJson(Map<String, dynamic> json) => ResourceInfo(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      name: json['name'] as String?,
      imgUrl: json['imgUrl'] as String?,
      creator: json['creator'] == null
          ? null
          : Creator.fromJson(json['creator'] as Map<String, dynamic>),
    );

CommentThread _$CommentThreadFromJson(Map<String, dynamic> json) =>
    CommentThread(
      id: json['id'] as String?,
      resourceInfo: json['resourceInfo'] == null
          ? null
          : ResourceInfo.fromJson(json['resourceInfo'] as Map<String, dynamic>),
      resourceType: (json['resourceType'] as num?)?.toInt(),
      commentCount: (json['commentCount'] as num?)?.toInt(),
      likedCount: (json['likedCount'] as num?)?.toInt(),
      shareCount: (json['shareCount'] as num?)?.toInt(),
      hotCount: (json['hotCount'] as num?)?.toInt(),
      latestLikedUsers: json['latestLikedUsers'],
      resourceId: (json['resourceId'] as num?)?.toInt(),
      resourceOwnerId: (json['resourceOwnerId'] as num?)?.toInt(),
      resourceTitle: json['resourceTitle'] as String?,
    );

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      commentThread: json['commentThread'] == null
          ? null
          : CommentThread.fromJson(
              json['commentThread'] as Map<String, dynamic>),
      latestLikedUsers: json['latestLikedUsers'],
      liked: json['liked'] as bool?,
      comments: json['comments'],
      resourceType: (json['resourceType'] as num?)?.toInt(),
      resourceId: (json['resourceId'] as num?)?.toInt(),
      commentCount: (json['commentCount'] as num?)?.toInt(),
      likedCount: (json['likedCount'] as num?)?.toInt(),
      shareCount: (json['shareCount'] as num?)?.toInt(),
      threadId: json['threadId'] as String?,
    );

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist(
      img1V1Id: (json['img1V1Id'] as num?)?.toInt(),
      topicPerson: (json['topicPerson'] as num?)?.toInt(),
      picId: (json['picId'] as num?)?.toInt(),
      briefDesc: json['briefDesc'],
      albumSize: (json['albumSize'] as num?)?.toInt(),
      img1V1Url: json['img1V1Url'] as String?,
      picUrl: json['picUrl'] as String?,
      alias:
          (json['alias'] as List<dynamic>?)?.map((e) => e as String).toList(),
      trans: json['trans'] as String?,
      musicSize: (json['musicSize'] as num?)?.toInt(),
      name: json['name'] as String?,
      id: (json['id'] as num?)?.toInt(),
      publishTime: (json['publishTime'] as num?)?.toInt(),
      mvSize: (json['mvSize'] as num?)?.toInt(),
      followed: json['followed'] as bool?,
    );

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      paid: json['paid'] as bool?,
      onSale: json['onSale'] as bool?,
      picId: (json['picId'] as num?)?.toInt(),
      alias: json['alias'] as List<dynamic>?,
      commentThreadId: json['commentThreadId'] as String?,
      publishTime: (json['publishTime'] as num?)?.toInt(),
      company: json['company'] as String?,
      copyrightId: (json['copyrightId'] as num?)?.toInt(),
      picUrl: json['picUrl'] as String?,
      artist: json['artist'] == null
          ? null
          : Artist.fromJson(json['artist'] as Map<String, dynamic>),
      briefDesc: json['briefDesc'],
      tags: json['tags'] as String?,
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: (json['status'] as num?)?.toInt(),
      description: json['description'] as String?,
      subType: json['subType'],
      blurPicUrl: json['blurPicUrl'] as String?,
      companyId: (json['companyId'] as num?)?.toInt(),
      pic: (json['pic'] as num?)?.toInt(),
      name: json['name'] as String?,
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      size: (json['size'] as num?)?.toInt(),
      picIdStr: json['picIdStr'] as String?,
      info: json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>),
    );

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist(
      id: json['id'] as String,
      name: json['name'] as String,
      coverImgUrl: json['coverImgUrl'] as String?,
      trackCount: (json['trackCount'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      creator: json['creator'] == null
          ? null
          : Creator.fromJson(json['creator'] as Map<String, dynamic>),
      description: json['description'] as String?,
      playCount: (json['playCount'] as num?)?.toInt(),
      coverImgId: (json['coverImgId'] as num?)?.toInt(),
      createTime: (json['createTime'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      subscribedCount: (json['subscribedCount'] as num?)?.toInt(),
      shareCount: (json['shareCount'] as num?)?.toInt(),
      commentCount: (json['commentCount'] as num?)?.toInt(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tracks: (json['tracks'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
