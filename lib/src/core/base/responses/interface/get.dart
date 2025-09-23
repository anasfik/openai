import 'package:dart_openai/src/core/models/responses/responses.dart';

abstract class GetInterface {
  Future<OpenAiResponse> get({
    required String responseId,
    List? include,
    bool? include_obfuscation,
    int? startingAfter,
  });
}
