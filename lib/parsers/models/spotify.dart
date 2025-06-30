// ignore_for_file: deprecated_member_use
import 'package:json_annotation/json_annotation.dart';

part 'spotify.g.dart';

@JsonSerializable()
class SpotifyColorLyrics {
  @JsonKey(name: 'lyrics')
  SpotifyLyrics lyrics;

  @JsonKey(name: 'colors')
  SpotifyColors colors;

  @JsonKey(name: 'hasVocalRemoval')
  bool hasVocalRemoval;

  SpotifyColorLyrics({required this.lyrics, required this.colors, required this.hasVocalRemoval});

  factory SpotifyColorLyrics.fromJson(Map<String, dynamic> json) => _$SpotifyColorLyricsFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyColorLyricsToJson(this);
}

@JsonSerializable()
class SpotifyLyrics {
  @JsonKey(name: 'syncType')
  String syncType;

  @JsonKey(name: 'lines')
  List<SpotifyLyricsLine> lines;

  @JsonKey(name: 'provider')
  String provider;

  @JsonKey(name: 'providerLyricsId')
  String providerLyricsId;

  @JsonKey(name: 'providerDisplayName')
  String providerDisplayName;

  @JsonKey(name: 'syncLyricsUri')
  String syncLyricsUri;

  @JsonKey(name: 'isDenseTypeface')
  bool isDenseTypeface;

  @JsonKey(name: 'alternatives')
  List<AlternativeItem> alternatives;

  @JsonKey(name: 'language')
  String language;

  @JsonKey(name: 'isRtlLanguage')
  bool isRtlLanguage;

  @JsonKey(name: 'fullscreenAction')
  String fullscreenAction;

  SpotifyLyrics({
    required this.syncType,
    required this.lines,
    required this.provider,
    required this.providerLyricsId,
    required this.providerDisplayName,
    required this.syncLyricsUri,
    required this.isDenseTypeface,
    required this.alternatives,
    required this.language,
    required this.isRtlLanguage,
    required this.fullscreenAction,
  });

  factory SpotifyLyrics.fromJson(Map<String, dynamic> json) => _$SpotifyLyricsFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyLyricsToJson(this);
}

@JsonSerializable()
class SpotifyLyricsLine {
  @JsonKey(name: 'startTimeMs')
  String startTimeMs;

  @JsonKey(ignore: true)
  int get startTime => int.tryParse(startTimeMs) ?? 0;

  @JsonKey(name: 'endTimeMs')
  String endTimeMs;

  @JsonKey(ignore: true)
  int get endTime => int.tryParse(endTimeMs) ?? 0;

  @JsonKey(name: 'words')
  String words;

  @JsonKey(name: 'syllables')
  List<SyllableItem> syllables;

  SpotifyLyricsLine({
    required this.startTimeMs,
    required this.endTimeMs,
    required this.words,
    required this.syllables,
  });

  factory SpotifyLyricsLine.fromJson(Map<String, dynamic> json) => _$SpotifyLyricsLineFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyLyricsLineToJson(this);
}

@JsonSerializable()
class SyllableItem {
  @JsonKey(name: 'startTimeMs')
  String startTimeMs;

  @JsonKey(ignore: true)
  int get startTime => int.tryParse(startTimeMs) ?? 0;

  @JsonKey(name: 'endTimeMs')
  String endTimeMs;

  @JsonKey(ignore: true)
  int get endTime => int.tryParse(endTimeMs) ?? 0;
  
  @JsonKey(name: 'numChars')
  String numberChars;

  @JsonKey(ignore: true)
  int get charsCount => int.tryParse(numberChars) ?? 0;

  SyllableItem({required this.startTimeMs, required this.endTimeMs, required this.numberChars});

  factory SyllableItem.fromJson(Map<String, dynamic> json) => _$SyllableItemFromJson(json);
  Map<String, dynamic> toJson() => _$SyllableItemToJson(this);
}

@JsonSerializable()
class AlternativeItem {
  @JsonKey(name: 'language')
  String language;

  @JsonKey(name: 'lines')
  List<String> lines;

  @JsonKey(name: 'isRtlLanguage')
  bool isRtlLanguage;

  AlternativeItem({required this.language, required this.lines, required this.isRtlLanguage});

  factory AlternativeItem.fromJson(Map<String, dynamic> json) => _$AlternativeItemFromJson(json);
  Map<String, dynamic> toJson() => _$AlternativeItemToJson(this);
}

@JsonSerializable()
class SpotifyColors {
  @JsonKey(name: 'background')
  int background;

  @JsonKey(name: 'text')
  int text;

  @JsonKey(name: 'highlightText')
  int highlightText;

  SpotifyColors({required this.background, required this.text, required this.highlightText});

  factory SpotifyColors.fromJson(Map<String, dynamic> json) => _$SpotifyColorsFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyColorsToJson(this);
} 