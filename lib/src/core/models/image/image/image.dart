import 'package:collection/collection.dart';
import 'package:dart_openai/src/core/enum.dart';
import 'package:meta/meta.dart';
import 'sub_models/data.dart';

export 'sub_models/data.dart';

extension QualityToStingExtension on OpenAIImageQuality {
  String get value {
    return name;

    // ! pretty sure this will be needed in the future in case of adding more qualities that can't be got from the `name` field.
    // switch (this) {
    //   case OpenAIImageQuality.hd:
    //     return "hd";
    // }
  }
}

enum OpenAIImageModelOutputFormat {
  png,
  jpeg,
  webp;
}

enum OpenAIImageQuality {
  auto,
  high,
  medium,
  low,
  hd,
  standard;
}

@immutable
final class OpenAIImageModel {
  /// The time the image was [created].
  final DateTime created;

  ///
  final String? background;

  ///
  final OpenAIImageModelOutputFormat? outputFormat;

  final OpenAIImageQuality? quality;

  final OpenAIImageSize? size;

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
      outputFormat: json['output_format'] != null
          ? OpenAIImageModelOutputFormat.values.firstWhere(
              (e) => e.name == json['output_format'],
            )
          : null,
      quality: json['quality'] != null
          ? OpenAIImageQuality.values.firstWhere(
              (e) => e.name == json['quality'],
            )
          : null,
      size:
          json['size'] != null ? OpenAIImageSize.fromValue(json['size']) : null,
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
