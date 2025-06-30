import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

import '../base_api.dart';

const String _eapiKey = 'e82ckenh8dichen8';

Future<String> post(String url, Map<String, dynamic> data) async {
  final headers = {
    'User-Agent':
        'Mozilla/5.0 (Linux; Android 9; PCT-AL10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.64 HuaweiBrowser/10.0.3.311 Mobile Safari/537.36',
    'Referer': 'https://music.163.com/',
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  final header = {
    "__csrf": "",
    "appver": "8.0.0",
    "buildver": DateTime.now().millisecondsSinceEpoch.toString().substring(0, 10),
    "channel": "",
    "deviceId": "",
    "mobilename": "",
    "resolution": "1920x1080",
    "os": "android",
    "osver": "",
    "requestId": "${DateTime.now().millisecondsSinceEpoch}_${(DateTime.now().millisecond % 1000).toString().padLeft(4, '0')}",
    "versioncode": "140",
    "MUSIC_U": "",
  };

  headers['Cookie'] = header.entries.map((e) => '${e.key}=${e.value}').join('; ');
  data['header'] = jsonEncode(header);

  final encryptedData = _eApi(url, data);
  final finalUrl = url.replaceAll(RegExp(r'\w*api'), 'eapi');

  final response = await BaseApi.httpClient.post(
    Uri.parse(finalUrl),
    headers: headers,
    body: encryptedData,
  );

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return response.body;
  } else {
    throw Exception('Failed to load data from Netease EAPI');
  }
}

Map<String, String> _eApi(String url, Map<String, dynamic> object) {
  final requestUrl = url.replaceAll(RegExp(r'https://interface.*.music.163.com/e'), '/');
  final text = jsonEncode(object);
  final message = 'nobody${requestUrl}use${text}md5forencrypt';
  final digest = md5.convert(utf8.encode(message)).toString();
  final data = '$requestUrl-36cd479b6b5-$text-36cd479b6b5-$digest';

  return {
    'params': _aesEncrypt(utf8.encode(data), _eapiKey).map((e) => e.toRadixString(16).padLeft(2, '0')).join('').toUpperCase(),
  };
}

Uint8List _aesEncrypt(List<int> buffer, String key) {
  final keyBytes = utf8.encode(key);
  final ecb = ECBBlockCipher(AESEngine());
  final paddedCipher = PaddedBlockCipherImpl(PKCS7Padding(), ecb);

  paddedCipher.init(
      true, PaddedBlockCipherParameters(KeyParameter(Uint8List.fromList(keyBytes)), null));
  return paddedCipher.process(Uint8List.fromList(buffer));
} 