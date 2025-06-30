import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async'; // 添加 async 库

import 'decrypter.dart';
import 'model.dart';

class KrcHelper {
  static final http.Client _client = http.Client();

  /// 通过 ID 和 AccessKey 获取解密后的歌词
  ///
  /// [id] KRC 歌词 ID
  /// [accessKey] KRC 歌词访问密钥
  /// 返回解密后的歌词
  ///
  /// 注意：此方法在 Dart 中仍然是异步实现，仅提供与 C# 接口兼容性
  /// 推荐使用 getLyricsAsync 方法
  static Future<String?> getLyrics(String id, String accessKey) async {
    // 在 Dart 中，我们不提供真正的同步 HTTP 请求
    // 为了保持接口兼容性，此方法实际上调用异步实现
    final encryptedLyrics = await getEncryptedLyricsAsync(id, accessKey);
    if (encryptedLyrics == null) {
      return null;
    }
    return KrcDecrypter.decryptLyrics(encryptedLyrics);
  }

  /// 通过 ID 和 AccessKey 获取加密的歌词
  ///
  /// [id] KRC 歌词 ID
  /// [accessKey] KRC 歌词访问密钥
  /// 返回加密的歌词内容
  ///
  /// 注意：此方法在 Dart 中仍然是异步实现，仅提供与 C# 接口兼容性
  /// 推荐使用 getEncryptedLyricsAsync 方法
  static Future<String?> getEncryptedLyrics(String id, String accessKey) async {
    // 在 Dart 中，我们不提供真正的同步 HTTP 请求
    // 为了保持接口兼容性，此方法实际上调用异步实现
    return await getEncryptedLyricsAsync(id, accessKey);
  }

  /// 通过 ID 和 AccessKey 获取解密后的歌词（异步）
  ///
  /// [id] KRC 歌词 ID
  /// [accessKey] KRC 歌词访问密钥
  /// 返回解密后的歌词 Future
  static Future<String?> getLyricsAsync(String id, String accessKey) async {
    final encryptedLyrics = await getEncryptedLyricsAsync(id, accessKey);
    if (encryptedLyrics == null) {
      return null;
    }
    return KrcDecrypter.decryptLyrics(encryptedLyrics);
  }

  /// 通过 ID 和 AccessKey 获取加密的歌词（异步）
  ///
  /// [id] KRC 歌词 ID
  /// [accessKey] KRC 歌词访问密钥
  /// 返回加密的歌词内容 Future
  static Future<String?> getEncryptedLyricsAsync(
      String id, String accessKey) async {
    try {
      final url =
          'https://lyrics.kugou.com/download?ver=1&client=pc&id=$id&accesskey=$accessKey&fmt=krc&charset=utf8';
      final response = await _client.get(Uri.parse(url));

      if (response.statusCode != 200) {
        return null;
      }

      final Map<String, dynamic> data = jsonDecode(response.body);
      final kugouResponse = KugouLyricsResponse.fromJson(data);

      return kugouResponse.content;
    } catch (e) {
      return null;
    }
  }
}

// 为保持向后兼容性，提供原始名称的别名
class Helper extends KrcHelper {}
