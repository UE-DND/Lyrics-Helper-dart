import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

//-=-=-=-=-=-=-= GetTokenResponse Models =-=-=-=-=-=-=-

@JsonSerializable(createToJson: false)
class GetTokenResponse {
  @JsonKey(name: 'message')
  final MessageContent? message;

  GetTokenResponse({this.message});

  factory GetTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTokenResponseFromJson(json);
}

//-=-=-=-=-=-=-= GetTrackResponse Models =-=-=-=-=-=-=-

@JsonSerializable(createToJson: false)
class GetTrackResponse {
  @JsonKey(name: 'message')
  final MessageContent? message;

  GetTrackResponse({this.message});

  factory GetTrackResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTrackResponseFromJson(json);
}

//-=-=-=-=-=-=-= GetTranslationsResponse Models =-=-=-=-=-=-=

@JsonSerializable(createToJson: false)
class GetTranslationsResponse {
  @JsonKey(name: 'message')
  final TMessageContent? message;

  GetTranslationsResponse({this.message});

  factory GetTranslationsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTranslationsResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class TMessageContent {
  @JsonKey(name: 'header')
  final THeader? header;
  @JsonKey(name: 'body')
  final TBody? body;

  TMessageContent({this.header, this.body});

  factory TMessageContent.fromJson(Map<String, dynamic> json) =>
      _$TMessageContentFromJson(json);
}

@JsonSerializable(createToJson: false)
class THeader {
  @JsonKey(name: 'status_code')
  final int statusCode;
  @JsonKey(name: 'hint')
  final String? hint;

  THeader({required this.statusCode, this.hint});

  factory THeader.fromJson(Map<String, dynamic> json) =>
      _$THeaderFromJson(json);
}

@JsonSerializable(createToJson: false)
class TBody {
  @JsonKey(name: 'translations_list')
  final List<TranslationsListItem>? translationsList;

  TBody({this.translationsList});

  factory TBody.fromJson(Map<String, dynamic> json) => _$TBodyFromJson(json);
}

@JsonSerializable(createToJson: false)
class TranslationsListItem {
  @JsonKey(name: 'translation')
  final Translation? translation;

  TranslationsListItem({this.translation});

  factory TranslationsListItem.fromJson(Map<String, dynamic> json) =>
      _$TranslationsListItemFromJson(json);
}

@JsonSerializable(createToJson: false)
class Translation {
  @JsonKey(name: 'language')
  final String? language;
  @JsonKey(name: 'snippet')
  final String? snippet;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'type_id')
  final String? typeId;
  @JsonKey(name: 'artist_id')
  final int? artistId;
  @JsonKey(name: 'language_from')
  final String? languageFrom;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'app_id')
  final String? appId;
  @JsonKey(name: 'position')
  final int? position;
  @JsonKey(name: 'selected_language')
  final String? selectedLanguage;
  @JsonKey(name: 'index')
  final int? index;
  @JsonKey(name: 'wantkey')
  final bool? wantkey;
  @JsonKey(name: 'create_timestamp')
  final int? createTimestamp;
  @JsonKey(name: 'type_id_weight')
  final int? typeIdWeight;
  @JsonKey(name: 'last_updated')
  final String? lastUpdated;
  @JsonKey(name: 'key')
  final String? key;
  @JsonKey(name: 'matched_line')
  final String? matchedLine;
  @JsonKey(name: 'subtitle_matched_line')
  final String? subtitleMatchedLine;
  @JsonKey(name: 'confidence')
  final double? confidence;
  @JsonKey(name: 'user_score')
  final int? userScore;
  @JsonKey(name: 'published_status_macro')
  final dynamic publishedStatusMacro;
  @JsonKey(name: 'image_id')
  final int? imageId;
  @JsonKey(name: 'video_id')
  final int? videoId;
  @JsonKey(name: 'lyrics_id')
  final int? lyricsId;
  @JsonKey(name: 'subtitle_id')
  final int? subtitleId;
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @JsonKey(name: 'commontrack_id')
  final int? commontrackId;
  @JsonKey(name: 'is_expired')
  final int? isExpired;
  @JsonKey(name: 'group_key')
  final String? groupKey;
  @JsonKey(name: 'can_delete')
  final int? canDelete;
  @JsonKey(name: 'is_mine')
  final int? isMine;
  @JsonKey(name: 'can_approve')
  final int? canApprove;
  @JsonKey(name: 'user')
  final UUser? user;
  @JsonKey(name: 'approver')
  final dynamic approver;
  @JsonKey(name: 'can_translate')
  final int? canTranslate;

  Translation({
    this.language,
    this.snippet,
    this.description,
    this.typeId,
    this.artistId,
    this.languageFrom,
    this.userId,
    this.appId,
    this.position,
    this.selectedLanguage,
    this.index,
    this.wantkey,
    this.createTimestamp,
    this.typeIdWeight,
    this.lastUpdated,
    this.key,
    this.matchedLine,
    this.subtitleMatchedLine,
    this.confidence,
    this.userScore,
    this.publishedStatusMacro,
    this.imageId,
    this.videoId,
    this.lyricsId,
    this.subtitleId,
    this.createdDate,
    this.commontrackId,
    this.isExpired,
    this.groupKey,
    this.canDelete,
    this.isMine,
    this.canApprove,
    this.user,
    this.approver,
    this.canTranslate,
  });

  factory Translation.fromJson(Map<String, dynamic> json) =>
      _$TranslationFromJson(json);
}

