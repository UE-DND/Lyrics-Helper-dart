import 'dart:convert';
import 'dart:typed_data';
import 'package:archive/archive.dart';

class KrcDecrypter {
  static const List<int> _decryptKey = [0x40, 0x47, 0x61, 0x77, 0x5e, 0x32, 0x74, 0x47, 0x51, 0x36, 0x31, 0x2d, 0xce, 0xd2, 0x6e, 0x69];

  /// 解密 KRC 歌词
  /// 
  /// [encryptedLyrics] 加密的歌词
  /// 返回解密后的 KRC 歌词
  static String? decryptLyrics(String encryptedLyrics) {
    try {
      // 解码 Base64 字符串
      final bytes = base64.decode(encryptedLyrics);
      
      // 跳过前 4 个字节
      final data = bytes.sublist(4);
      
      // 对每个字节进行异或解密
      for (var i = 0; i < data.length; ++i) {
        data[i] = data[i] ^ _decryptKey[i % _decryptKey.length];
      }
      
      // 解压缩并转换为字符串
      final decompressed = _decompress(data);
      final result = utf8.decode(decompressed);
      
      // 移除第一个字符（与 C# 版本保持一致）
      return result.substring(1);
    } catch (e) {
      return null;
    }
  }
  
  /// 使用 archive 库解压缩字节数组
  static Uint8List _decompress(List<int> data) {
    final inflater = Inflate(data);
    final decompressed = inflater.getBytes();
    return Uint8List.fromList(decompressed);
  }
}

// 为保持向后兼容性，提供原始名称的别名
class Decrypter extends KrcDecrypter {} 