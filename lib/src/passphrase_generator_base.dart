import 'package:word_collection_utils/word_collection_utils.dart';

// Conditional import:
import 'init/passphrase_generator_init_io.dart'
    if (dart.library.html) 'passphrase_generator_init_web.dart';

/// A utility class for generating secure passphrases using a word collection.
///
/// The [PassphraseGenerator] provides static methods to generate passphrases
/// as a single string or as a list of words. It uses a word collection file,
/// which can be customized via the [collectionPath] parameter.
class PassphraseGenerator {
  /// The utility instance for word collection operations.
  static late WordCollectionUtils _wordCollectionUtils;

  /// Default constructor.
  PassphraseGenerator();

  /// Generates a passphrase as a single string.
  ///
  /// Returns a string containing [wordCount] randomly selected words,
  /// joined by [joinString].
  ///
  /// [wordCount]: The number of words in the passphrase. Must be greater than zero.
  /// [joinString]: The string used to join the words. Defaults to a space.
  /// [collectionPath]: Optional path to a custom word collection CSV file.
  ///
  /// Throws an [ArgumentError] if [wordCount] is not positive.
  static Future<String> generatePassphrase(
    int wordCount, {
    String joinString = ' ',
    String? collectionPath,
  }) async {
    if (wordCount <= 0) {
      throw ArgumentError('Word count must be greater than zero.');
    }

    List<Word> words = await _generateWordList(
      wordCount,
      collectionPath: collectionPath,
    );
    return words.map((word) => word.value).join(joinString);
  }

  /// Generates a passphrase as a list of words.
  ///
  /// Returns a list of [wordCount] randomly selected words as strings.
  ///
  /// [wordCount]: The number of words in the passphrase. Must be greater than zero.
  /// [collectionPath]: Optional path to a custom word collection CSV file.
  ///
  /// Throws an [ArgumentError] if [wordCount] is not positive.
  static Future<List<String>> generatePassphraseAsList(
    int wordCount, {
    String? collectionPath,
  }) async {
    if (wordCount <= 0) {
      throw ArgumentError('Word count must be greater than zero.');
    }
    List<Word> words = await _generateWordList(
      wordCount,
      collectionPath: collectionPath,
    );
    return words.map((word) => word.value).toList();
  }

  /// Initializes the word collection utility.
  ///
  /// [collectionPath]: Optional path to a custom word collection CSV file.
  /// If not provided, defaults to 'lib/assets/collection.csv' on non-web platforms.
  /// On web, [collectionPath] must be provided.
  ///
  /// Returns `true` if initialization succeeds, otherwise `false`.
  static bool _init({String? collectionPath}) {
    try {
      _wordCollectionUtils = createWordCollectionUtils(
        collectionPath: collectionPath,
      );
      return true;
    } catch (e) {
      print('Error initializing PassphraseGenerator: $e');
      return false;
    }
  }

  /// Generates a list of random [Word] objects.
  ///
  /// [wordCount]: The number of words to generate.
  /// [collectionPath]: Optional path to a custom word collection CSV file.
  ///
  /// Throws an [Exception] if initialization fails.
  static Future<List<Word>> _generateWordList(
    int wordCount, {
    String? collectionPath,
  }) async {
    bool isInitialized = _init(collectionPath: collectionPath);
    if (!isInitialized) {
      throw Exception('Failed to initialize PassphraseGenerator.');
    }
    List<Word> words = [];
    for (int i = 0; i < wordCount; i++) {
      Word word = await _wordCollectionUtils.getRandomWord();
      words.add(word);
    }
    return words;
  }
}
