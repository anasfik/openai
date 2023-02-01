// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
        (map['data'] as List<int>).map<OpenAIEmbeddingsDataModel>(
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
      embeddings: List<double>.from((map['embeddings'] as List<double>)),
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
      promptTokens: map['promptTokens'] as int,
      totalTokens: map['totalTokens'] as int,
    );
  }
}
