import 'package:collection/collection.dart';
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

  @override
  bool operator ==(covariant OpenAiImageEditModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.created == created &&
      listEquals(other.data, data);
  }

  @override
  int get hashCode => created.hashCode ^ data.hashCode;

  @override
  String toString() => 'OpenAiImageEditModel(created: $created, data: $data)';
}