@JsonSerializable(createToJson: false)
class UUser {
  @JsonKey(name: 'uaid')
  final String? uaid;
  @JsonKey(name: 'is_mine')
  final int? isMine;
  @JsonKey(name: 'user_name')
  final String? userName;
  @JsonKey(name: 'user_profile_photo')
  final String? userProfilePhoto;
  @JsonKey(name: 'has_private_profile')
  final int? hasPrivateProfile;
  @JsonKey(name: 'has_informative_profile_page')
  final int? hasInformativeProfilePage;
  @JsonKey(name: 'has_distributor_profile_page')
  final int? hasDistributorProfilePage;
  @JsonKey(name: 'score')
  final int? score;
  @JsonKey(name: 'position')
  final int? position;
  @JsonKey(name: 'level')
  final String? level;
  @JsonKey(name: 'key')
  final String? key;
  @JsonKey(name: 'rank_level')
  final int? rankLevel;
  @JsonKey(name: 'rank_name')
  final String? rankName;
  @JsonKey(name: 'rank_color')
  final String? rankColor;
  @JsonKey(name: 'rank_colors')
  final RankColors? rankColors;
  @JsonKey(name: 'rank_image_url')
  final String? rankImageUrl;
  @JsonKey(name: 'weekly_score')
  final int? weeklyScore;
  @JsonKey(name: 'points_to_next_level')
  final int? pointsToNextLevel;
  @JsonKey(name: 'ratio_to_next_level')
  final double? ratioToNextLevel;
  @JsonKey(name: 'next_rank_name')
  final String? nextRankName;
  @JsonKey(name: 'ratio_to_next_rank')
  final double? ratioToNextRank;
  @JsonKey(name: 'next_rank_color')
  final String? nextRankColor;
  @JsonKey(name: 'next_rank_colors')
  final RankColors? nextRankColors;
  @JsonKey(name: 'next_rank_image_url')
  final String? nextRankImageUrl;
  @JsonKey(name: 'counters')
  final Counters? counters;
  @JsonKey(name: 'moderator_eligible')
  final bool? moderatorEligible;
  @JsonKey(name: 'artist_manager')
  final int? artistManager;
  @JsonKey(name: 'academy_completed')
  final bool? academyCompleted;
  @JsonKey(name: 'academy_completed_date')
  final String? academyCompletedDate;

  UUser({
    this.uaid,
    this.isMine,
    this.userName,
    this.userProfilePhoto,
    this.hasPrivateProfile,
    this.hasInformativeProfilePage,
    this.hasDistributorProfilePage,
    this.score,
    this.position,
    this.level,
    this.key,
    this.rankLevel,
    this.rankName,
    this.rankColor,
    this.rankColors,
    this.rankImageUrl,
    this.weeklyScore,
    this.pointsToNextLevel,
    this.ratioToNextLevel,
    this.nextRankName,
    this.ratioToNextRank,
    this.nextRankColor,
    this.nextRankColors,
    this.nextRankImageUrl,
    this.counters,
    this.moderatorEligible,
    this.artistManager,
    this.academyCompleted,
    this.academyCompletedDate,
  });

