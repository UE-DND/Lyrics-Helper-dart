// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yrc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditsInfo _$CreditsInfoFromJson(Map<String, dynamic> json) => CreditsInfo(
      timestamp: (json['t'] as num).toInt(),
      credits: (json['c'] as List<dynamic>)
          .map((e) => Credit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreditsInfoToJson(CreditsInfo instance) =>
    <String, dynamic>{
      't': instance.timestamp,
      'c': instance.credits,
    };

Credit _$CreditFromJson(Map<String, dynamic> json) => Credit(
      text: json['tx'] as String,
      image: json['li'] as String,
      orpheus: json['or'] as String,
    );

Map<String, dynamic> _$CreditToJson(Credit instance) => <String, dynamic>{
      'tx': instance.text,
      'li': instance.image,
      'or': instance.orpheus,
    };
