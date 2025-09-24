import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'sub_models/data.dart';

export 'sub_models/data.dart';

@immutable
final class OpenAIImageModel {
  /// The time the image was [created].
  final DateTime created;

  ///
  final String background;

  ///
  final String outputFormat;

  final String quality;

  final String size;

  final Usage? usage;

  /// The data of the image.
  final List<OpenAIImageData> data;

  /// Weither the image have some [data].
  bool get haveData => data.isNotEmpty;

  @override
  int get hashCode => created.hashCode ^ data.hashCode;

  /// This class is used to represent an OpenAI image.
  const OpenAIImageModel({
    required this.created,
    required this.data,
    required this.background,
    required this.outputFormat,
    required this.quality,
    required this.size,
    required this.usage,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIImageModel] object.
  factory OpenAIImageModel.fromMap(Map<String, dynamic> json) {
    return OpenAIImageModel(
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      data: (json['data'] as List)
          .map((e) => OpenAIImageData.fromMap(e))
          .toList(),
      background: json['background'] ?? '',
      outputFormat: json['output_format'] ?? '',
      quality: json['quality'] ?? '',
      size: json['size'] ?? '',
      usage: json['usage'] != null ? Usage.fromMap(json['usage']) : null,
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
}

class Usage {
  final int inputTokens;
  final UsageInputTokensDetails? inputTokensDetails;
  final int outputTokens;
  final int totalTokens;

  Usage({
    required this.inputTokens,
    required this.outputTokens,
    required this.totalTokens,
    this.inputTokensDetails,
  });

  factory Usage.fromMap(Map<String, dynamic> json) {
    return Usage(
      inputTokens: json['input_tokens'],
      inputTokensDetails: json['input_tokens_details'] != null
          ? UsageInputTokensDetails.fromMap(json['input_tokens_details'])
          : null,
      outputTokens: json['output_tokens'],
      totalTokens: json['total_tokens'],
    );
  }
}

class UsageInputTokensDetails {
  final int? imageTokens;
  final int? textTokens;

  UsageInputTokensDetails({
    this.imageTokens,
    this.textTokens,
  });

  factory UsageInputTokensDetails.fromMap(Map<String, dynamic> json) {
    return UsageInputTokensDetails(
      imageTokens: json['image_tokens'],
      textTokens: json['text_tokens'],
    );
  }
}
