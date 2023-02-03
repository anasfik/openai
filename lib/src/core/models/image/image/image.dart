import 'package:collection/collection.dart';
import 'sub_models/data.dart';

export 'sub_models/data.dart';

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

  @override
  String toString() => 'OpenAIImageModel(created: $created, data: $data)';

  @override
  bool operator ==(covariant OpenAIImageModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.created == created && listEquals(other.data, data);
  }

  @override
  int get hashCode => created.hashCode ^ data.hashCode;
}
