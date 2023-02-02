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
}