  factory UUser.fromJson(Map<String, dynamic> json) => _$UUserFromJson(json);
}

@JsonSerializable(createToJson: false)
class RankColors {
  @JsonKey(name: 'rank_color_10')
  final String? rankColor10;
  @JsonKey(name: 'rank_color_50')
  final String? rankColor50;
  @JsonKey(name: 'rank_color_100')
  final String? rankColor100;
  @JsonKey(name: 'rank_color_200')
  final String? rankColor200;
  RankColors(
      {this.rankColor10,
      this.rankColor50,
      this.rankColor100,
      this.rankColor200});
  factory RankColors.fromJson(Map<String, dynamic> json) =>
      _$RankColorsFromJson(json);
}

@JsonSerializable(createToJson: false)
class Counters {
  @JsonKey(name: 'lyrics_favourite_added')
  final int? lyricsFavouriteAdded;
  @JsonKey(name: 'lyrics_subtitle_added')
  final int? lyricsSubtitleAdded;
  @JsonKey(name: 'lyrics_generic_ko')
  final int? lyricsGenericKo;
  @JsonKey(name: 'lyrics_missing')
  final int? lyricsMissing;
  @JsonKey(name: 'lyrics_changed')
  final int? lyricsChanged;
  @JsonKey(name: 'lyrics_ok')
  final int? lyricsOk;
  @JsonKey(name: 'lyrics_to_add')
  final int? lyricsToAdd;
  @JsonKey(name: 'lyrics_ko')
  final int? lyricsKo;
  @JsonKey(name: 'lyrics_music_id')
  final int? lyricsMusicId;
  @JsonKey(name: 'vote_bonuses')
  final int? voteBonuses;
  @JsonKey(name: 'track_translation')
  final int? trackTranslation;
  @JsonKey(name: 'vote_maluses')
  final int? voteMaluses;
  @JsonKey(name: 'lyrics_ai_incorrect_text_no')
  final int? lyricsAiIncorrectTextNo;
  @JsonKey(name: 'lyrics_ai_completely_wrong_skip')
  final int? lyricsAiCompletelyWrongSkip;
  @JsonKey(name: 'lyrics_ai_incorrect_text_yes')
  final int? lyricsAiIncorrectTextYes;
  @JsonKey(name: 'lyrics_ai_phrases_not_related_yes')
  final int? lyricsAiPhrasesNotRelatedYes;
  @JsonKey(name: 'lyrics_implicitly_ok')
  final int? lyricsImplicitlyOk;
  @JsonKey(name: 'lyrics_report_completely_wrong')
  final int? lyricsReportCompletelyWrong;
  @JsonKey(name: 'lyrics_richsync_added')
  final int? lyricsRichsyncAdded;
  @JsonKey(name: 'track_influencer_bonus_moderator_vote')
  final int? trackInfluencerBonusModeratorVote;
  @JsonKey(name: 'lyrics_ai_mood_analysis_v3_value')
  final int? lyricsAiMoodAnalysisV3Value;
  @JsonKey(name: 'lyrics_ai_ugc_language')
  final int? lyricsAiUgcLanguage;
  @JsonKey(name: 'lyrics_ranking_change')
  final int? lyricsRankingChange;
  @JsonKey(name: 'track_structure')
  final int? trackStructure;
  @JsonKey(name: 'track_complete_metadata')
  final int? trackCompleteMetadata;
  @JsonKey(name: 'evaluation_academy_test')
  final int? evaluationAcademyTest;
  @JsonKey(name: 'lyrics_report_contain_mistakes')
  final int? lyricsReportContainMistakes;

