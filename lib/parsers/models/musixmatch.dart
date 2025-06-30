import 'package:json_annotation/json_annotation.dart';

part 'musixmatch.g.dart';

@JsonSerializable()
class RichSyncedLine {
  @JsonKey(name: 'ts')
  double timeStart;

  @JsonKey(name: 'te')
  double timeEnd;

  @JsonKey(name: 'l')
  List<Word> words;

  @JsonKey(name: 'x')
  String text;

  RichSyncedLine({
    required this.timeStart,
    required this.timeEnd,
    required this.words,
    required this.text,
  });

  factory RichSyncedLine.fromJson(Map<String, dynamic> json) =>
      _$RichSyncedLineFromJson(json);

  Map<String, dynamic> toJson() => _$RichSyncedLineToJson(this);
}

@JsonSerializable()
class Word {
  @JsonKey(name: 'c')
  String chars;

  @JsonKey(name: 'o')
  double position;

  Word({
    required this.chars,
    required this.position,
  });

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  Map<String, dynamic> toJson() => _$WordToJson(this);
}
