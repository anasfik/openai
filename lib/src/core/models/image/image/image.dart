import 'sub_models/data.dart';

class OpenAIImageModel {
  final DateTime created;
  final List<OpenAIImageData> data;

  OpenAIImageModel({required this.created, required this.data});

  factory OpenAIImageModel.fromJson(Map<String, dynamic> json) {
    return OpenAIImageModel(
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      data: (json['data'] as List)
          .map((e) => OpenAIImageData.fromJson(e))
          .toList(),
    );
  }
}
