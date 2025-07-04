import 'package:lyricify_lyrics_helper/searchers/helpers/match_helpers/artist_match.dart';
import 'package:test/test.dart';

void main() {
  group('ArtistMatchHelper.compareArtist', () {
    test('returns perfect when lists identical (case-insensitive)', () {
      final res = ArtistMatchHelper.compareArtist(
          ['Artist1', 'Artist2'], ['artist1', 'artist2']);
      expect(res, ArtistMatchType.perfect);
    });

    test('returns high when single match in two-length result', () {
      final res =
          ArtistMatchHelper.compareArtist(['Drake'], ['Drake', 'Future']);
      expect(res, ArtistMatchType.high);
    });

    test('returns noMatch for mismatched substring', () {
      final res = ArtistMatchHelper.compareArtist(['The Weeknd'], ['Week']);
      expect(res, ArtistMatchType.noMatch);
    });

    test('returns veryHigh when two matches among many', () {
      final res = ArtistMatchHelper.compareArtist(
          ['A', 'B', 'X'], ['A', 'B', 'C', 'D']);
      expect(res, ArtistMatchType.veryHigh);
    });

    test('returns noMatch when none match', () {
      final res = ArtistMatchHelper.compareArtist(['Foo'], ['Bar']);
      expect(res, ArtistMatchType.noMatch);
    });
  });

  group('ArtistMatchScore extension', () {
    test('returns correct score', () {
      expect(ArtistMatchType.perfect.getMatchScore(), 7);
      expect(ArtistMatchType.high.getMatchScore(), 5);
      expect(ArtistMatchType.noMatch.getMatchScore(), 0);
      ArtistMatchType? nullable;
      expect(nullable.getMatchScore(), 0);
    });
  });
}
