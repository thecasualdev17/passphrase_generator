import 'package:word_collection_utils/word_collection_utils.dart';

/// Creates a [WordCollectionUtils] instance for web platforms.
///
/// [collectionPath] must be provided and should point to a web-accessible
/// word collection CSV file (e.g., an asset or network resource).
///
/// Throws an [UnsupportedError] if [collectionPath] is not provided.
///
/// Returns a [WordCollectionUtils] instance initialized with the specified path.
WordCollectionUtils createWordCollectionUtils({String? collectionPath}) {
  if (collectionPath == null) {
    throw UnsupportedError('collectionPath must be provided on the web.');
  }
  return WordCollectionUtils(collectionPath: collectionPath);
}
