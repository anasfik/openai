import 'sub_models/data.dart';

class OpenAiImageEditModel {
  final DateTime created;
  final List<OpenAiImageEditDataModel> data;

  OpenAiImageEditModel({
    required this.created,
    required this.data,
  });

  factory OpenAiImageEditModel.fromJson(Map<String, dynamic> json) {
    return OpenAiImageEditModel(
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      data: List<OpenAiImageEditDataModel>.from(
        json['data'].map(
          (x) => OpenAiImageEditDataModel.fromJson(x),
        ),
      ),
    );
  }
}
