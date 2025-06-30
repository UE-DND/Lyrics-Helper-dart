import 'package:test/test.dart';
import 'package:lyricify_lyrics_helper/helpers/general/chinese_helper.dart';

void main() {
  group('简繁转换', () {
    test('简体转繁体', () {
      expect(ChineseHelper.s2t('发现'), '發現');
      expect('车门'.toTC(force: true), '車門');
    });

    test('繁体转简体', () {
      expect(ChineseHelper.t2s('見發'), '见发');
      expect('東廣'.toSC(force: true), '东广');
    });

    test('空字符串与 null', () {
      expect(ChineseHelper.s2t(null), '');
      expect(ChineseHelper.t2s(''), '');
    });
  });
}
