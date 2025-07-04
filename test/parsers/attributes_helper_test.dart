import 'package:test/test.dart';

import 'package:lyricify_lyrics_helper/parsers/attributes_helper.dart';
import 'package:lyricify_lyrics_helper/models/lyrics_data.dart';
import 'package:lyricify_lyrics_helper/models/track_metadata.dart';
import 'package:lyricify_lyrics_helper/models/additional_file_info.dart';
import 'package:lyricify_lyrics_helper/models/file_info.dart';

void main() {
  group('AttributesHelper.parseGeneralAttributesToLyricsData', () {
    test('parses common attributes and returns offset', () {
      final lines = <String>[
        '[ar:Artist]',
        '[al:Album]',
        '[ti:Title]',
        '[length:123456]',
        '[offset:250]',
        'Actual lyric line',
      ];

      final data = LyricsData()
        ..file = (FileInfo()
          ..additionalInfo = (GeneralAdditionalInfo()..attributes = []));

      final offset =
          AttributesHelper.parseGeneralAttributesToLyricsData(data, lines);

      // 应正确返回 offset
      expect(offset, equals(250));

      // TrackMetadata 应被正确填充
      expect(data.trackMetadata, isA<TrackMetadata>());
      expect(data.trackMetadata!.artist, 'Artist');
      expect(data.trackMetadata!.album, 'Album');
      expect(data.trackMetadata!.title, 'Title');
      expect(data.trackMetadata!.durationMs, 123456);

      // 属性行应已从列表中移除，仅剩歌词行
      expect(lines, equals(['Actual lyric line']));
    });

    test('parses hash attribute into KrcAdditionalInfo', () {
      final lines = <String>[
        '[hash:abc123]',
        'Some lyric',
      ];

      final data = LyricsData()
        ..file = (FileInfo()..additionalInfo = KrcAdditionalInfo());

      final offset =
          AttributesHelper.parseGeneralAttributesToLyricsData(data, lines);

      // 无 offset，返回 null
      expect(offset, isNull);

      // hash 应已写入 KrcAdditionalInfo
      final additionalInfo = data.file!.additionalInfo as KrcAdditionalInfo;
      expect(additionalInfo.hash, 'abc123');

      // 属性行应从列表移除
      expect(lines, equals(['Some lyric']));
    });

    test('stores unknown attributes into GeneralAdditionalInfo list', () {
      final lines = <String>[
        '[foo:bar]',
        '[baz:qux]',
        'Lyrics',
      ];

      final generalInfo = GeneralAdditionalInfo()..attributes = [];
      final data = LyricsData()
        ..file = (FileInfo()..additionalInfo = generalInfo);

      AttributesHelper.parseGeneralAttributesToLyricsData(data, lines);

      final additionalInfo = data.file!.additionalInfo as GeneralAdditionalInfo;
      // 应存储两条自定义属性
      expect(additionalInfo.attributes, hasLength(2));
      expect(additionalInfo.attributes!.first.key, 'foo');
      expect(additionalInfo.attributes!.first.value, 'bar');

      // 属性行已移除
      expect(lines, equals(['Lyrics']));
    });
  });
}
