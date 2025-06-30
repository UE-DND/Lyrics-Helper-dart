import 'i_provider.dart';
import 'i_provider_result.dart';

/// 抽象歌词提供者，镜像 C# Provider 抽象类
abstract class Provider implements IProvider {
  /// 内部名称
  String get name;

  /// 显示名称
  String get displayName;

  /// 获取歌词
  Future<IProviderResult> obtainLyrics();
} 