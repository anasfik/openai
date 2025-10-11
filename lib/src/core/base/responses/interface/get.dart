import 'package:dart_openai/src/core/models/responses/responses.dart';

abstract class GetInterface {
  Future<OpenAiResponse> get({
    required String responseId,
    List<String>? include,
    bool? include_obfuscation,
    int? startingAfter,
  });

  Future<OpenAiResponseInputItemsList> listInputItems({
    required String responseId,
    String? after,
    List<String>? include,
    int? limit,
    String? order,
  });
}
