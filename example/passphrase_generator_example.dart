import 'package:passphrase_generator/passphrase_generator.dart';

Future<void> main() async {
  String passPhrase = await PassphraseGenerator.generatePassphrase(10);
  print(passPhrase);

  List<String> passPhraseList =
      await PassphraseGenerator.generatePassphraseAsList(10);
  print(passPhraseList);
}
