import 'package:collection/collection.dart';
import 'sub_models/data.dart';

export 'sub_models/data.dart';

class OpenAIImageVariationModel {
  final DateTime created;
  final List<OpenAIVariationData> data;

  OpenAIImageVariationModel({required this.created, required this.data});

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
