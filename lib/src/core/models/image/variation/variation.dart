import 'package:collection/collection.dart';
import 'sub_models/data.dart';

export 'sub_models/data.dart';

class OpenAIImageVariationModel {
  /// The time the image was created.
  final DateTime created;

  /// The data of the image.
  final List<OpenAIVariationData> data;

  /// This class is used to represent an OpenAI image variation.
  OpenAIImageVariationModel({required this.created, required this.data});

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIImageVariationModel] object.
  factory OpenAIImageVariationModel.fromJson(Map<String, dynamic> json) {
    return OpenAIImageVariationModel(
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      data: (json['data'] as List)
          .map((e) => OpenAIVariationData.fromJson(e))
          .toList(),
    );
  }

  @override
  bool operator ==(covariant OpenAIImageVariationModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.created == created && listEquals(other.data, data);
  }

  @override
  int get hashCode => created.hashCode ^ data.hashCode;

  @override
  String toString() =>
      'OpenAIImageVariationModel(created: $created, data: $data)';
}
