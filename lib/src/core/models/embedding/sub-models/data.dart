import 'package:collection/collection.dart';

class OpenAIEmbeddingsDataModel {
  List<double> embeddings;
  int index;

  OpenAIEmbeddingsDataModel({
    required this.embeddings,
    required this.index,
  });

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
  
    return 
      listEquals(other.embeddings, embeddings) &&
      other.index == index;
  }

  @override
  int get hashCode => embeddings.hashCode ^ index.hashCode;

  @override
  String toString() => 'OpenAIEmbeddingsDataModel(embeddings: $embeddings, index: $index)';
}
