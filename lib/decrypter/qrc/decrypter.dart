import 'dart:convert';
import 'dart:typed_data';
import 'package:archive/archive.dart';

import 'des_helper.dart';

class QrcDecrypter {
  // QQ 音乐歌词解密密钥
  static final Uint8List _qqKey = ascii.encode('!@#)(*\$%123ZXC!@!@#)(NHL');

  /// 解密 QRC 歌词
  /// 
  /// [encryptedLyrics] 加密的歌词
  /// 返回解密后的 QRC 歌词
  static String? decryptLyrics(String encryptedLyrics) {
    try {
      // 将十六进制字符串转换为字节数组
      final encryptedTextByte = _hexStringToBytes(encryptedLyrics);
      
      // 使用 DES 解密
      final decryptedData = DESHelper.decrypt(encryptedTextByte, _qqKey);
      
      // 解压缩数据
      final decompressedData = _decompress(decryptedData);
      
      // 移除 UTF-8 BOM 标识（如果存在）
      final utf8Bom = [0xEF, 0xBB, 0xBF]; // UTF-8 BOM
      Uint8List dataWithoutBom = decompressedData;
      
      // 检查并移除 BOM
      if (decompressedData.length >= 3 && 
          decompressedData[0] == utf8Bom[0] && 
          decompressedData[1] == utf8Bom[1] && 
          decompressedData[2] == utf8Bom[2]) {
        dataWithoutBom = decompressedData.sublist(3);
      }
      
      // 转换为 UTF-8 字符串
      final result = utf8.decode(dataWithoutBom);
      return result;
    } catch (e) {
      return null;
    }
  }

  /// 使用 archive 库解压缩数据
  static Uint8List _decompress(Uint8List data) {
    final inflater = Inflate(data);
    final decompressed = inflater.getBytes();
    return Uint8List.fromList(decompressed);
  }

  /// 将十六进制字符串转换为字节数组
  static Uint8List _hexStringToBytes(String hexString) {
    final int length = hexString.length;
    final bytes = Uint8List(length ~/ 2);
    
    for (int i = 0; i < length; i += 2) {
      // 将每两个十六进制字符转换为一个字节
      final byteValue = int.parse(hexString.substring(i, i + 2), radix: 16);
      bytes[i ~/ 2] = byteValue;
    }
    
    return bytes;
  }
}

// 为保持向后兼容性，提供原始名称的别名
class Decrypter extends QrcDecrypter {} 