import 'package:test/test.dart';
import 'package:lyricify_lyrics_helper/helpers/optimization/explicit.dart';

void main() {
  group('Explicit.fixExplicit', () {
    test('restores masked words with asterisks', () {
      const input = 'f**k and s*x plus sh*t';
      expect(Explicit.fixExplicit(input), 'fuck and sex plus shit');

      // Capitalization preserved for first letter
      const input2 = 'F**k the Sh*t!';
      expect(Explicit.fixExplicit(input2), 'Fuck the Shit!');
    });
  });

  group('Explicit.clean', () {
    test('mild mode masks partially', () {
      const input = 'fuck bitch damn sex';
      final cleaned = Explicit.clean(input);
      expect(cleaned, 'f**ck b***ch d**n s*x');
    });

    test('strong mode masks fully', () {
      const input = 'fuck bitches damn sex';
      final cleaned = Explicit.clean(input, strong: true);
      expect(cleaned, '**** ***** **** ***');
    });
  });
}
