import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class BaseApi {
  static http.Client httpClient = http.Client();

  static const String userAgent =
      "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36";
  static const String cookie =
      "os=pc;osver=Microsoft-Windows-10-Professional-build-16299.125-64bit;appver=2.0.3.131777;channel=netease;__remember_me=true";

  // In C#, this is an abstract property.
  // In Dart, this can be an abstract getter.
  String? get httpRefer;

  // In C#, this is an abstract property.
  // In Dart, this can be an abstract getter.
  Map<String, String>? get additionalHeaders;

  Map<String, String> _getRequestHeaders() {
    final headers = <String, String>{
      'User-Agent': userAgent,
      'Cookie': cookie,
    };
    if (httpRefer != null) {
      headers['Referer'] = httpRefer!;
    }
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders!);
    }
    return headers;
  }

  Future<String> getAsync(String url) async {
    final response = await httpClient.get(
      Uri.parse(url),
      headers: _getRequestHeaders(),
    );
    response.ensureSuccessStatusCode();
    return response.body;
  }

  Future<String> postAsync(String url, {Map<String, String>? body}) async {
    final response = await httpClient.post(
      Uri.parse(url),
      headers: _getRequestHeaders(),
      body: body,
    );
    response.ensureSuccessStatusCode();
    return response.body;
  }

  Future<String> postJsonAsync(String url, {Object? body}) async {
    final headers = _getRequestHeaders();
    headers['Content-Type'] = 'application/json';
    final response = await httpClient.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    response.ensureSuccessStatusCode();
    return response.body;
  }

  Future<String> postAsyncObject(String url, {required Map<String, Object> body}) async {
    final headers = _getRequestHeaders();
    headers['Content-Type'] = 'application/json';
    final response = await httpClient.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    response.ensureSuccessStatusCode();
    return response.body;
  }

  Future<String> postAsyncRaw(String url, {required String body}) async {
    final headers = _getRequestHeaders();
    headers['Content-Type'] = 'application/json';
    final response = await httpClient.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    response.ensureSuccessStatusCode();
    return response.body;
  }
}

extension on http.Response {
  void ensureSuccessStatusCode() {
    if (statusCode < 200 || statusCode >= 300) {
      throw http.ClientException(
          'Request failed with status: $statusCode.', request?.url);
    }
  }
}

class JsonUtils {
  // mirror of C# JsonUtils static extension methods
  static T? toEntity<T>(String val) {
    // 返回动态解析结果，调用方负责转换
    return jsonDecode(val) as T?;
  }

  static List<T>? toEntityList<T>(String val) {
    final dynamic decoded = jsonDecode(val);
    if (decoded is List) {
      return decoded.cast<T>();
    }
    return null;
  }

  static String toJson<T>(T entity, {bool pretty = false}) {
    if (pretty) {
      return const JsonEncoder.withIndent('  ').convert(entity);
    }
    return jsonEncode(entity);
  }
} 