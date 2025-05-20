import 'dart:io';
import 'package:word_collection_utils/word_collection_utils.dart';

/// Creates a [WordCollectionUtils] instance for non-web platforms (IO).
///
/// If [collectionPath] is not provided, defaults to the absolute path
/// of 'lib/assets/collection.csv' in the project directory.
///
/// [collectionPath]: Optional path to a custom word collection CSV file.
///
/// Returns a [WordCollectionUtils] instance initialized with the specified or default path.
WordCollectionUtils createWordCollectionUtils({String? collectionPath}) {
  final path =
      collectionPath ?? File('lib/assets/collection.csv').absolute.path;
  return WordCollectionUtils(collectionPath: path);
}
