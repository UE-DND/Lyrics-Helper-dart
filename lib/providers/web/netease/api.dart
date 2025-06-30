import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pointycastle/export.dart';

import '../base_api.dart';
import 'eapi_helper.dart' as eapi;
import 'response.dart' as model;

class Api extends BaseApi {
  @override
  String? get httpRefer => "https://music.163.com/";

  @override
  Map<String, String>? get additionalHeaders => null;

  //-=-=-=-=-=-=-= WEAPI Constants =-=-=-=-=-=-=-
  static const String _modulus =
      "00e0b509f6259df8642dbc35662901477df22677ec152b5ff68ace615bb7b725152b3ab17a876aea8a5aa76d2e417629ec4ee341f56135fccf695280104e0312ecbda92557c93870114af6c9d05c4f7f0c3685b7a46bee255932575cce10b424d813cfe4875d3e82047b97ddef52741d546b8e289dc6935b3ece0462db0a22b8e7";
  static const String _nonce = "0CoJUm6Qyw8W8jud";
  static const String _pubKey = "010001";

  //-=-=-=-=-=-=-= Public API Methods =-=-=-=-=-=-=-

  Future<model.EapiSearchResult?> searchNew(String keyword) async {
    const url = "https://interface.music.163.com/eapi/cloudsearch/pc";
    final data = {
      "s": keyword,
      "type": "1",
      "limit": "30",
      "offset": "0",
      "total": "true",
    };
    final raw = await eapi.post(url, data);
    return model.EapiSearchResult.fromJson(jsonDecode(raw));
  }

  Future<model.LyricResult?> getLyric(String songId) async {
    const url = "https://music.163.com/weapi/song/lyric?csrf_token=";
    final data = {
      "id": songId,
      "os": "pc",
      "lv": "-1",
      "kv": "-1",
      "tv": "-1",
      "csrf_token": "",
    };
    final prepared = _prepare(jsonEncode(data));
    final raw = await postAsync(url, body: prepared);
    return model.LyricResult.fromJson(jsonDecode(raw));
  }

  //-=-=-=-=-=-=-= WEAPI Crypto Helpers =-=-=-=-=-=-=-

  Map<String, String> _prepare(String raw) {
    final secretKey = _createSecretKey(16);
    final params = _aesEncrypt(
      base64.decode(_aesEncrypt(utf8.encode(raw), _nonce)),
      secretKey,
    );
    final encSecKey = _rsaEncrypt(secretKey, _pubKey, _modulus);
    return {'params': params, 'encSecKey': encSecKey};
  }

  String _createSecretKey(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  String _aesEncrypt(List<int> buffer, String key) {
    final iv = utf8.encode('0102030405060708');
    final keyBytes = utf8.encode(key);
    final cbc = CBCBlockCipher(AESEngine());
    final paddedCipher = PaddedBlockCipherImpl(PKCS7Padding(), cbc);

    paddedCipher.init(
        true,
        PaddedBlockCipherParameters(
            ParametersWithIV(KeyParameter(Uint8List.fromList(keyBytes)),
                Uint8List.fromList(iv)),
            null));
    return base64.encode(paddedCipher.process(Uint8List.fromList(buffer)));
  }

  String _rsaEncrypt(String text, String pubKey, String modulus) {
    final keyBytes = utf8.encode(text).reversed.toList();
    final biText = BigInt.parse('1${hex.encode(keyBytes)}', radix: 16);
    final biEx = BigInt.parse(pubKey, radix: 16);
    final biMod = BigInt.parse(modulus, radix: 16);
    final biRet = biText.modPow(biEx, biMod);
    return biRet.toRadixString(16).padLeft(256, '0');
  }

  // 搜索类型
  static const Map<SearchType, String> _searchTypeMap = {
    SearchType.song: "1",
    SearchType.album: "10",
    SearchType.playlist: "1000",
  };

  Future<model.SearchResult?> search(String keyword, SearchType type) async {
    final typeStr = _searchTypeMap[type] ?? "1";
    final url =
        "https://music.163.com/api/search/get/web?csrf_token=hlpretag=&hlposttag=&s=${Uri.encodeComponent(keyword)}&type=$typeStr&offset=0&total=true&limit=20";
    final raw = await getAsync(url);
    return model.SearchResult.fromJson(jsonDecode(raw));
  }

  Future<model.AlbumResult?> getAlbum(String albumId) async {
    final url = "https://music.163.com/weapi/v1/album/$albumId?csrf_token=";
    final data = jsonEncode({"csrf_token": ""});
    final raw = await postAsync(url, body: _prepare(data));
    return model.AlbumResult.fromJson(jsonDecode(raw));
  }

  Future<model.PlaylistResult?> getPlaylist(String playlistId) async {
    const url = "https://music.163.com/weapi/v6/playlist/detail?csrf_token=";
    final data = jsonEncode({
      "csrf_token": "",
      "id": playlistId,
      "offset": "0",
      "total": "true",
      "limit": "1000",
      "n": "1000"
    });
    final raw = await postAsync(url, body: _prepare(data));
    return model.PlaylistResult.fromJson(jsonDecode(raw));
  }

  Future<Map<String, model.Datum>> getDatum(List<String> songIds,
      {int bitrate = 999000}) async {
    final urls = await _getSongsUrl(songIds, bitrate: bitrate);
    final map = <String, model.Datum>{};
    if (urls?.code == 200 && urls?.data != null) {
      for (final d in urls!.data!) {
        map[d.id] = d;
      }
    }
    return map;
  }

  Future<Map<String, model.Song>> getSongs(List<String> songIds) async {
    final detail = await _getDetail(songIds);
    final map = <String, model.Song>{};
    if (detail?.code == 200 && detail?.songs != null) {
      for (final s in detail!.songs!) {
        map[s.id] = s;
      }
    }
    return map;
  }

  Future<model.LyricResult?> getLyricNew(String songId) async {
    const url = "https://interface3.music.163.com/eapi/song/lyric/v1";
    final data = {
      "id": songId,
      "cp": "false",
      "lv": "0",
      "kv": "0",
      "tv": "0",
      "rv": "0",
      "yv": "0",
      "ytv": "0",
      "yrv": "0",
      "csrf_token": "",
    };
    final raw = await eapi.post(url, data);
    return model.LyricResult.fromJson(jsonDecode(raw));
  }

  //-=-=-=-=- private helpers -=-=-=-=-
  Future<model.SongUrls?> _getSongsUrl(List<String> songIds,
      {int bitrate = 999000}) async {
    const url =
        "https://music.163.com/weapi/song/enhance/player/url?csrf_token=";
    final data = jsonEncode({
      "ids": "[${songIds.join(',')}]",
      "br": bitrate.toString(),
      "csrf_token": "",
    });
    final raw = await postAsync(url, body: _prepare(data));
    return model.SongUrls.fromJson(jsonDecode(raw));
  }

  Future<model.DetailResult?> _getDetail(List<String> songIds) async {
    const url = "https://music.163.com/weapi/v3/song/detail?csrf_token=";
    if (songIds.isEmpty) return null;
    final c = songIds.map((e) => "{'id':'$e'}").join(',');
    final data = jsonEncode({
      "c": "[$c]",
      "os": "pc",
      "csrf_token": "",
    });
    final raw = await postAsync(url, body: _prepare(data));
    return model.DetailResult.fromJson(jsonDecode(raw));
  }
}

enum SearchType { song, album, playlist }
