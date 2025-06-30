// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'musixmatch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RichSyncedLine _$RichSyncedLineFromJson(Map<String, dynamic> json) =>
    RichSyncedLine(
      timeStart: (json['ts'] as num).toDouble(),
      timeEnd: (json['te'] as num).toDouble(),
      words: (json['l'] as List<dynamic>)
          .map((e) => Word.fromJson(e as Map<String, dynamic>))
          .toList(),
      text: json['x'] as String,
    );

Map<String, dynamic> _$RichSyncedLineToJson(RichSyncedLine instance) =>
    <String, dynamic>{
      'ts': instance.timeStart,
      'te': instance.timeEnd,
      'l': instance.words,
      'x': instance.text,
    };

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      chars: json['c'] as String,
      position: (json['o'] as num).toDouble(),
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'c': instance.chars,
      'o': instance.position,
    };
