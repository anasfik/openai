import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'sub_models/data.dart';

export 'sub_models/data.dart';

@immutable
final class OpenAiImageEditModel {
  /// The time the image was created.
  final DateTime created;

  /// The data of the image.
  final List<OpenAIImageEditDataModel> data;

  @override
  int get hashCode => created.hashCode ^ data.hashCode;

  /// This class is used to represent an OpenAI image edit.
  const OpenAiImageEditModel({
    required this.created,
    required this.data,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAiImageEditModel] object.
  factory OpenAiImageEditModel.fromMap(Map<String, dynamic> json) {
    return OpenAiImageEditModel(
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      data: List<OpenAIImageEditDataModel>.from(
        json['data'].map(
          (x) => OpenAIImageEditDataModel.fromMap(x),
        ),
      ),
    );
  }

  @override
  bool operator ==(covariant OpenAiImageEditModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.created == created && listEquals(other.data, data);
  }

  @override
  String toString() => 'OpenAiImageEditModel(created: $created, data: $data)';
}
