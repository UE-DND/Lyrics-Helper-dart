import 'dart:convert';
import 'dart:math';

import 'package:lyricify_lyrics_helper/decrypter/qrc/decrypter.dart' as qrc;
import '../base_api.dart';
import 'response.dart';
import 'package:lyricify_lyrics_helper/decrypter/qrc/xml_utils.dart';
import 'package:xml/xml.dart';

class Api extends BaseApi {
  @override
  String? get httpRefer => "https://c.y.qq.com/";

  @override
  Map<String, String>? get additionalHeaders => null;

  // XML 节点映射，用于歌词下载接口解析
  static const Map<String, String> _verbatimXmlMappingDict = {
    "content": "orig", // 原文
    "contentts": "ts", // 译文
    "contentroma": "roma", // 罗马音
    "Lyric_1": "lyric", // 解压后的内容
  };

  Future<MusicFcgApiResult?> search(
      String keyword, SearchTypeEnum searchType) async {
    int type;
    switch (searchType) {
      case SearchTypeEnum.SONG_ID:
        type = 0;
        break;
      case SearchTypeEnum.ALBUM_ID:
        type = 2;
        break;
      case SearchTypeEnum.PLAYLIST_ID:
        type = 3;
        break;
    }
    var data = {
      "req_1": {
        "method": "DoSearchForQQMusicDesktop",
        "module": "music.search.SearchCgiService",
        "param": {
          "num_per_page": 20,
          "page_num": 1,
          "query": keyword,
          "search_type": type,
        }
      }
    };

    var resp = await postJsonAsync("https://u.y.qq.com/cgi-bin/musicu.fcg",
        body: data);
    return MusicFcgApiResult.fromJson(jsonDecode(resp));
  }

  Future<LyricResult?> getLyric(String songMid) async {
    var currentMillis = DateTime.now().millisecondsSinceEpoch;

    const callBack = "MusicJsonCallback_lrc";

    var url = "https://c.y.qq.com/lyric/fcgi-bin/fcg_query_lyric_new.fcg?"
        "callback=$callBack&"
        "pcachetime=$currentMillis&"
        "songmid=$songMid&"
        "g_tk=5381&"
        "jsonpCallback=$callBack&"
        "loginUin=0&"
        "hostUin=0&"
        "format=jsonp&"
        "inCharset=utf8&"
        "outCharset=utf8&"
        "notice=0&"
        "platform=yqq&"
        "needNewCode=0";

    var resp = await getAsync(url);
    final jsonString = _resolveRespJson(callBack, resp);
    var lyricResult = LyricResult.fromJson(jsonDecode(jsonString));

    if (lyricResult.lyric != null) {
      lyricResult = LyricResult(
        code: lyricResult.code,
        lyric: qrc.QrcDecrypter.decryptLyrics(lyricResult.lyric!),
        trans: lyricResult.trans != null
            ? qrc.QrcDecrypter.decryptLyrics(lyricResult.trans!)
            : null,
      );
    }
    return lyricResult;
  }

  String _resolveRespJson(String callBackSign, String val) {
    if (val.trim().isEmpty) return "";
    var json = val;
    if (json.startsWith(callBackSign)) {
      json = json.substring(callBackSign.length);
      if (json.startsWith("(") && json.endsWith(")")) {
        json = json.substring(1, json.length - 1);
      }
    }
    return json;
  }

  // === 新增：搜索（备用接口） ===
  Future<MusicFcgApiAlternativeResult?> searchAlternative(
      String keyword) async {
    final data = {
      "music.search.SearchCgiService": {
        "method": "DoSearchForQQMusicDesktop",
        "module": "music.search.SearchCgiService",
        "param": {
          "num_per_page": 10,
          "page_num": 1,
          "query": keyword,
          "search_type": 0
        }
      }
    };
    final resp = await postJsonAsync("https://u.y.qq.com/cgi-bin/musicu.fcg",
        body: data);
    return MusicFcgApiAlternativeResult.fromJson(jsonDecode(resp));
  }

