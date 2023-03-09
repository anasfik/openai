import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/models/moderation/moderation.dart';
import 'package:dart_openai/src/core/networking/client.dart';

import '../../core/base/moderations/base.dart';
import 'package:meta/meta.dart';

import '../../core/utils/logger.dart';

@immutable
@protected
class OpenAIModeration implements OpenAIModerationBase {
  @override
  String get endpoint => "/moderations";

  /// Creates a moderation request.
  ///
  ///
  /// [input] is the input text to classify.
  ///
  ///
  /// [model] is the used model for this operation, two content moderation models are available: "text-moderation-stable" and "text-moderation-latest".
  /// The default is text-moderation-latest which will be automatically upgraded over time. This ensures you are always using our most accurate model. If you use text-moderation-stable, we will provide advanced notice before updating the model. Accuracy of text-moderation-stable may be slightly lower than for text-moderation-latest.
  ///
  ///
  /// Example:
  /// ```dart
  /// final moderation = await openai.moderation.create(
  ///  input: "I will kill your mates before I will cut your head off",
  /// );
  ///
  /// print(moderation.results); // ...
  /// print(moderation.results.first.categories.hate); // ...
  /// ```
  @override
  Future<OpenAIModerationModel> create({
    required String input,
    String? model,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIModerationModel>(
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIModerationModel.fromMap(response);
      },
      body: {
        "input": input,
        if (model != null) "model": model,
      },
      to: BaseApiUrlBuilder.build(endpoint),
    );
  }

  OpenAIModeration() {
    OpenAILogger.logEndpoint(endpoint);
  }
}
