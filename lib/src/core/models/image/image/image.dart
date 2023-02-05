import 'package:collection/collection.dart';
import 'sub_models/data.dart';

export 'sub_models/data.dart';

class OpenAIImageModel {
  /// The time the image was created.
  final DateTime created;

  /// The data of the image.
  final List<OpenAIImageData> data;

  /// This class is used to represent an OpenAI image.
  OpenAIImageModel({required this.created, required this.data});

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIImageModel] object.
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
