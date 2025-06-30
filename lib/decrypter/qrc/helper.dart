import 'dart:async';

import 'model.dart';

// 临时内部类，实际应该引用 Providers 模块
class _QQMusicApi {
  static Future<SongResponse?> getSong(String mid) async {
    // 临时实现，在 Providers 模块完成后将更新
    return null;
  }
  
  static Future<QqLyricsResponse?> getLyricsAsync(String id) async {
    // 临时实现，在 Providers 模块完成后将更新
    return null;
  }
}

class QrcHelper {
  /// 通过 Mid 获取解密后的歌词
  /// 
  /// [mid] QQ 音乐歌曲 Mid
  /// 返回解密后的歌词
  static Future<QqLyricsResponse?> getLyricsByMid(String mid) async {
    // Dart 不支持同步 HTTP 请求，直接使用异步实现
    return await getLyricsByMidAsync(mid);
  }

  /// 通过 Mid 获取解密后的歌词（异步）
  /// 
  /// [mid] QQ 音乐歌曲 Mid
  /// 返回解密后的歌词
  static Future<QqLyricsResponse?> getLyricsByMidAsync(String mid) async {
    try {
      // 注意：这是临时实现，实际应使用 Providers 模块
      final song = await _QQMusicApi.getSong(mid);
      if (song == null || song.data == null || song.data!.isEmpty) {
        return null;
      }
      
      final id = song.data![0].id;
      if (id == null) {
        return null;
      }
      
      return await getLyricsAsync(id);
    } catch (e) {
      return null;
    }
  }

  /// 通过 ID 获取解密后的歌词
  /// 
  /// [id] QQ 音乐歌曲 ID
  /// 返回解密后的歌词
  static Future<QqLyricsResponse?> getLyrics(String id) async {
    // Dart 不支持同步 HTTP 请求，直接使用异步实现
    return await getLyricsAsync(id);
  }

  /// 通过 ID 获取解密后的歌词（异步）
  /// 
  /// [id] QQ 音乐歌曲 ID
  /// 返回解密后的歌词
  static Future<QqLyricsResponse?> getLyricsAsync(String id) async {
    try {
      // 注意：这是临时实现，实际应使用 Providers 模块
      return await _QQMusicApi.getLyricsAsync(id);
    } catch (e) {
      return null;
    }
  }
}

// 为保持向后兼容性，提供原始名称的别名
class Helper extends QrcHelper {} 