  // === 专辑信息 ===
  Future<AlbumResult?> getAlbum(String albumMid) async {
    final data = {"albummid": albumMid};
    final resp = await postAsync(
        "https://c.y.qq.com/v8/fcg-bin/fcg_v8_album_info_cp.fcg",
        body: data);
    return AlbumResult.fromJson(jsonDecode(resp));
  }

  // 专辑歌曲列表
  Future<AlbumSongListResult?> getAlbumSongList(String mid,
      {int page = 1, int pageSize = 1000}) async {
    final data = {
      "comm": {"ct": 24, "cv": 10000},
      "albumSonglist": {
        "method": "GetAlbumSongList",
        "param": {
          "albumMid": mid,
          "albumID": 0,
          "begin": (page - 1) * pageSize,
          "num": pageSize,
          "order": 2
        },
        "module": "music.musichallAlbum.AlbumSongList"
      }
    };
    final resp = await postJsonAsync(
        "https://u.y.qq.com/cgi-bin/musicu.fcg?g_tk=5381&format=json&inCharset=utf8&outCharset=utf-8",
        body: data);
    return AlbumSongListResult.fromJson(jsonDecode(resp));
  }

  // 歌手歌曲列表
  Future<SingerSongResult?> getSingerSongs(String singerMid,
      {int page = 1, int pageSize = 20}) async {
    final data = {
      "comm": {"ct": 24, "cv": 0},
      "singer": {
        "method": "get_singer_detail_info",
        "param": {
          "sort": 5,
          "singermid": singerMid,
          "sin": (page - 1) * pageSize,
          "num": pageSize
        },
        "module": "music.web_singer_info_svr"
      }
    };
    final resp = await postJsonAsync("https://u.y.qq.com/cgi-bin/musicu.fcg",
        body: data);
    return SingerSongResult.fromJson(jsonDecode(resp));
  }

  // 排行榜
  Future<ToplistResult?> getToplist(
      {int id = 4, int page = 1, int pageSize = 100, String? period}) async {
    final String postPeriod = period ?? DateTime.now().toString();
    final data = {
      "detail": {
        "module": "musicToplist.ToplistInfoServer",
        "method": "GetDetail",
        "param": {
          "topId": id,
          "offset": (page - 1) * pageSize,
          "num": pageSize,
          "period": postPeriod,
        }
      },
      "comm": {"ct": 24, "cv": 0}
    };
    final resp = await postJsonAsync("https://u.y.qq.com/cgi-bin/musicu.fcg",
        body: data);
    return ToplistResult.fromJson(jsonDecode(resp));
  }

  // 歌单详情
  Future<PlaylistResult?> getPlaylist(String playlistId) async {
    final data = {
      "disstid": playlistId,
      "format": "json",
      "outCharset": "utf8",
      "type": "1",
      "json": "1",
      "utf8": "1",
      "onlysong": "0",
      "new_format": "1",
    };
    final resp = await postAsync(
        "https://c.y.qq.com/qzone/fcg-bin/fcg_ucc_getcdinfo_byids_cp.fcg",
        body: data);
    return PlaylistResult.fromJson(jsonDecode(resp));
  }

  // 单曲信息
  Future<SongResult?> getSong(String id) async {
    const callBack = "getOneSongInfoCallback";
    final data = {
      id.isNotEmpty && int.tryParse(id) != null ? "songid" : "songmid": id,
      "tpl": "yqq_song_detail",
      "format": "jsonp",
      "callback": callBack,
      "g_tk": "5381",
      "jsonpCallback": callBack,
      "loginUin": "0",
      "hostUin": "0",
      "outCharset": "utf8",
      "notice": "0",
      "platform": "yqq",
      "needNewCode": "0",
    };

    final resp = await postAsync(
        "https://c.y.qq.com/v8/fcg-bin/fcg_play_single_song.fcg",
        body: data);
    final jsonStr = _resolveRespJson(callBack, resp);
    return SongResult.fromJson(jsonDecode(jsonStr));
  }

