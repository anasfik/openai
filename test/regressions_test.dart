import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:dart_openai/src/instance/audio/audio.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  setUpAll(() {
    OpenAI.apiKey = 'sk-test';
  });

  group('regressions', () {
    test('serializes image_url content without nesting the url object twice',
        () {
      final content =
          OpenAIChatCompletionChoiceMessageContentItemModel.imageUrl(
        'https://example.com/image.png',
      );

      expect(
        content.toMap(),
        {
          'type': 'image_url',
          'image_url': {'url': 'https://example.com/image.png'},
        },
      );
    });

    test('builds a request failure from non-standard string error payloads',
        () {
      final exception = OpenAINetworkingClient.requestFailedExceptionFromMap(
        {
          'timestamp': '2026-04-21T11:44:16.913+00:00',
          'status': 404,
          'error': 'Not Found',
          'path': '/v4/chat/completions/v1/chat/completions',
        },
        404,
      );

      expect(exception.statusCode, 404);
      expect(
        exception.message,
        'Not Found (404 @ /v4/chat/completions/v1/chat/completions)',
      );
    });

    test('builds a request failure from raw non-json stream bodies', () {
      final exception =
          OpenAINetworkingClient.requestFailedExceptionFromRawBody(
        '<html>forbidden</html>',
        403,
      );

      expect(exception.statusCode, 403);
      expect(exception.message, '<html>forbidden</html>');
    });

    test(
        'postStream surfaces non-json error bodies instead of silently swallowing them',
        () async {
      final stream = OpenAINetworkingClient.postStream<Map<String, dynamic>>(
        to: 'https://example.com/v1/chat/completions',
        onSuccess: (json) => json,
        body: const {'stream': true},
        client: _FakeClient.streaming(
          statusCode: 403,
          body: '<html>forbidden</html>',
          headers: const {'content-type': 'text/html'},
        ),
      );

      await expectLater(
        stream,
        emitsError(
          isA<Exception>().having(
            (error) => error.toString(),
            'message',
            contains('<html>forbidden</html>'),
          ),
        ),
      );
    });

    test('post converts string error payloads into RequestFailedException',
        () async {
      final future = OpenAINetworkingClient.post<Map<String, dynamic>>(
        to: 'https://example.com/v1/chat/completions',
        onSuccess: (json) => json,
        client: _FakeClient.response(
          statusCode: 404,
          body: jsonEncode({
            'timestamp': '2026-04-21T11:44:16.913+00:00',
            'status': 404,
            'error': 'Not Found',
            'path': '/v4/chat/completions/v1/chat/completions',
          }),
          headers: const {'content-type': 'application/json'},
        ),
      );

      await expectLater(
        future,
        throwsA(
          isA<Exception>().having(
            (error) => error.toString(),
            'message',
            contains('Not Found'),
          ),
        ),
      );
    });

    test('rejects unsupported legacy TTS voice and model combinations',
        () async {
      final future = OpenAIAudio().createSpeechBytes(
        model: 'tts-1',
        input: 'Hello from ballad.',
        voice: OpenAIAudioVoice.ballad,
      );

      await expectLater(
        future,
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.message,
            'message',
            contains('not supported by tts-1'),
          ),
        ),
      );
    });
  });
}

class _FakeClient extends http.BaseClient {
  final Future<http.Response> Function(http.BaseRequest request)?
      _onSendResponse;
  final Future<http.StreamedResponse> Function(http.BaseRequest request)?
      _onSendStreamedResponse;

  _FakeClient.response({
    required int statusCode,
    required String body,
    Map<String, String> headers = const {},
  })  : _onSendResponse = ((_) async => http.Response(
              body,
              statusCode,
              headers: headers,
            )),
        _onSendStreamedResponse = null;

  _FakeClient.streaming({
    required int statusCode,
    required String body,
    Map<String, String> headers = const {},
  })  : _onSendResponse = null,
        _onSendStreamedResponse = ((_) async => http.StreamedResponse(
              Stream<List<int>>.value(utf8.encode(body)),
              statusCode,
              headers: headers,
            ));

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (_onSendStreamedResponse != null) {
      return _onSendStreamedResponse!(request);
    }

    final response = await _onSendResponse!(request);
    return http.StreamedResponse(
      Stream<List<int>>.value(response.bodyBytes),
      response.statusCode,
      headers: response.headers,
      request: request,
      reasonPhrase: response.reasonPhrase,
    );
  }
}