  Counters({
    this.lyricsFavouriteAdded,
    this.lyricsSubtitleAdded,
    this.lyricsGenericKo,
    this.lyricsMissing,
    this.lyricsChanged,
    this.lyricsOk,
    this.lyricsToAdd,
    this.lyricsKo,
    this.lyricsMusicId,
    this.voteBonuses,
    this.trackTranslation,
    this.voteMaluses,
    this.lyricsAiIncorrectTextNo,
    this.lyricsAiCompletelyWrongSkip,
    this.lyricsAiIncorrectTextYes,
    this.lyricsAiPhrasesNotRelatedYes,
    this.lyricsImplicitlyOk,
    this.lyricsReportCompletelyWrong,
    this.lyricsRichsyncAdded,
    this.trackInfluencerBonusModeratorVote,
    this.lyricsAiMoodAnalysisV3Value,
    this.lyricsAiUgcLanguage,
    this.lyricsRankingChange,
    this.trackStructure,
    this.trackCompleteMetadata,
    this.evaluationAcademyTest,
    this.lyricsReportContainMistakes,
  });

  factory Counters.fromJson(Map<String, dynamic> json) =>
      _$CountersFromJson(json);
}

//-=-=-=-=-=-=-= Common Models =-=-=-=-=-=-=-

@JsonSerializable(createToJson: false)
class MessageContent {
  @JsonKey(name: 'header')
  final Header? header;
  @JsonKey(name: 'body')
  final Body? body;

  MessageContent({this.header, this.body});

  factory MessageContent.fromJson(Map<String, dynamic> json) =>
      _$MessageContentFromJson(json);
}

@JsonSerializable(createToJson: false)
class Header {
  @JsonKey(name: 'status_code')
  final int statusCode;
  @JsonKey(name: 'hint')
  final String? hint;
  @JsonKey(name: 'execute_time')
  final double? executeTime;
  @JsonKey(name: 'pid')
  final int? pid;
  @JsonKey(name: 'surrogate_key_list')
  final List<dynamic>? surrogateKeyList;

  Header({
    required this.statusCode,
    this.hint,
    this.executeTime,
    this.pid,
    this.surrogateKeyList,
  });

  factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);
}

@JsonSerializable(createToJson: false)
class Body {
  // For GetTokenResponse
  @JsonKey(name: 'user_token')
  final String? userToken;

  // For GetTrackResponse
  @JsonKey(name: 'track')
  final Track? track;

  @JsonKey(name: 'app_config')
  final AppConfig? appConfig;
  @JsonKey(name: 'location')
  final Location? location;

  Body({
    this.userToken,
    this.track,
    this.appConfig,
    this.location,
  });

  factory Body.fromJson(Map<String, dynamic> json) => _$BodyFromJson(json);
}

