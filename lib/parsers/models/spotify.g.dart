// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotifyColorLyrics _$SpotifyColorLyricsFromJson(Map<String, dynamic> json) =>
    SpotifyColorLyrics(
      lyrics: SpotifyLyrics.fromJson(json['lyrics'] as Map<String, dynamic>),
      colors: SpotifyColors.fromJson(json['colors'] as Map<String, dynamic>),
      hasVocalRemoval: json['hasVocalRemoval'] as bool,
    );

Map<String, dynamic> _$SpotifyColorLyricsToJson(SpotifyColorLyrics instance) =>
    <String, dynamic>{
      'lyrics': instance.lyrics,
      'colors': instance.colors,
      'hasVocalRemoval': instance.hasVocalRemoval,
    };

SpotifyLyrics _$SpotifyLyricsFromJson(Map<String, dynamic> json) =>
    SpotifyLyrics(
      syncType: json['syncType'] as String,
      lines: (json['lines'] as List<dynamic>)
          .map((e) => SpotifyLyricsLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      provider: json['provider'] as String,
      providerLyricsId: json['providerLyricsId'] as String,
      providerDisplayName: json['providerDisplayName'] as String,
      syncLyricsUri: json['syncLyricsUri'] as String,
      isDenseTypeface: json['isDenseTypeface'] as bool,
      alternatives: (json['alternatives'] as List<dynamic>)
          .map((e) => AlternativeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      language: json['language'] as String,
      isRtlLanguage: json['isRtlLanguage'] as bool,
      fullscreenAction: json['fullscreenAction'] as String,
    );

Map<String, dynamic> _$SpotifyLyricsToJson(SpotifyLyrics instance) =>
    <String, dynamic>{
      'syncType': instance.syncType,
      'lines': instance.lines,
      'provider': instance.provider,
      'providerLyricsId': instance.providerLyricsId,
      'providerDisplayName': instance.providerDisplayName,
      'syncLyricsUri': instance.syncLyricsUri,
      'isDenseTypeface': instance.isDenseTypeface,
      'alternatives': instance.alternatives,
      'language': instance.language,
      'isRtlLanguage': instance.isRtlLanguage,
      'fullscreenAction': instance.fullscreenAction,
    };

SpotifyLyricsLine _$SpotifyLyricsLineFromJson(Map<String, dynamic> json) =>
    SpotifyLyricsLine(
      startTimeMs: json['startTimeMs'] as String,
      endTimeMs: json['endTimeMs'] as String,
      words: json['words'] as String,
      syllables: (json['syllables'] as List<dynamic>)
          .map((e) => SyllableItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpotifyLyricsLineToJson(SpotifyLyricsLine instance) =>
    <String, dynamic>{
      'startTimeMs': instance.startTimeMs,
      'endTimeMs': instance.endTimeMs,
      'words': instance.words,
      'syllables': instance.syllables,
    };

SyllableItem _$SyllableItemFromJson(Map<String, dynamic> json) => SyllableItem(
      startTimeMs: json['startTimeMs'] as String,
      endTimeMs: json['endTimeMs'] as String,
      numberChars: json['numChars'] as String,
    );

Map<String, dynamic> _$SyllableItemToJson(SyllableItem instance) =>
    <String, dynamic>{
      'startTimeMs': instance.startTimeMs,
      'endTimeMs': instance.endTimeMs,
      'numChars': instance.numberChars,
    };

AlternativeItem _$AlternativeItemFromJson(Map<String, dynamic> json) =>
    AlternativeItem(
      language: json['language'] as String,
      lines: (json['lines'] as List<dynamic>).map((e) => e as String).toList(),
      isRtlLanguage: json['isRtlLanguage'] as bool,
    );

Map<String, dynamic> _$AlternativeItemToJson(AlternativeItem instance) =>
    <String, dynamic>{
      'language': instance.language,
      'lines': instance.lines,
      'isRtlLanguage': instance.isRtlLanguage,
    };

SpotifyColors _$SpotifyColorsFromJson(Map<String, dynamic> json) =>
    SpotifyColors(
      background: (json['background'] as num).toInt(),
      text: (json['text'] as num).toInt(),
      highlightText: (json['highlightText'] as num).toInt(),
    );

Map<String, dynamic> _$SpotifyColorsToJson(SpotifyColors instance) =>
    <String, dynamic>{
      'background': instance.background,
      'text': instance.text,
      'highlightText': instance.highlightText,
    };
