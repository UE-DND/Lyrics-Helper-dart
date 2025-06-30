import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import 'base_api.dart';

/// Mirror of C# static class `Proxy` providing proxy configuration utilities.
class Proxy {
  Proxy._();

  /// 设置代理
  static void setProxy(String host, int port,
      {String? username, String? password}) {
    final innerClient = HttpClient();
    innerClient.findProxy = (uri) => "PROXY $host:$port";

    if (username != null && password != null) {
      innerClient.addProxyCredentials(
          host, port, "", HttpClientBasicCredentials(username, password));
    }

    BaseApi.httpClient = IOClient(innerClient);
  }

  /// 禁用代理，不使用系统代理
  static void disableProxy() {
    final innerClient = HttpClient();
    innerClient.findProxy = (uri) => "DIRECT";
    BaseApi.httpClient = IOClient(innerClient);
  }

  /// 清除代理设定，恢复默认客户端
  static void clearProxy() {
    BaseApi.httpClient = http.Client();
  }
}

// ---------------------------------------------------------------------------
// Legacy top-level wrappers (for compatibility with existing Dart calls).
// These simply forward to the new Proxy class static methods.

/// 设置代理（兼容旧调用）
@Deprecated('Use Proxy.setProxy instead')
void setProxy(String host, int port, {String? username, String? password}) =>
    Proxy.setProxy(host, port, username: username, password: password);

/// 禁用代理，不使用系统代理（兼容旧调用）
@Deprecated('Use Proxy.disableProxy instead')
void disableProxy() => Proxy.disableProxy();

/// 清除代理设定（兼容旧调用）
@Deprecated('Use Proxy.clearProxy instead')
void clearProxy() => Proxy.clearProxy();
