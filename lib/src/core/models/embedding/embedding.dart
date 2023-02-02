import 'sub-models/data.dart';
import 'sub-models/usage.dart';

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
