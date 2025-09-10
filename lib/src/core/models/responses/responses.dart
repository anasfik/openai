import 'package:meta/meta.dart';

@immutable
class OpenAIResponseModel {
  final bool? background;
  final dynamic conversation;
  final num created_at;
  final dynamic error;
  final String id;
  final dynamic incompleteDetails;
  final dynamic instructions;
  final int maxOutputTokens;
  final int maxToolCalls;
  final Map<String, dynamic> metadata;
  final String model;
  final String object;
  final List output;
  final bool parallelToolCalls;
  final String? previousResponseId;
  final dynamic prompt;
  final String promptCacheKey;
  final dynamic reasoning;
  final String safetyIdentifier;
  final String? serviceTier;
  final String status;
  final num? temperature;
  final dynamic text;
  final dynamic toolChoice;
  final List tools;
  final int? top_logprobs;
  final num? topP;
  final String? truncation;
  final dynamic usage;

  OpenAIResponseModel({
    required this.background,
    required this.conversation,
    required this.created_at,
    required this.error,
    required this.id,
    required this.incompleteDetails,
    required this.instructions,
    required this.maxOutputTokens,
    required this.maxToolCalls,
    required this.metadata,
    required this.model,
    required this.object,
    required this.output,
    required this.parallelToolCalls,
    required this.previousResponseId,
    required this.prompt,
    required this.promptCacheKey,
    required this.reasoning,
    required this.safetyIdentifier,
    required this.serviceTier,
    required this.status,
    required this.temperature,
    required this.text,
    required this.toolChoice,
    required this.tools,
    required this.top_logprobs,
    required this.topP,
    required this.truncation,
    required this.usage,
  });
}
