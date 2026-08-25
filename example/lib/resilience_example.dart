import 'package:dart_openai/dart_openai.dart';

/// Resilient requests — retries, Azure deployments, web-safe uploads.
Future<void> main() async {
  // Retry policy: 3 attempts total, exponential backoff, honors Retry-After.
  final client = OpenAIClient(
    apiKey: const String.fromEnvironment('KEY'),
    retryPolicy: const OpenAIRetryPolicy(maxAttempts: 3),
  );

  // Azure native deployments:
  final azure = OpenAIClient(
    apiKey: const String.fromEnvironment('AZURE_KEY'),
    azure: const OpenAIAzure(
      resource: 'my-resource',
      apiVersion: '2024-10-21',
      deployments: {'gpt-4o': 'gpt4o-prod'},
    ),
  );
  await azure.chat.create(
    model: 'gpt-4o', // rewritten to deployment gpt4o-prod
    messages: [OpenAIChatCompletionChoiceMessageModel.textContent(
        role: OpenAIChatMessageRole.user, text: 'ping')],
  );

  // Web-safe upload from bytes (no dart:io needed):
  await client.file.uploadBytes(
    bytes: [123, 125], // '{}'
    fileName: 'empty.jsonl',
    purpose: 'batch',
  );

  // Observe rate limits after any call:
  await client.model.list();
  print('remaining requests: ${OpenAIResponseMeta.lastRateLimit?.remainingRequests}');
}
