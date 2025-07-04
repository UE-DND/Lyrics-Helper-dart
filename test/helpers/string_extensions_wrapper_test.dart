import 'package:test/test.dart';
import 'package:lyricify_lyrics_helper/helpers/general/string_helper.dart';
import 'package:lyricify_lyrics_helper/models/track_metadata.dart';
import 'package:lyricify_lyrics_helper/models/additional_file_info.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_data.dart';
import 'package:lyricify_lyrics_helper/models/file_info.dart';
import 'package:lyricify_lyrics_helper/models/line_info.dart';
import 'package:lyricify_lyrics_helper/models/i_line_info.dart';

// 用于触发 LyricsData.toJson fallback 分支的简单实现
class DummyLineInfo implements ILineInfo {
  @override
  String text = 'dummy';

  @override
  int? startTime;

  @override
  int? endTime;

  @override
  LyricsAlignment lyricsAlignment = LyricsAlignment.unspecified;

  @override
  ILineInfo? subLine;

  @override
  int compareTo(ILineInfo other) => 0;

  // 以下实现仅为覆盖率测试所用
  @override
  int? get duration => null;

  @override
  int? get startTimeWithSubLine => null;

  @override
  int? get endTimeWithSubLine => null;

  @override
  int? get durationWithSubLine => null;

  @override
  String get fullText => text;
}

class DummyLyrics {
  String provider = 'q';
  String providerLyricsId = 'lid';
  String providerDisplayName = 'disp';
  String language = 'fr';
}

void main() {
  group('StringExtensions wrappers', () {
    test('utility extension methods', () {
      expect('((hi))'.removeFrontBackBrackets(), '(hi)');
      expect('a  b   c'.removeDuoSpaces(), 'a b c');
      expect('a  b   c'.removeTripleSpaces(), 'a  b  c');
      expect('A,B,C'.fixCommaAfterSpace(), 'A, B, C');
      expect('x\n\ny'.removeDuoBackslashN(), 'x\ny');
      expect('x\ry'.removeBackslashR(), 'xy');
      expect('word'.toUpperFirst(), 'Word');
      expect('abcword'.toUpperFirst(start: 3), 'abcWord');
      expect('prefix[body]suffix'.between('[', ']'), 'body');
      expect('hello'.reverse(), 'olleh');
      expect('foobar'.remove('bar'), 'foo');
      expect('123'.isNumber(), isTrue);
      expect('12.3'.isNumber(), isTrue);
      expect('abc'.isNumber(), isFalse);
      expect(' a '.isSameWhiteSpace('a'), isFalse);
      expect(' a '.isSameTrim('a'), isTrue);
    });
  });

  group('Model toJson coverage', () {
    test('TrackMetadata and derived classes', () {
      final track = TrackMetadata()
        ..title = 'Song'
        ..artist = 'Artist'
        ..durationMs = 1234;
      expect(track.toJson()['title'], 'Song');
      expect(track.toString(), contains('Song'));

      final multi = TrackMultiArtistMetadata.fromTrackMetadata(track);
      expect(multi.artist, 'Artist');
    });

    test('AdditionalFileInfo implementations', () {
      final general = GeneralAdditionalInfo()
        ..attributes = [MapEntry('k', 'v')];
      expect(general.toJson()['attributes'], isNotEmpty);

      final krc = KrcAdditionalInfo()..hash = 'abc123';
      expect(krc.toJson()['hash'], 'abc123');

      final spotify = SpotifyAdditionalInfo.create('prov', 'id', 'name');
      expect(spotify.toJson()['provider'], 'prov');

      // 默认构造函数 & withLanguage 构造
      final spotifyDefault = SpotifyAdditionalInfo();
      expect(spotifyDefault.toJson()['provider'], isNull);

      final spotifyLang =
          SpotifyAdditionalInfo.withLanguage('p', 'id2', 'n', 'en');
      expect(spotifyLang.toJson()['lyricsLanguage'], 'en');

      // fromSpotifyLyrics 构造
      final spotifyFrom =
          SpotifyAdditionalInfo.fromSpotifyLyrics(DummyLyrics());
      expect(spotifyFrom.toJson()['lyricsLanguage'], 'fr');
    });

    test('LyricsData toJson', () {
      final data = LyricsData()
        ..file = FileInfo()
        ..lines = [DummyLineInfo()];

      final json = data.toJson();
      expect(json['file'], isNotNull);
      expect(json['lines'], isNotNull);
      // 调用 toString() 覆盖 IAdditionalFileInfo.toString 的执行路径
      final info = GeneralAdditionalInfo()..attributes = [];
      info.toString();
    });

    test('ILineInfo computed getters', () {
      final line = LineInfo.fromTextAndTimes('abc', 1000, 1500);
      expect(line.duration, 500);
      expect(line.startTimeWithSubLine, 1000);
      expect(line.endTimeWithSubLine, 1500);
      expect(line.durationWithSubLine, 500);
    });
  });
}
