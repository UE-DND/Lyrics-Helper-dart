import 'package:lyricify_lyrics_helper/helpers/type_helper.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_types.dart';
import 'package:test/test.dart';

void main() {
  group('TypeHelper', () {
    test('getLyricsTypes identifies YRC', () {
      final lyrics = '[0,0]... (123,456)';
      expect(TypeHelper.getLyricsTypes(lyrics), LyricsRawTypes.yrc);
    });

    test('getLyricsTypes identifies LyricifyLines', () {
      final lyrics = '[type:LyricifyLines]\n[0,1000]Hello';
      expect(TypeHelper.getLyricsTypes(lyrics), LyricsRawTypes.lyricifyLines);

      final lyrics2 = '[0,1000]Hello';
      expect(TypeHelper.getLyricsTypes(lyrics2), LyricsRawTypes.lyricifyLines);
    });

    test('getLyricsTypes identifies LRC', () {
      final lyrics = '[00:01.23]Hello';
      expect(TypeHelper.getLyricsTypes(lyrics), LyricsRawTypes.lrc);
    });

    test('getLyricsTypes returns unknown for others', () {
      final lyrics = 'Just plain text';
      expect(TypeHelper.getLyricsTypes(lyrics), LyricsRawTypes.unknown);
    });

    test('isLyricsType works correctly', () {
      final lrc = '[00:01.23]Hello';
      final lyricify = '[0,1000]Hello';
      expect(TypeHelper.isLyricsType(lrc, LyricsTypes.lrc), isTrue);
      expect(
          TypeHelper.isLyricsType(lyricify, LyricsTypes.lyricifyLines), isTrue);
      expect(TypeHelper.isLyricsType(lrc, LyricsTypes.lyricifyLines), isFalse);
      expect(TypeHelper.isLyricsType(lrc, LyricsTypes.yrc),
          isFalse); // Not supported
    });

    test('isLyricsTypeInList works correctly', () {
      final lrc = '[00:01.23]Hello';
      expect(
          TypeHelper.isLyricsTypeInList(
              lrc, [LyricsTypes.lrc, LyricsTypes.yrc]),
          isTrue);
      expect(TypeHelper.isLyricsTypeInList(lrc, [LyricsTypes.yrc]), isFalse);
      expect(TypeHelper.isLyricsTypeInList(lrc, []), isFalse);
    });
  });

  group('LyricsRawTypesExtension', () {
    test('toLyricsType converts correctly', () {
      expect(LyricsRawTypes.unknown.toLyricsType(), LyricsTypes.unknown);
      expect(LyricsRawTypes.lyricifySyllable.toLyricsType(),
          LyricsTypes.lyricifySyllable);
      expect(LyricsRawTypes.lyricifyLines.toLyricsType(),
          LyricsTypes.lyricifyLines);
      expect(LyricsRawTypes.lrc.toLyricsType(), LyricsTypes.lrc);
      expect(LyricsRawTypes.yrc.toLyricsType(), LyricsTypes.yrc);
    });
  });
}
