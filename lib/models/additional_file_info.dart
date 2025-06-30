/// 歌词文件附加信息接口
abstract class IAdditionalFileInfo {
  Map<String, dynamic> toJson();
  @override
  String toString() => toJson().toString();
}

/// 通用附加信息（适用于 LRC、KRC、QRC、Lyricify Syllable、Lyricify Lines 等多种歌词）
class GeneralAdditionalInfo implements IAdditionalFileInfo {
  /// 属性列表
  List<MapEntry<String, String>>? attributes;

  @override
  Map<String, dynamic> toJson() => {
        'attributes': attributes
            ?.map((e) => {
                  'key': e.key,
                  'value': e.value,
                })
            .toList(),
      };
}

/// KRC 附加信息
class KrcAdditionalInfo extends GeneralAdditionalInfo {
  /// 哈希值
  String? hash;

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'hash': hash,
      };
}

/// 适用于 Spotify 歌词的附加信息
class SpotifyAdditionalInfo implements IAdditionalFileInfo {
  /// 默认构造函数
  SpotifyAdditionalInfo()
      : provider = null,
        providerLyricsId = null,
        providerDisplayName = null,
        lyricsLanguage = null;

  /// 从 SpotifyLyrics 对象创建
  SpotifyAdditionalInfo.fromSpotifyLyrics(dynamic lyrics)
      : provider = lyrics.provider,
        providerLyricsId = lyrics.providerLyricsId,
        providerDisplayName = lyrics.providerDisplayName,
        lyricsLanguage = (lyrics.language != null && lyrics.language.isNotEmpty)
            ? lyrics.language
            : null;

  /// 使用提供者、歌词ID和显示名称创建
  SpotifyAdditionalInfo.create(
      this.provider, this.providerLyricsId, this.providerDisplayName)
      : lyricsLanguage = null;

  /// 使用提供者、歌词ID、显示名称和语言创建
  SpotifyAdditionalInfo.withLanguage(
    this.provider,
    this.providerLyricsId,
    this.providerDisplayName,
    this.lyricsLanguage,
  );

  /// 提供者名称
  final String? provider;

  /// 提供者歌词ID
  final String? providerLyricsId;

  /// 提供者显示名称
  final String? providerDisplayName;

  /// 歌词语言
  final String? lyricsLanguage;

  @override
  Map<String, dynamic> toJson() => {
        'provider': provider,
        'providerLyricsId': providerLyricsId,
        'providerDisplayName': providerDisplayName,
        'lyricsLanguage': lyricsLanguage,
      };
}
