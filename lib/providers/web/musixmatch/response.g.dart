// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTokenResponse _$GetTokenResponseFromJson(Map<String, dynamic> json) =>
    GetTokenResponse(
      message: json['message'] == null
          ? null
          : MessageContent.fromJson(json['message'] as Map<String, dynamic>),
    );

GetTrackResponse _$GetTrackResponseFromJson(Map<String, dynamic> json) =>
    GetTrackResponse(
      message: json['message'] == null
          ? null
          : MessageContent.fromJson(json['message'] as Map<String, dynamic>),
    );

GetTranslationsResponse _$GetTranslationsResponseFromJson(
        Map<String, dynamic> json) =>
    GetTranslationsResponse(
      message: json['message'] == null
          ? null
          : TMessageContent.fromJson(json['message'] as Map<String, dynamic>),
    );

TMessageContent _$TMessageContentFromJson(Map<String, dynamic> json) =>
    TMessageContent(
      header: json['header'] == null
          ? null
          : THeader.fromJson(json['header'] as Map<String, dynamic>),
      body: json['body'] == null
          ? null
          : TBody.fromJson(json['body'] as Map<String, dynamic>),
    );

THeader _$THeaderFromJson(Map<String, dynamic> json) => THeader(
      statusCode: (json['status_code'] as num).toInt(),
      hint: json['hint'] as String?,
    );

