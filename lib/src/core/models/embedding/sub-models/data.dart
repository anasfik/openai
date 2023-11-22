import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

/// {@template openai_embeddings_data_model}
/// This class is used to represent the data returned by an OpenAI embeddings request.
/// {@endtemplate}
@immutable
final class OpenAIEmbeddingsDataModel {
  /// The embedding of the text.
  final List<double> embeddings;

  /// The index of the text.
  final int index;

  /// Weither the embeddings have at least one item in [embeddings].
  bool get haveEmbeddings => embeddings.isNotEmpty;

  @override
  int get hashCode => embeddings.hashCode ^ index.hashCode;

  /// {@macro openai_embeddings_data_model}
  const OpenAIEmbeddingsDataModel({
    required this.embeddings,
    required this.index,
  });

  /// {@macro openai_embeddings_data_model}
  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIEmbeddingsDataModel] object.
  factory OpenAIEmbeddingsDataModel.fromMap(Map<String, dynamic> map) {
    return OpenAIEmbeddingsDataModel(
      embeddings: List<double>.from(
        (map['embedding'] as List).map(
          (e) => e is double ? e : (e as num).toDouble(),
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