  // 根据歌曲 ID 下载并解码 XML 歌词
  Future<QqLyricsResponse?> getLyricsAsync(String id) async {
    final resp = await postAsync(
        "https://c.y.qq.com/qqmusic/fcgi-bin/lyric_download.fcg",
        body: {
          "version": "15",
          "miniversion": "82",
          "lrctype": "4",
          "musicid": id,
        });

    final cleanedResp = resp.replaceAll("<!--", "").replaceAll("-->", "");
    final XmlDocument doc = XmlUtils.create(cleanedResp);

    final Map<String, XmlNode> dict = {};
    XmlUtils.recursionFindElement(doc, _verbatimXmlMappingDict, dict);

    final result = QqLyricsResponse(lyrics: "", trans: "");

    for (final entry in dict.entries) {
      final text = entry.value.innerText;
      if (text.trim().isEmpty) continue;
      String? decompressed;
      try {
        decompressed = qrc.QrcDecrypter.decryptLyrics(text);
      } catch (_) {
        continue;
      }
      if (decompressed == null || decompressed.isEmpty) continue;
      String s = "";
      if (decompressed.contains("<?xml")) {
        final subDoc = XmlUtils.create(decompressed);
        final subDict = <String, XmlNode>{};
        XmlUtils.recursionFindElement(subDoc, _verbatimXmlMappingDict, subDict);
        final d = subDict["lyric"];
        if (d != null) {
          s = (d as XmlElement).getAttribute("LyricContent") ?? "";
        }
      } else {
        s = decompressed;
      }
      if (s.isNotEmpty) {
        switch (entry.key) {
          case "orig":
            result.lyrics = s;
            break;
          case "ts":
            result.trans = s;
            break;
        }
      }
    }

    if ((result.lyrics?.isEmpty ?? true) && (result.trans?.isEmpty ?? true))
      return null;
    return result;
  }

  // 获取可播放链接
  Future<String> getSongLink(String songMid) async {
    final guid = _getGuid();
    final data = {
      "req": {
        "method": "GetCdnDispatch",
        "module": "CDN.SrfCdnDispatchServer",
        "param": {"guid": guid, "calltype": "0", "userip": ""}
      },
      "req_0": {
        "method": "CgiGetVkey",
        "module": "vkey.GetVkeyServer",
        "param": {
          "guid": guid,
          "songmid": [songMid],
          "songtype": [1],
          "uin": "0",
          "loginflag": 1,
          "platform": "20"
        }
      },
      "comm": {"uin": 0, "format": "json", "ct": 24, "cv": 0}
    };

    final resp = await postJsonAsync("https://u.y.qq.com/cgi-bin/musicu.fcg",
        body: data);
    final map = jsonDecode(resp) as Map<String, dynamic>;
    String link = "";
    try {
      if ((map["code"] == 0) &&
          (map["req"]["code"] == 0) &&
          (map["req_0"]["code"] == 0)) {
        final List<dynamic>? sip = map["req"]["data"]["sip"] as List<dynamic>?;
        final List<dynamic>? midurlinfo =
            map["req_0"]["data"]["midurlinfo"] as List<dynamic>?;
        if (sip != null &&
            sip.isNotEmpty &&
            midurlinfo != null &&
            midurlinfo.isNotEmpty) {
          final purl = midurlinfo.first["purl"] as String?;
          if (purl != null) {
            link = sip.first + purl;
          }
        }
      }
    } catch (_) {}
    return link;
  }

  // === 私有辅助 ===
  String _getGuid() {
    final rand = Random();
    final buffer = StringBuffer();
    for (var i = 0; i < 10; i++) {
      buffer.write(rand.nextInt(10));
    }
    return buffer.toString();
  }
}

enum SearchTypeEnum {
  SONG_ID,
  ALBUM_ID,
  PLAYLIST_ID,
}