@JsonSerializable(createToJson: false)
class Track {
  @JsonKey(name: 'track_id')
  final int trackId;
  @JsonKey(name: 'track_name')
  final String trackName;
  @JsonKey(name: 'artist_id')
  final int artistId;
  @JsonKey(name: 'artist_name')
  final String artistName;
  @JsonKey(name: 'commontrack_id')
  final int commonTrackId;
  @JsonKey(name: 'has_richsync')
  final int hasRichsync;
  @JsonKey(name: 'has_subtitles')
  final int hasSubtitles;
  @JsonKey(name: 'track_mbid')
  final String? trackMbid;
  @JsonKey(name: 'track_isrc')
  final String? trackIsrc;
  @JsonKey(name: 'commontrack_isrcs')
  final List<List<String>>? commontrackIsrcs;
  @JsonKey(name: 'track_spotify_id')
  final String? trackSpotifyId;
  @JsonKey(name: 'commontrack_spotify_ids')
  final List<String>? commontrackSpotifyIds;
  @JsonKey(name: 'track_soundcloud_id')
  final int? trackSoundcloudId;
  @JsonKey(name: 'track_xboxmusic_id')
  final String? trackXboxmusicId;
  @JsonKey(name: 'track_rating')
  final int? trackRating;
  @JsonKey(name: 'track_length')
  final int? trackLength;
  @JsonKey(name: 'instrumental')
  final int? instrumental;
  @JsonKey(name: 'explicit')
  final int? explicit;
  @JsonKey(name: 'has_lyrics')
  final int? hasLyrics;
  @JsonKey(name: 'has_lyrics_crowd')
  final int? hasLyricsCrowd;
  @JsonKey(name: 'has_track_structure')
  final int? hasTrackStructure;
  @JsonKey(name: 'num_favourite')
  final int? numFavourite;
  @JsonKey(name: 'lyrics_id')
  final int? lyricsId;
  @JsonKey(name: 'subtitle_id')
  final int? subtitleId;
  @JsonKey(name: 'album_id')
  final int? albumId;
  @JsonKey(name: 'album_name')
  final String? albumName;
  @JsonKey(name: 'album_vanity_id')
  final String? albumVanityId;
  @JsonKey(name: 'album_coverart_100x100')
  final String? albumCoverart100x100;
  @JsonKey(name: 'album_coverart_350x350')
  final String? albumCoverart350x350;
  @JsonKey(name: 'album_coverart_500x500')
  final String? albumCoverart500x500;
  @JsonKey(name: 'album_coverart_800x800')
  final String? albumCoverart800x800;
  @JsonKey(name: 'track_share_url')
  final String? trackShareUrl;
  @JsonKey(name: 'track_edit_url')
  final String? trackEditUrl;
  @JsonKey(name: 'restricted')
  final int? restricted;
  @JsonKey(name: 'first_release_date')
  final String? firstReleaseDate;
  @JsonKey(name: 'updated_time')
  final String? updatedTime;
  @JsonKey(name: 'track_name_translation_list')
  final List<TrackNameTranslationList>? trackNameTranslationList;
  @JsonKey(name: 'primary_genres')
  final PrimaryGenres? primaryGenres;
  @JsonKey(name: 'secondary_genres')
  final SecondaryGenres? secondaryGenres;

  Track({
    required this.trackId,
    required this.trackName,
    required this.artistId,
    required this.artistName,
    required this.commonTrackId,
    required this.hasRichsync,
    required this.hasSubtitles,
    this.trackMbid,
    this.trackIsrc,
    this.commontrackIsrcs,
    this.trackSpotifyId,
    this.commontrackSpotifyIds,
    this.trackSoundcloudId,
    this.trackXboxmusicId,
    this.trackRating,
    this.trackLength,
    this.instrumental,
    this.explicit,
    this.hasLyrics,
    this.hasLyricsCrowd,
    this.hasTrackStructure,
    this.numFavourite,
    this.lyricsId,
    this.subtitleId,
    this.albumId,
    this.albumName,
    this.albumVanityId,
    this.albumCoverart100x100,
    this.albumCoverart350x350,
    this.albumCoverart500x500,
    this.albumCoverart800x800,
    this.trackShareUrl,
    this.trackEditUrl,
    this.restricted,
    this.firstReleaseDate,
    this.updatedTime,
    this.trackNameTranslationList,
    this.primaryGenres,
    this.secondaryGenres,
  });

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
}

@JsonSerializable(createToJson: false)
class TrackNameTranslationList {
  @JsonKey(name: 'track_name_translation')
  final TrackNameTranslation? trackNameTranslation;

  TrackNameTranslationList({this.trackNameTranslation});

  factory TrackNameTranslationList.fromJson(Map<String, dynamic> json) =>
      _$TrackNameTranslationListFromJson(json);
}

@JsonSerializable(createToJson: false)
class TrackNameTranslation {
  @JsonKey(name: 'language')
  final String? language;
  @JsonKey(name: 'translation')
  final String? translation;

  TrackNameTranslation({this.language, this.translation});

  factory TrackNameTranslation.fromJson(Map<String, dynamic> json) =>
      _$TrackNameTranslationFromJson(json);
}

@JsonSerializable(createToJson: false)
class PrimaryGenres {
  @JsonKey(name: 'music_genre_list')
  final List<MusicGenreList>? musicGenreList;

  PrimaryGenres({this.musicGenreList});

  factory PrimaryGenres.fromJson(Map<String, dynamic> json) =>
      _$PrimaryGenresFromJson(json);
}

@JsonSerializable(createToJson: false)
class MusicGenreList {
  @JsonKey(name: 'music_genre')
  final MusicGenre? musicGenre;

