import 'package:test/test.dart';
import 'package:lyricify_lyrics_helper/models/track_metadata.dart';

void main() {
  group('TrackMetadata', () {
    test('toJson returns correct map', () {
      final metadata = TrackMetadata()
        ..title = 'Test Title'
        ..artist = 'Test Artist'
        ..album = 'Test Album'
        ..albumArtist = 'Test Album Artist'
        ..durationMs = 180000
        ..isrc = 'TEST_ISRC'
        ..language = ['en'];

      final json = metadata.toJson();

      expect(json['title'], 'Test Title');
      expect(json['artist'], 'Test Artist');
      expect(json['album'], 'Test Album');
      expect(json['albumArtist'], 'Test Album Artist');
      expect(json['durationMs'], 180000);
      expect(json['isrc'], 'TEST_ISRC');
      expect(json['language'], ['en']);
    });

    test('toString returns correct string', () {
      final metadata = TrackMetadata()
        ..title = 'Test Title'
        ..artist = 'Test Artist';

      final expectedString = metadata.toJson().toString();
      expect(metadata.toString(), expectedString);
    });
  });

  group('TrackMultiArtistMetadata', () {
    test('artist getter and setter work correctly', () {
      final metadata = TrackMultiArtistMetadata();
      metadata.artists = ['Artist 1', 'Artist 2'];
      expect(metadata.artist, 'Artist 1, Artist 2');

      metadata.artist = 'Artist 3, Artist 4';
      expect(metadata.artists, ['Artist 3', 'Artist 4']);

      metadata.artist = '';
      expect(metadata.artists, []);

      metadata.artist = null;
      expect(metadata.artists, []);
    });

    test('albumArtist getter and setter work correctly', () {
      final metadata = TrackMultiArtistMetadata();
      metadata.albumArtists = ['Album Artist 1', 'Album Artist 2'];
      expect(metadata.albumArtist, 'Album Artist 1, Album Artist 2');

      metadata.albumArtist = 'Album Artist 3, Album Artist 4';
      expect(metadata.albumArtists, ['Album Artist 3', 'Album Artist 4']);

      metadata.albumArtist = '';
      expect(metadata.albumArtists, []);

      metadata.albumArtist = null;
      expect(metadata.albumArtists, []);
    });

    test('fromTrackMetadata works correctly for TrackMetadata', () {
      final track = TrackMetadata()
        ..title = 'Test Title'
        ..artist = 'Artist 1, Artist 2'
        ..album = 'Test Album'
        ..albumArtist = 'Album Artist 1, Album Artist 2'
        ..durationMs = 180000
        ..isrc = 'TEST_ISRC'
        ..language = ['en']
        ..title = 'Test Title';

      final multiArtistTrack =
          TrackMultiArtistMetadata.fromTrackMetadata(track);

      expect(multiArtistTrack.title, 'Test Title');
      expect(multiArtistTrack.artists, ['Artist 1', 'Artist 2']);
      expect(multiArtistTrack.album, 'Test Album');
      expect(
          multiArtistTrack.albumArtists, ['Album Artist 1', 'Album Artist 2']);
      expect(multiArtistTrack.durationMs, 180000);
      expect(multiArtistTrack.isrc, 'TEST_ISRC');
      expect(multiArtistTrack.language, ['en']);
      expect(multiArtistTrack.title, 'Test Title');
    });

    test('fromTrackMetadata returns same instance for TrackMultiArtistMetadata',
        () {
      final track = TrackMultiArtistMetadata();
      final sameTrack = TrackMultiArtistMetadata.fromTrackMetadata(track);
      expect(identical(track, sameTrack), isTrue);
    });

    test('toJson returns correct map', () {
      final metadata = TrackMultiArtistMetadata()
        ..title = 'Test Title'
        ..artists = ['Artist 1', 'Artist 2']
        ..album = 'Test Album'
        ..albumArtists = ['Album Artist 1', 'Album Artist 2']
        ..durationMs = 180000
        ..isrc = 'TEST_ISRC'
        ..language = ['en'];

      final json = metadata.toJson();

      expect(json['title'], 'Test Title');
      expect(json['artist'], 'Artist 1, Artist 2');
      expect(json['album'], 'Test Album');
      expect(json['albumArtist'], 'Album Artist 1, Album Artist 2');
      expect(json['durationMs'], 180000);
      expect(json['isrc'], 'TEST_ISRC');
      expect(json['language'], ['en']);
    });
  });

  group('SpotifyTrackMetadata', () {
    test('uri is generated correctly', () {
      final metadata = SpotifyTrackMetadata();
      metadata.id = 'test_id';
      expect(metadata.uri, 'spotify:track:test_id');

      metadata.id = null;
      expect(metadata.uri, isNull);
    });
  });
}
