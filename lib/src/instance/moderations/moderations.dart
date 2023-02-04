import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/models/moderation/moderation.dart';
import 'package:dart_openai/src/core/networking/client.dart';

import '../../core/base/moderations/base.dart';

class OpenAIModeration implements OpenAIModerationBase {
  @override
  String get endpoint => "/moderations";

  /// Creates a moderation request.
  /// Example:
  /// ```dart
  /// final moderation = await openai.moderation.create(
  ///  input: "I will kill your mates before I will cut your head off",
  /// );
  /// ```
  @override
  Future<OpenAIModerationModel> create({
    required String input,
    String? model,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIModerationModel>(
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIModerationModel.fromJson(response);
      },
      body: {
        "input": input,
        if (model != null) "model": model,
      },
      to: BaseApiUrlBuilder.build(endpoint),
    );
  }
}
