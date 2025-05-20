import 'package:test/test.dart';
import 'package:passphrase_generator/passphrase_generator.dart';

void main() {
  group('PassphraseGenerator', () {
    test('generatePassphrase returns correct number of words', () async {
      final passphrase = await PassphraseGenerator.generatePassphrase(4);
      expect(passphrase.split(' ').length, equals(4));
    });

    test('generatePassphraseAsList returns correct number of words', () async {
      final words = await PassphraseGenerator.generatePassphraseAsList(3);
      expect(words.length, equals(3));
    });

    test('generatePassphrase throws ArgumentError for zero words', () async {
      expect(
        () => PassphraseGenerator.generatePassphrase(0),
        throwsA(isA<ArgumentError>()),
      );
    });

    test(
      'generatePassphraseAsList throws ArgumentError for negative words',
      () async {
        expect(
          () => PassphraseGenerator.generatePassphraseAsList(-2),
          throwsA(isA<ArgumentError>()),
        );
      },
    );

    test('generatePassphrase uses custom join string', () async {
      final passphrase = await PassphraseGenerator.generatePassphrase(
        2,
        joinString: '-',
      );
      expect(passphrase.contains('-'), isTrue);
      expect(passphrase.split('-').length, equals(2));
    });
  });
}
