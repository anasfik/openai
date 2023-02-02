class OpenAIEmbeddingsModel {
  List<OpenAIEmbeddingsDataModel> data;
  String model;
  OpenAIEmbeddingsUsageModel usage;
  OpenAIEmbeddingsModel({
    required this.data,
    required this.model,
    required this.usage,
  });

  factory OpenAIEmbeddingsModel.fromMap(Map<String, dynamic> map) {
    return OpenAIEmbeddingsModel(
      data: List<OpenAIEmbeddingsDataModel>.from(
        map['data'].map<OpenAIEmbeddingsDataModel>(
          (x) => OpenAIEmbeddingsDataModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      model: map['model'] as String,
      usage: OpenAIEmbeddingsUsageModel.fromMap(
          map['usage'] as Map<String, dynamic>),
    );
  }
}

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

class OpenAIEmbeddingsUsageModel {
  int promptTokens;
  int totalTokens;
  OpenAIEmbeddingsUsageModel({
    required this.promptTokens,
    required this.totalTokens,
  });

  factory OpenAIEmbeddingsUsageModel.fromMap(Map<String, dynamic> map) {
    return OpenAIEmbeddingsUsageModel(
      promptTokens: map['prompt_tokens'] as int,
      totalTokens: map['total_tokens'] as int,
    );
  }
}
