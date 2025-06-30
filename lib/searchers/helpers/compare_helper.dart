import '../../models/i_track_metadata.dart';
import '../../models/track_metadata.dart';
import '../i_search_result.dart';
import 'match_helpers/artist_match.dart';
import 'match_helpers/duration_match.dart';
import 'match_helpers/name_match.dart';

enum CompareMatchType {
  perfect,
  veryHigh,
  high,
  prettyHigh,
  medium,
  low,
  veryLow,
  noMatch,
}

class CompareHelper {
  /// 比较曲目匹配程度
  static CompareMatchType compareTrack(
    ITrackMetadata track,
    ISearchResult searchResult,
  ) {
    return compareTrackMulti(
      TrackMultiArtistMetadata.fromTrackMetadata(track),
      searchResult,
    );
  }

  /// 比较曲目匹配程度（多艺人版本）
  static CompareMatchType compareTrackMulti(
    TrackMultiArtistMetadata track,
    ISearchResult searchResult,
  ) {
    final trackMatch =
        NameMatchHelper.compareName(track.title, searchResult.title);
    final artistMatch = ArtistMatchHelper.compareArtist(
      track.artists,
      searchResult.artists,
    );
    final albumMatch =
        NameMatchHelper.compareName(track.album, searchResult.album);
    final albumArtistMatch = ArtistMatchHelper.compareArtist(
      track.albumArtists,
      searchResult.albumArtists,
    );
    final durationMatch = DurationMatchHelper.compareDuration(
      track.durationMs,
      searchResult.durationMs,
    );

    double totalScore = 0;
    totalScore += trackMatch.getMatchScore();
    totalScore += artistMatch.getMatchScore();
    totalScore += albumMatch.getMatchScore() * 0.4;
    totalScore += albumArtistMatch.getMatchScore() * 0.2;
    totalScore += durationMatch.getMatchScore();

    // 针对 MatchType 为 null 的进行按比例拉伸调整
    double nullCount = 0;
    const int fullScore = 30; // 25.2
    nullCount += albumMatch == null ? 0.4 : 0;
    nullCount += albumArtistMatch == null ? 0.2 : 0;
    nullCount += durationMatch == null ? 1 : 0;
    final adjustedScore =
        totalScore * fullScore / (fullScore - nullCount * 7);

    return _toMatchType(adjustedScore);
  }

  static CompareMatchType _toMatchType(double score) {
    if (score > 21) return CompareMatchType.perfect;
    if (score > 19) return CompareMatchType.veryHigh;
    if (score > 17) return CompareMatchType.high;
    if (score > 15) return CompareMatchType.prettyHigh;
    if (score > 11) return CompareMatchType.medium;
    if (score > 8) return CompareMatchType.low;
    if (score > 3) return CompareMatchType.veryLow;
    return CompareMatchType.noMatch;
  }
} 