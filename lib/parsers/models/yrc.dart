import 'package:json_annotation/json_annotation.dart';

part 'yrc.g.dart';

@JsonSerializable()
class CreditsInfo {
  @JsonKey(name: 't')
  int timestamp;

  @JsonKey(name: 'c')
  List<Credit> credits;

  CreditsInfo({required this.timestamp, required this.credits});

  factory CreditsInfo.fromJson(Map<String, dynamic> json) => _$CreditsInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CreditsInfoToJson(this);
}

@JsonSerializable()
class Credit {
  @JsonKey(name: 'tx')
  String text;

  @JsonKey(name: 'li')
  String image;

  @JsonKey(name: 'or')
  String orpheus;

  Credit({required this.text, required this.image, required this.orpheus});

  factory Credit.fromJson(Map<String, dynamic> json) => _$CreditFromJson(json);

  Map<String, dynamic> toJson() => _$CreditToJson(this);
} 