  MusicGenreList({this.musicGenre});

  factory MusicGenreList.fromJson(Map<String, dynamic> json) =>
      _$MusicGenreListFromJson(json);
}

@JsonSerializable(createToJson: false)
class MusicGenre {
  @JsonKey(name: 'music_genre_id')
  final int? musicGenreId;
  @JsonKey(name: 'music_genre_parent_id')
  final int? musicGenreParentId;
  @JsonKey(name: 'music_genre_name')
  final String? musicGenreName;
  @JsonKey(name: 'music_genre_name_extended')
  final String? musicGenreNameExtended;
  @JsonKey(name: 'music_genre_vanity')
  final String? musicGenreVanity;

  MusicGenre({
    this.musicGenreId,
    this.musicGenreParentId,
    this.musicGenreName,
    this.musicGenreNameExtended,
    this.musicGenreVanity,
  });

  factory MusicGenre.fromJson(Map<String, dynamic> json) =>
      _$MusicGenreFromJson(json);
}

@JsonSerializable(createToJson: false)
class SecondaryGenres {
  @JsonKey(name: 'music_genre_list')
  final List<MusicGenreList>? musicGenreList;

  SecondaryGenres({this.musicGenreList});

  factory SecondaryGenres.fromJson(Map<String, dynamic> json) =>
      _$SecondaryGenresFromJson(json);
}

@JsonSerializable(createToJson: false)
class AppConfig {
  @JsonKey(name: 'trial')
  final bool? trial;
  @JsonKey(name: 'mobilePopOverMaximum')
  final int? mobilePopOverMaximum;
  @JsonKey(name: 'mobilePopOverMinTimes')
  final int? mobilePopOverMinTimes;
  @JsonKey(name: 'mobilePopOverMaxTimes')
  final int? mobilePopOverMaxTimes;
  @JsonKey(name: 'isRoviCopyEnabled')
  final bool? isRoviCopyEnabled;
  @JsonKey(name: 'isGettyCopyEnabled')
  final bool? isGettyCopyEnabled;
  @JsonKey(name: 'searchMaxResults')
  final int? searchMaxResults;
  @JsonKey(name: 'fbShareUrlSpotify')
  final bool? fbShareUrlSpotify;
  @JsonKey(name: 'twShareUrlSpotify')
  final bool? twShareUrlSpotify;
  @JsonKey(name: 'fbPostTimeline')
  final bool? fbPostTimeline;
  @JsonKey(name: 'fbOpenGraph')
  final bool? fbOpenGraph;
  @JsonKey(name: 'subtitlesMaxDeviation')
  final int? subtitlesMaxDeviation;
  @JsonKey(name: 'localeDefaultLang')
  final String? localeDefaultLang;
  @JsonKey(name: 'missionEnable')
  final bool? missionEnable;
  @JsonKey(name: 'content_team')
  final bool? contentTeam;
  @JsonKey(name: 'missions')
  final Missions? missions;
  @JsonKey(name: 'mission_manager_categories')
  final MissionManagerCategories? missionManagerCategories;
  @JsonKey(name: 'appstore_products')
  final List<dynamic>? appstoreProducts;
  @JsonKey(name: 'tracking_list')
  final List<TrackingList>? trackingList;
  @JsonKey(name: 'spotifyCountries')
  final List<String>? spotifyCountries;
  @JsonKey(name: 'service_list')
  final List<ServiceList>? serviceList;
  @JsonKey(name: 'show_amazon_music')
  final bool? showAmazonMusic;
  @JsonKey(name: 'isSentryEnabled')
  final bool? isSentryEnabled;
  @JsonKey(name: 'languages')
  final List<String>? languages;
  @JsonKey(name: 'last_updated')
  final String? lastUpdated;
  @JsonKey(name: 'cluster')
  final String? cluster;
  @JsonKey(name: 'event_map')
  final List<EventMap>? eventMap;
  @JsonKey(name: 'mission_report_types')
  final List<String>? missionReportTypes;
  @JsonKey(name: 'can_show_performers_tag')
  final bool? canShowPerformersTag;
  @JsonKey(name: 'smart_translations')
  final SmartTranslations? smartTranslations;
  @JsonKey(name: 'audio_upload')
  final bool? audioUpload;

