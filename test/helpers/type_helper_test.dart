import 'package:test/test.dart';
import 'package:lyricify_lyrics_helper/helpers/type_helper.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_types.dart';

void main() {
  group('TypeHelper.isLyricsType', () {
    test('检测 LRC', () {
      const lrcSample = '[00:10.00]Hello World';
      expect(TypeHelper.isLyricsType(lrcSample, LyricsTypes.lrc), isTrue);
      expect(TypeHelper.isLyricsType(lrcSample, LyricsTypes.lyricifyLines),
          isFalse);
    });

    test('检测 LyricifyLines', () {
      const llSample = '[type:LyricifyLines]\n[100,300] first';
      expect(
          TypeHelper.isLyricsType(llSample, LyricsTypes.lyricifyLines), isTrue);
      expect(TypeHelper.isLyricsType(llSample, LyricsTypes.lrc), isFalse);
    });
  });

  group('TypeHelper.isLyricsTypeInList', () {
    test('类型在列表中', () {
      const lrcSample = '[00:10.00]Hello';
      final types = [LyricsTypes.krc, LyricsTypes.lrc];
      expect(TypeHelper.isLyricsTypeInList(lrcSample, types), isTrue);
    });

    test('类型不在列表中', () {
      const lrcSample = '[00:10.00]Hello';
      final types = [LyricsTypes.krc, LyricsTypes.qrc];
      expect(TypeHelper.isLyricsTypeInList(lrcSample, types), isFalse);
    });
  });
}
