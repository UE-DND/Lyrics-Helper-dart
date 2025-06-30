// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSongResponse _$SearchSongResponseFromJson(Map<String, dynamic> json) =>
    SearchSongResponse(
      status: (json['status'] as num).toInt(),
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : DataItem.fromJson(json['data'] as Map<String, dynamic>),
      errorCode: (json['errcode'] as num).toInt(),
    );

DataItem _$DataItemFromJson(Map<String, dynamic> json) => DataItem(
      timestamp: (json['timestamp'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      info: (json['info'] as List<dynamic>)
          .map((e) => InfoItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

InfoItem _$InfoItemFromJson(Map<String, dynamic> json) => InfoItem(
      hash: json['hash'] as String,
      songName: json['songname'] as String,
      albumName: json['album_name'] as String?,
      songNameOriginal: json['songname_original'] as String?,
      singerName: json['singername'] as String,
      duration: (json['duration'] as num).toInt(),
      filename: json['filename'] as String,
      group: (json['group'] as List<dynamic>?)
          ?.map((e) => InfoItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

SearchLyricsResponse _$SearchLyricsResponseFromJson(
        Map<String, dynamic> json) =>
    SearchLyricsResponse(
      status: (json['status'] as num).toInt(),
      info: json['info'] as String?,
      errorCode: (json['errcode'] as num).toInt(),
      errorMessage: json['errmsg'] as String?,
      keywork: json['keywork'] as String?,
      proposal: json['proposal'] as String?,
      hasCompleteRight: (json['has_complete_right'] as num?)?.toInt(),
      ugc: (json['ugc'] as num?)?.toInt(),
      ugcCount: (json['ugccount'] as num?)?.toInt(),
      expire: (json['expire'] as num?)?.toInt(),
      candidates: (json['candidates'] as List<dynamic>)
          .map((e) => Candidate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Candidate _$CandidateFromJson(Map<String, dynamic> json) => Candidate(
      id: json['id'] as String,
      productFrom: json['product_from'] as String?,
      accessKey: json['accesskey'] as String?,
      canScore: json['can_score'] as bool?,
      singer: json['singer'] as String,
      song: json['song'] as String,
      duration: (json['duration'] as num).toInt(),
      uid: json['uid'] as String?,
      nickname: json['nickname'] as String?,
      origiuid: json['origiuid'] as String?,
      originame: json['originame'] as String?,
      transuid: json['transuid'] as String?,
      transname: json['transname'] as String?,
      sounduid: json['sounduid'] as String?,
      soundname: json['soundname'] as String?,
      language: json['language'] as String?,
      krcType: (json['krctype'] as num?)?.toInt(),
      hitlayer: (json['hitlayer'] as num?)?.toInt(),
      hitcasemask: (json['hitcasemask'] as num?)?.toInt(),
      adjust: (json['adjust'] as num?)?.toInt(),
      score: (json['score'] as num?)?.toInt(),
      contentType: (json['contenttype'] as num?)?.toInt(),
      contentFormat: (json['content_format'] as num?)?.toInt(),
      transId: json['trans_id'] as String?,
    );
