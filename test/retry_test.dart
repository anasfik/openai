import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:test/test.dart';

import 'helpers/mock_client.dart';

void main() {
  test('retries GET on 503 and succeeds on second attempt', () async {
    final mock = MockClient();
    OpenAINetworkingClient.clientFactory = () => mock;
    mock.expectRaw(body: 'boom', statusCode: 503);
    mock.expectJson(body: {'data': [{'id': 'm1'}]});

    final client = OpenAIClient(
      apiKey: 'sk-a',
      retryPolicy: const OpenAIRetryPolicy(initialBackoff: Duration(milliseconds: 1)),
    );

    final models = await client.model.list();
    expect(models.single.id, 'm1');
    expect(mock.requests.length, 2);
  });

  test('does not retry when maxAttempts is 1', () async {
    final mock = MockClient();
    OpenAINetworkingClient.clientFactory = () => mock;
    mock.expectRaw(body: 'down', statusCode: 500);

    final client = OpenAIClient(apiKey: 'sk-a', retryPolicy: OpenAIRetryPolicy.none);

    await expectLater(client.model.list(), throwsA(isA<RequestFailedException>()));
    expect(mock.requests.length, 1);
  });

  test('does not retry 400-class errors', () async {
    final mock = MockClient();
    OpenAINetworkingClient.clientFactory = () => mock;
    mock.expectJson(
      statusCode: 400,
      body: {'error': {'message': 'bad request'}},
    );

    final client = OpenAIClient(apiKey: 'sk-a');

    await expectLater(client.model.list(), throwsA(isA<RequestFailedException>()));
    expect(mock.requests.length, 1);
  });

  test('records rate limit headers from last response', () async {
    final mock = MockClient();
    OpenAINetworkingClient.clientFactory = () => mock;
    mock.expectRaw(
      body: jsonEncode({'data': []}),
      headers: {
        'content-type': 'application/json',
        'x-ratelimit-remaining-requests': '41',
        'x-ratelimit-limit-requests': '60',
      },
    );

    final client = OpenAIClient(apiKey: 'sk-a');
    await client.model.list();

    expect(OpenAIResponseMeta.lastRateLimit?.remainingRequests, 41);
    expect(OpenAIResponseMeta.lastRateLimit?.limitRequests, 60);
  });
}
