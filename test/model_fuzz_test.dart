import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';
import 'package:dart_openai/src/core/models/fine_tuning/models.dart';
import 'package:test/test.dart';

/// Malformed payloads must parse tolerantly or fail with a controlled
/// exception — never a crash the caller cannot catch meaningfully.
void main() {
  const garbageMaps = <String, Map<String, dynamic>>{
    'empty': {},
    'all-null': {
      'id': null,
      'object': null,
      'data': null,
      'choices': null,
      'model': null,
    },
    'wrong-types': {
      'id': 123,
      'object': ['x'],
      'created': 'not-an-int',
      'data': [null, 1, 'str'],
      'usage': 'nope',
      'error': {'message': 42},
    },
  };

  Future<void> expectTolerant(
    dynamic Function(Map<String, dynamic>) parse,
  ) async {
    for (final entry in garbageMaps.entries) {
      try {
        parse(entry.value);
      } on ArgumentError {
        // controlled rejection is fine
      } on FormatException {
        // controlled rejection is fine
      }
      // TypeError / NoSuchMethodError /CastError would propagate = failure.
    }
  }

  test('chat completion model', () async {
    await expectTolerant(OpenAIChatCompletionModel.fromMap);
  });

  test('stream chat chunk', () async {
    await expectTolerant(OpenAIStreamChatCompletionModel.fromMap);
  });

  test('image model', () async {
    await expectTolerant(OpenAIImageModel.fromMap);
  });

  test('file model', () async {
    await expectTolerant(OpenAIFileModel.fromMap);
  });

  test('embedding model', () async {
    await expectTolerant(OpenAIEmbeddingsModel.fromMap);
  });

  test('moderation model', () async {
    await expectTolerant(OpenAIModerationModel.fromMap);
  });

  test('response model', () async {
    await expectTolerant(OpenAiResponse.fromMap);
  });

  test('batch model', () async {
    await expectTolerant(BatchModelParsing.fromMap);
  });

  test('fine-tuning job', () async {
    await expectTolerant(OpenAIFineTuningJob.fromMap);
  });

  test('upload model', () async {
    await expectTolerant(UploadModelParsing.fromMap);
  });

  test('vector store chunking strategy falls back on unknown type', () {
    final strategy = OpenAIVectorStoreChunkingStrategy.fromMap({
      'type': 'brand-new-unknown-type',
    });
    // Tolerates unknown types instead of throwing.
    expect(strategy, isNotNull);
  });

  test('eval data source falls back on unknown type', () {
    final source = DatatSourceConfig.fromMap({
      'type': 'mystery',
      'schema': {'a': 1},
    });
    expect(source.type, 'mystery');
  });

  test('tool call arguments normalize object -> json string (#217)', () {
    final call = OpenAIStreamResponseToolCall.fromMap({
      'id': 'call_1',
      'type': 'function',
      'function': {
        'name': 'get_weather',
        'arguments': {'city': 'Paris'},
      },
      'index': 0,
    });
    final decoded =
        jsonDecode(call.function!.arguments!) as Map<String, dynamic>;
    expect(decoded['city'], 'Paris');
  });

  test('azure rewrite maps deployment and api-version', () {
    const config = OpenAIClientConfig(
      apiKey: 'k',
      azure: OpenAIAzure(
        resource: 'my-res',
        apiVersion: '2024-10-21',
        deployments: {'gpt-4o': 'gpt4o-prod'},
      ),
    );
    final (uri, body) = openAIAzureRewrite(
      uri: Uri.parse('https://api.openai.com/v1/chat/completions'),
      body: {'model': 'gpt-4o', 'messages': []},
      config: config,
    );

    expect(uri.host, 'my-res.openai.azure.com');
    expect(uri.path, '/openai/deployments/gpt4o-prod/chat/completions');
    expect(uri.queryParameters['api-version'], '2024-10-21');
    expect(body['model'], 'gpt4o-prod');
  });
}