  AppConfig({
    this.trial,
    this.mobilePopOverMaximum,
    this.mobilePopOverMinTimes,
    this.mobilePopOverMaxTimes,
    this.isRoviCopyEnabled,
    this.isGettyCopyEnabled,
    this.searchMaxResults,
    this.fbShareUrlSpotify,
    this.twShareUrlSpotify,
    this.fbPostTimeline,
    this.fbOpenGraph,
    this.subtitlesMaxDeviation,
    this.localeDefaultLang,
    this.missionEnable,
    this.contentTeam,
    this.missions,
    this.missionManagerCategories,
    this.appstoreProducts,
    this.trackingList,
    this.spotifyCountries,
    this.serviceList,
    this.showAmazonMusic,
    this.isSentryEnabled,
    this.languages,
    this.lastUpdated,
    this.cluster,
    this.eventMap,
    this.missionReportTypes,
    this.canShowPerformersTag,
    this.smartTranslations,
    this.audioUpload,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
}

@JsonSerializable(createToJson: false)
class Missions {
  @JsonKey(name: 'enabled')
  final bool? enabled;
  @JsonKey(name: 'community')
  final List<String>? community;
  Missions({this.enabled, this.community});
  factory Missions.fromJson(Map<String, dynamic> json) =>
      _$MissionsFromJson(json);
}

@JsonSerializable(createToJson: false)
class MissionManagerCategories {
  @JsonKey(name: 'taskTypes')
  final List<TaskType>? taskTypes;
  @JsonKey(name: 'audioSources')
  final List<AudioSource>? audioSources;
  @JsonKey(name: 'userGroups')
  final List<UserGroup>? userGroups;
  @JsonKey(name: 'rewards')
  final List<Reward>? rewards;
  MissionManagerCategories(
      {this.taskTypes, this.audioSources, this.userGroups, this.rewards});
  factory MissionManagerCategories.fromJson(Map<String, dynamic> json) =>
      _$MissionManagerCategoriesFromJson(json);
}

@JsonSerializable(createToJson: false)
class TaskType {
  @JsonKey(name: 'value')
  final String? value;
  @JsonKey(name: 'label')
  final String? label;
  TaskType({this.value, this.label});
  factory TaskType.fromJson(Map<String, dynamic> json) =>
      _$TaskTypeFromJson(json);
}

@JsonSerializable(createToJson: false)
class AudioSource {
  @JsonKey(name: 'value')
  final String? value;
  @JsonKey(name: 'label')
  final String? label;
  AudioSource({this.value, this.label});
  factory AudioSource.fromJson(Map<String, dynamic> json) =>
      _$AudioSourceFromJson(json);
}

@JsonSerializable(createToJson: false)
class UserGroup {
  @JsonKey(name: 'value')
  final String? value;
  @JsonKey(name: 'label')
  final String? label;
  UserGroup({this.value, this.label});
  factory UserGroup.fromJson(Map<String, dynamic> json) =>
      _$UserGroupFromJson(json);
}

@JsonSerializable(createToJson: false)
class Reward {
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'value')
  final String? value;
  Reward({this.label, this.value});
  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);
}

@JsonSerializable(createToJson: false)
class TrackingList {
  @JsonKey(name: 'tracking')
  final Tracking? tracking;
  TrackingList({this.tracking});
  factory TrackingList.fromJson(Map<String, dynamic> json) =>
      _$TrackingListFromJson(json);
}

@JsonSerializable(createToJson: false)
class Tracking {
  @JsonKey(name: 'context')
  final String? context;
  @JsonKey(name: 'delay')
  final int? delay;
  @JsonKey(name: 'track_cache_ttl')
  final int? trackCacheTtl;
  Tracking({this.context, this.delay, this.trackCacheTtl});
  factory Tracking.fromJson(Map<String, dynamic> json) =>
      _$TrackingFromJson(json);
}

@JsonSerializable(createToJson: false)
class ServiceList {
  @JsonKey(name: 'service')
  final Service? service;
  ServiceList({this.service});
  factory ServiceList.fromJson(Map<String, dynamic> json) =>
      _$ServiceListFromJson(json);
}