TBody _$TBodyFromJson(Map<String, dynamic> json) => TBody(
      translationsList: (json['translations_list'] as List<dynamic>?)
          ?.map((e) => TranslationsListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

TranslationsListItem _$TranslationsListItemFromJson(
        Map<String, dynamic> json) =>
    TranslationsListItem(
      translation: json['translation'] == null
          ? null
          : Translation.fromJson(json['translation'] as Map<String, dynamic>),
    );

Translation _$TranslationFromJson(Map<String, dynamic> json) => Translation(
      language: json['language'] as String?,
      snippet: json['snippet'] as String?,
      description: json['description'] as String?,
      typeId: json['type_id'] as String?,
      artistId: (json['artist_id'] as num?)?.toInt(),
      languageFrom: json['language_from'] as String?,
      userId: json['user_id'] as String?,
      appId: json['app_id'] as String?,
      position: (json['position'] as num?)?.toInt(),
      selectedLanguage: json['selected_language'] as String?,
      index: (json['index'] as num?)?.toInt(),
      wantkey: json['wantkey'] as bool?,
      createTimestamp: (json['create_timestamp'] as num?)?.toInt(),
      typeIdWeight: (json['type_id_weight'] as num?)?.toInt(),
      lastUpdated: json['last_updated'] as String?,
      key: json['key'] as String?,
      matchedLine: json['matched_line'] as String?,
      subtitleMatchedLine: json['subtitle_matched_line'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble(),
      userScore: (json['user_score'] as num?)?.toInt(),
      publishedStatusMacro: json['published_status_macro'],
      imageId: (json['image_id'] as num?)?.toInt(),
      videoId: (json['video_id'] as num?)?.toInt(),
      lyricsId: (json['lyrics_id'] as num?)?.toInt(),
      subtitleId: (json['subtitle_id'] as num?)?.toInt(),
      createdDate: json['created_date'] as String?,
      commontrackId: (json['commontrack_id'] as num?)?.toInt(),
      isExpired: (json['is_expired'] as num?)?.toInt(),
      groupKey: json['group_key'] as String?,
      canDelete: (json['can_delete'] as num?)?.toInt(),
      isMine: (json['is_mine'] as num?)?.toInt(),
      canApprove: (json['can_approve'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : UUser.fromJson(json['user'] as Map<String, dynamic>),
      approver: json['approver'],
      canTranslate: (json['can_translate'] as num?)?.toInt(),
    );

UUser _$UUserFromJson(Map<String, dynamic> json) => UUser(
      uaid: json['uaid'] as String?,
      isMine: (json['is_mine'] as num?)?.toInt(),
      userName: json['user_name'] as String?,
      userProfilePhoto: json['user_profile_photo'] as String?,
      hasPrivateProfile: (json['has_private_profile'] as num?)?.toInt(),
      hasInformativeProfilePage:
          (json['has_informative_profile_page'] as num?)?.toInt(),
      hasDistributorProfilePage:
          (json['has_distributor_profile_page'] as num?)?.toInt(),
      score: (json['score'] as num?)?.toInt(),
      position: (json['position'] as num?)?.toInt(),
      level: json['level'] as String?,
      key: json['key'] as String?,
      rankLevel: (json['rank_level'] as num?)?.toInt(),
      rankName: json['rank_name'] as String?,
      rankColor: json['rank_color'] as String?,
      rankColors: json['rank_colors'] == null
          ? null
          : RankColors.fromJson(json['rank_colors'] as Map<String, dynamic>),
      rankImageUrl: json['rank_image_url'] as String?,
      weeklyScore: (json['weekly_score'] as num?)?.toInt(),
      pointsToNextLevel: (json['points_to_next_level'] as num?)?.toInt(),
      ratioToNextLevel: (json['ratio_to_next_level'] as num?)?.toDouble(),
      nextRankName: json['next_rank_name'] as String?,
      ratioToNextRank: (json['ratio_to_next_rank'] as num?)?.toDouble(),
      nextRankColor: json['next_rank_color'] as String?,
      nextRankColors: json['next_rank_colors'] == null
          ? null
          : RankColors.fromJson(
              json['next_rank_colors'] as Map<String, dynamic>),
      nextRankImageUrl: json['next_rank_image_url'] as String?,
      counters: json['counters'] == null
          ? null
          : Counters.fromJson(json['counters'] as Map<String, dynamic>),
      moderatorEligible: json['moderator_eligible'] as bool?,
      artistManager: (json['artist_manager'] as num?)?.toInt(),
      academyCompleted: json['academy_completed'] as bool?,
      academyCompletedDate: json['academy_completed_date'] as String?,
    );

RankColors _$RankColorsFromJson(Map<String, dynamic> json) => RankColors(
      rankColor10: json['rank_color_10'] as String?,
      rankColor50: json['rank_color_50'] as String?,
      rankColor100: json['rank_color_100'] as String?,
      rankColor200: json['rank_color_200'] as String?,
    );

Counters _$CountersFromJson(Map<String, dynamic> json) => Counters(
      lyricsFavouriteAdded: (json['lyrics_favourite_added'] as num?)?.toInt(),
      lyricsSubtitleAdded: (json['lyrics_subtitle_added'] as num?)?.toInt(),
      lyricsGenericKo: (json['lyrics_generic_ko'] as num?)?.toInt(),
      lyricsMissing: (json['lyrics_missing'] as num?)?.toInt(),
      lyricsChanged: (json['lyrics_changed'] as num?)?.toInt(),
      lyricsOk: (json['lyrics_ok'] as num?)?.toInt(),
      lyricsToAdd: (json['lyrics_to_add'] as num?)?.toInt(),
      lyricsKo: (json['lyrics_ko'] as num?)?.toInt(),
      lyricsMusicId: (json['lyrics_music_id'] as num?)?.toInt(),
      voteBonuses: (json['vote_bonuses'] as num?)?.toInt(),
      trackTranslation: (json['track_translation'] as num?)?.toInt(),
      voteMaluses: (json['vote_maluses'] as num?)?.toInt(),
      lyricsAiIncorrectTextNo:
          (json['lyrics_ai_incorrect_text_no'] as num?)?.toInt(),
      lyricsAiCompletelyWrongSkip:
          (json['lyrics_ai_completely_wrong_skip'] as num?)?.toInt(),
      lyricsAiIncorrectTextYes:
          (json['lyrics_ai_incorrect_text_yes'] as num?)?.toInt(),
      lyricsAiPhrasesNotRelatedYes:
          (json['lyrics_ai_phrases_not_related_yes'] as num?)?.toInt(),
      lyricsImplicitlyOk: (json['lyrics_implicitly_ok'] as num?)?.toInt(),
      lyricsReportCompletelyWrong:
          (json['lyrics_report_completely_wrong'] as num?)?.toInt(),
      lyricsRichsyncAdded: (json['lyrics_richsync_added'] as num?)?.toInt(),
      trackInfluencerBonusModeratorVote:
          (json['track_influencer_bonus_moderator_vote'] as num?)?.toInt(),
      lyricsAiMoodAnalysisV3Value:
          (json['lyrics_ai_mood_analysis_v3_value'] as num?)?.toInt(),
      lyricsAiUgcLanguage: (json['lyrics_ai_ugc_language'] as num?)?.toInt(),
      lyricsRankingChange: (json['lyrics_ranking_change'] as num?)?.toInt(),
      trackStructure: (json['track_structure'] as num?)?.toInt(),
      trackCompleteMetadata: (json['track_complete_metadata'] as num?)?.toInt(),
      evaluationAcademyTest: (json['evaluation_academy_test'] as num?)?.toInt(),
      lyricsReportContainMistakes:
          (json['lyrics_report_contain_mistakes'] as num?)?.toInt(),
    );

MessageContent _$MessageContentFromJson(Map<String, dynamic> json) =>
    MessageContent(
      header: json['header'] == null
          ? null
          : Header.fromJson(json['header'] as Map<String, dynamic>),
      body: json['body'] == null
          ? null
          : Body.fromJson(json['body'] as Map<String, dynamic>),
    );

Header _$HeaderFromJson(Map<String, dynamic> json) => Header(
      statusCode: (json['status_code'] as num).toInt(),
      hint: json['hint'] as String?,
      executeTime: (json['execute_time'] as num?)?.toDouble(),
      pid: (json['pid'] as num?)?.toInt(),
      surrogateKeyList: json['surrogate_key_list'] as List<dynamic>?,
    );

Body _$BodyFromJson(Map<String, dynamic> json) => Body(
      userToken: json['user_token'] as String?,
      track: json['track'] == null
          ? null
          : Track.fromJson(json['track'] as Map<String, dynamic>),
      appConfig: json['app_config'] == null
          ? null
          : AppConfig.fromJson(json['app_config'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Track _$TrackFromJson(Map<String, dynamic> json) => Track(
      trackId: (json['track_id'] as num).toInt(),
      trackName: json['track_name'] as String,
      artistId: (json['artist_id'] as num).toInt(),
      artistName: json['artist_name'] as String,
      commonTrackId: (json['commontrack_id'] as num).toInt(),
      hasRichsync: (json['has_richsync'] as num).toInt(),
      hasSubtitles: (json['has_subtitles'] as num).toInt(),
      trackMbid: json['track_mbid'] as String?,
      trackIsrc: json['track_isrc'] as String?,
      commontrackIsrcs: (json['commontrack_isrcs'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      trackSpotifyId: json['track_spotify_id'] as String?,
      commontrackSpotifyIds: (json['commontrack_spotify_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      trackSoundcloudId: (json['track_soundcloud_id'] as num?)?.toInt(),
      trackXboxmusicId: json['track_xboxmusic_id'] as String?,
      trackRating: (json['track_rating'] as num?)?.toInt(),
      trackLength: (json['track_length'] as num?)?.toInt(),
      instrumental: (json['instrumental'] as num?)?.toInt(),
      explicit: (json['explicit'] as num?)?.toInt(),
      hasLyrics: (json['has_lyrics'] as num?)?.toInt(),
      hasLyricsCrowd: (json['has_lyrics_crowd'] as num?)?.toInt(),
      hasTrackStructure: (json['has_track_structure'] as num?)?.toInt(),
      numFavourite: (json['num_favourite'] as num?)?.toInt(),
      lyricsId: (json['lyrics_id'] as num?)?.toInt(),
      subtitleId: (json['subtitle_id'] as num?)?.toInt(),
      albumId: (json['album_id'] as num?)?.toInt(),
      albumName: json['album_name'] as String?,
      albumVanityId: json['album_vanity_id'] as String?,
      albumCoverart100x100: json['album_coverart_100x100'] as String?,
      albumCoverart350x350: json['album_coverart_350x350'] as String?,
      albumCoverart500x500: json['album_coverart_500x500'] as String?,
      albumCoverart800x800: json['album_coverart_800x800'] as String?,
      trackShareUrl: json['track_share_url'] as String?,
      trackEditUrl: json['track_edit_url'] as String?,
      restricted: (json['restricted'] as num?)?.toInt(),
      firstReleaseDate: json['first_release_date'] as String?,
      updatedTime: json['updated_time'] as String?,
      trackNameTranslationList:
          (json['track_name_translation_list'] as List<dynamic>?)
              ?.map((e) =>
                  TrackNameTranslationList.fromJson(e as Map<String, dynamic>))
              .toList(),
      primaryGenres: json['primary_genres'] == null
          ? null
          : PrimaryGenres.fromJson(
              json['primary_genres'] as Map<String, dynamic>),
      secondaryGenres: json['secondary_genres'] == null
          ? null
          : SecondaryGenres.fromJson(
              json['secondary_genres'] as Map<String, dynamic>),
    );

TrackNameTranslationList _$TrackNameTranslationListFromJson(
        Map<String, dynamic> json) =>
    TrackNameTranslationList(
      trackNameTranslation: json['track_name_translation'] == null
          ? null
          : TrackNameTranslation.fromJson(
              json['track_name_translation'] as Map<String, dynamic>),
    );

TrackNameTranslation _$TrackNameTranslationFromJson(
        Map<String, dynamic> json) =>
    TrackNameTranslation(
      language: json['language'] as String?,
      translation: json['translation'] as String?,
    );

PrimaryGenres _$PrimaryGenresFromJson(Map<String, dynamic> json) =>
    PrimaryGenres(
      musicGenreList: (json['music_genre_list'] as List<dynamic>?)
          ?.map((e) => MusicGenreList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

MusicGenreList _$MusicGenreListFromJson(Map<String, dynamic> json) =>
    MusicGenreList(
      musicGenre: json['music_genre'] == null
          ? null
          : MusicGenre.fromJson(json['music_genre'] as Map<String, dynamic>),
    );

MusicGenre _$MusicGenreFromJson(Map<String, dynamic> json) => MusicGenre(
      musicGenreId: (json['music_genre_id'] as num?)?.toInt(),
      musicGenreParentId: (json['music_genre_parent_id'] as num?)?.toInt(),
      musicGenreName: json['music_genre_name'] as String?,
      musicGenreNameExtended: json['music_genre_name_extended'] as String?,
      musicGenreVanity: json['music_genre_vanity'] as String?,
    );

SecondaryGenres _$SecondaryGenresFromJson(Map<String, dynamic> json) =>
    SecondaryGenres(
      musicGenreList: (json['music_genre_list'] as List<dynamic>?)
          ?.map((e) => MusicGenreList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
      trial: json['trial'] as bool?,
      mobilePopOverMaximum: (json['mobilePopOverMaximum'] as num?)?.toInt(),
      mobilePopOverMinTimes: (json['mobilePopOverMinTimes'] as num?)?.toInt(),
      mobilePopOverMaxTimes: (json['mobilePopOverMaxTimes'] as num?)?.toInt(),
      isRoviCopyEnabled: json['isRoviCopyEnabled'] as bool?,
      isGettyCopyEnabled: json['isGettyCopyEnabled'] as bool?,
      searchMaxResults: (json['searchMaxResults'] as num?)?.toInt(),
      fbShareUrlSpotify: json['fbShareUrlSpotify'] as bool?,
      twShareUrlSpotify: json['twShareUrlSpotify'] as bool?,
      fbPostTimeline: json['fbPostTimeline'] as bool?,
      fbOpenGraph: json['fbOpenGraph'] as bool?,
      subtitlesMaxDeviation: (json['subtitlesMaxDeviation'] as num?)?.toInt(),
      localeDefaultLang: json['localeDefaultLang'] as String?,
      missionEnable: json['missionEnable'] as bool?,
      contentTeam: json['content_team'] as bool?,
      missions: json['missions'] == null
          ? null
          : Missions.fromJson(json['missions'] as Map<String, dynamic>),
      missionManagerCategories: json['mission_manager_categories'] == null
          ? null
          : MissionManagerCategories.fromJson(
              json['mission_manager_categories'] as Map<String, dynamic>),
      appstoreProducts: json['appstore_products'] as List<dynamic>?,
      trackingList: (json['tracking_list'] as List<dynamic>?)
          ?.map((e) => TrackingList.fromJson(e as Map<String, dynamic>))
          .toList(),
      spotifyCountries: (json['spotifyCountries'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      serviceList: (json['service_list'] as List<dynamic>?)
          ?.map((e) => ServiceList.fromJson(e as Map<String, dynamic>))
          .toList(),
      showAmazonMusic: json['show_amazon_music'] as bool?,
      isSentryEnabled: json['isSentryEnabled'] as bool?,
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastUpdated: json['last_updated'] as String?,
      cluster: json['cluster'] as String?,
      eventMap: (json['event_map'] as List<dynamic>?)
          ?.map((e) => EventMap.fromJson(e as Map<String, dynamic>))
          .toList(),
      missionReportTypes: (json['mission_report_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      canShowPerformersTag: json['can_show_performers_tag'] as bool?,
      smartTranslations: json['smart_translations'] == null
          ? null
          : SmartTranslations.fromJson(
              json['smart_translations'] as Map<String, dynamic>),
      audioUpload: json['audio_upload'] as bool?,
    );

Missions _$MissionsFromJson(Map<String, dynamic> json) => Missions(
      enabled: json['enabled'] as bool?,
      community: (json['community'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

MissionManagerCategories _$MissionManagerCategoriesFromJson(
        Map<String, dynamic> json) =>
    MissionManagerCategories(
      taskTypes: (json['taskTypes'] as List<dynamic>?)
          ?.map((e) => TaskType.fromJson(e as Map<String, dynamic>))
          .toList(),
      audioSources: (json['audioSources'] as List<dynamic>?)
          ?.map((e) => AudioSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      userGroups: (json['userGroups'] as List<dynamic>?)
          ?.map((e) => UserGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      rewards: (json['rewards'] as List<dynamic>?)
          ?.map((e) => Reward.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

TaskType _$TaskTypeFromJson(Map<String, dynamic> json) => TaskType(
      value: json['value'] as String?,
      label: json['label'] as String?,
    );

AudioSource _$AudioSourceFromJson(Map<String, dynamic> json) => AudioSource(
      value: json['value'] as String?,
      label: json['label'] as String?,
    );

UserGroup _$UserGroupFromJson(Map<String, dynamic> json) => UserGroup(
      value: json['value'] as String?,
      label: json['label'] as String?,
    );

Reward _$RewardFromJson(Map<String, dynamic> json) => Reward(
      label: json['label'] as String?,
      value: json['value'] as String?,
    );

TrackingList _$TrackingListFromJson(Map<String, dynamic> json) => TrackingList(
      tracking: json['tracking'] == null
          ? null
          : Tracking.fromJson(json['tracking'] as Map<String, dynamic>),
    );

Tracking _$TrackingFromJson(Map<String, dynamic> json) => Tracking(
      context: json['context'] as String?,
      delay: (json['delay'] as num?)?.toInt(),
      trackCacheTtl: (json['track_cache_ttl'] as num?)?.toInt(),
    );

ServiceList _$ServiceListFromJson(Map<String, dynamic> json) => ServiceList(
      service: json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
    );

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      name: json['name'] as String?,
      displayName: json['display_name'] as String?,
      type: json['type'] as String?,
      oauthApi: json['oauth_api'] as bool?,
      oauthWebSignin: json['oauth_web_signin'] == null
          ? null
          : OauthWebSignin.fromJson(
              json['oauth_web_signin'] as Map<String, dynamic>),
      streaming: json['streaming'] as bool?,
      playlist: json['playlist'] as bool?,
      locker: json['locker'] as bool?,
      deeplink: json['deeplink'] as bool?,
    );

OauthWebSignin _$OauthWebSigninFromJson(Map<String, dynamic> json) =>
    OauthWebSignin(
      enabled: json['enabled'] as bool?,
      userPrefix: json['user_prefix'] as String?,
    );

EventMap _$EventMapFromJson(Map<String, dynamic> json) => EventMap(
      regex: json['regex'] as String?,
      enabled: json['enabled'] as bool?,
      piggyback: json['piggyback'] == null
          ? null
          : Piggyback.fromJson(json['piggyback'] as Map<String, dynamic>),
    );

Piggyback _$PiggybackFromJson(Map<String, dynamic> json) => Piggyback(
      serverWeight: (json['server_weight'] as num?)?.toInt(),
    );

SmartTranslations _$SmartTranslationsFromJson(Map<String, dynamic> json) =>
    SmartTranslations(
      enabled: json['enabled'] as bool?,
      threshold: (json['threshold'] as num?)?.toInt(),
    );

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      geoIPCityCountryCode: json['GEOIP_CITY_COUNTRY_CODE'] as String?,
      geoIPCityCountryCode3: json['GEOIP_CITY_COUNTRY_CODE3'] as String?,
      geoIPCityCountryName: json['GEOIP_CITY_COUNTRY_NAME'] as String?,
      geoIPCity: json['GEOIP_CITY'] as String?,
      geoIPCityContinentCode: json['GEOIP_CITY_CONTINENT_CODE'] as String?,
      geoIPLatitude: (json['GEOIP_LATITUDE'] as num?)?.toDouble(),
      geoIPLongitude: (json['GEOIP_LONGITUDE'] as num?)?.toDouble(),
      geoIPAsOrg: json['GEOIP_AS_ORG'] as String?,
      geoIPOrg: json['GEOIP_ORG'] as String?,
      geoIPIsp: json['GEOIP_ISP'] as String?,
      geoIPNetName: json['GEOIP_NET_NAME'] as String?,
      badipTags: json['BADIP_TAGS'] as List<dynamic>?,
    );
