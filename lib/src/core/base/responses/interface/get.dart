// ignore_for_file: non_constant_identifier_names, constant_identifier_names
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

  Future<int> getInputTokenCounts(
    dynamic conversation,
    dynamic input,
    String? instructions,
    String? model,
    bool? parallelToolCalls,
    String? previousResponseId,
    dynamic reasoning,
    dynamic text,
    dynamic toolChoice,
    List? tools,
    String? truncation,
  );
}