@JsonSerializable(createToJson: false)
class Service {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'oauth_api')
  final bool? oauthApi;
  @JsonKey(name: 'oauth_web_signin')
  final OauthWebSignin? oauthWebSignin;
  @JsonKey(name: 'streaming')
  final bool? streaming;
  @JsonKey(name: 'playlist')
  final bool? playlist;
  @JsonKey(name: 'locker')
  final bool? locker;
  @JsonKey(name: 'deeplink')
  final bool? deeplink;
  Service({
    this.name,
    this.displayName,
    this.type,
    this.oauthApi,
    this.oauthWebSignin,
    this.streaming,
    this.playlist,
    this.locker,
    this.deeplink,
  });
  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
}

@JsonSerializable(createToJson: false)
class OauthWebSignin {
  @JsonKey(name: 'enabled')
  final bool? enabled;
  @JsonKey(name: 'user_prefix')
  final String? userPrefix;
  OauthWebSignin({this.enabled, this.userPrefix});
  factory OauthWebSignin.fromJson(Map<String, dynamic> json) =>
      _$OauthWebSigninFromJson(json);
}

@JsonSerializable(createToJson: false)
class EventMap {
  @JsonKey(name: 'regex')
  final String? regex;
  @JsonKey(name: 'enabled')
  final bool? enabled;
  @JsonKey(name: 'piggyback')
  final Piggyback? piggyback;
  EventMap({this.regex, this.enabled, this.piggyback});
  factory EventMap.fromJson(Map<String, dynamic> json) =>
      _$EventMapFromJson(json);
}

@JsonSerializable(createToJson: false)
class Piggyback {
  @JsonKey(name: 'server_weight')
  final int? serverWeight;
  Piggyback({this.serverWeight});
  factory Piggyback.fromJson(Map<String, dynamic> json) =>
      _$PiggybackFromJson(json);
}

@JsonSerializable(createToJson: false)
class SmartTranslations {
  @JsonKey(name: 'enabled')
  final bool? enabled;
  @JsonKey(name: 'threshold')
  final int? threshold;
  SmartTranslations({this.enabled, this.threshold});
  factory SmartTranslations.fromJson(Map<String, dynamic> json) =>
      _$SmartTranslationsFromJson(json);
}

@JsonSerializable(createToJson: false)
class Location {
  @JsonKey(name: 'GEOIP_CITY_COUNTRY_CODE')
  final String? geoIPCityCountryCode;
  @JsonKey(name: 'GEOIP_CITY_COUNTRY_CODE3')
  final String? geoIPCityCountryCode3;
  @JsonKey(name: 'GEOIP_CITY_COUNTRY_NAME')
  final String? geoIPCityCountryName;
  @JsonKey(name: 'GEOIP_CITY')
  final String? geoIPCity;
  @JsonKey(name: 'GEOIP_CITY_CONTINENT_CODE')
  final String? geoIPCityContinentCode;
  @JsonKey(name: 'GEOIP_LATITUDE')
  final double? geoIPLatitude;
  @JsonKey(name: 'GEOIP_LONGITUDE')
  final double? geoIPLongitude;
  @JsonKey(name: 'GEOIP_AS_ORG')
  final String? geoIPAsOrg;
  @JsonKey(name: 'GEOIP_ORG')
  final String? geoIPOrg;
  @JsonKey(name: 'GEOIP_ISP')
  final String? geoIPIsp;
  @JsonKey(name: 'GEOIP_NET_NAME')
  final String? geoIPNetName;
  @JsonKey(name: 'BADIP_TAGS')
  final List<dynamic>? badipTags;
  Location({
    this.geoIPCityCountryCode,
    this.geoIPCityCountryCode3,
    this.geoIPCityCountryName,
    this.geoIPCity,
    this.geoIPCityContinentCode,
    this.geoIPLatitude,
    this.geoIPLongitude,
    this.geoIPAsOrg,
    this.geoIPOrg,
    this.geoIPIsp,
    this.geoIPNetName,
    this.badipTags,
  });
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
