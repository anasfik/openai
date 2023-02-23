import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

@immutable
class OpenAIEmbeddingsDataModel {
  /// The embedding of the text.
  final List<double> embeddings;

  /// The index of the text.
  final int index;

  @override
  int get hashCode => embeddings.hashCode ^ index.hashCode;

  /// This class is used to represent the data returned by an OpenAI embeddings request.
  const OpenAIEmbeddingsDataModel({
    required this.embeddings,
    required this.index,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIEmbeddingsDataModel] object.
  factory OpenAIEmbeddingsDataModel.fromMap(Map<String, dynamic> map) {
    return OpenAIEmbeddingsDataModel(
      embeddings: List<double>.from(
        (map['embedding'] as List).map(
          (e) => e as double,
        ),
      ),
      index: map['index'] as int,
    );
  }

  @override
  bool operator ==(covariant OpenAIEmbeddingsDataModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.embeddings, embeddings) && other.index == index;
  }

  @override
  String toString() =>
      'OpenAIEmbeddingsDataModel(embeddings: $embeddings, index: $index)';
}
