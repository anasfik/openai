import 'package:dart_openai/dart_openai.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:dart_openai/src/instance/realtime/realtime.dart';
import 'package:test/test.dart';

import 'helpers/mock_client.dart';

void main() {
  setUp(() {
    OpenAI.apiKey = 'sk-test';
  });

  group('realtime REST endpoints', () {
    test('createSession posts model/voice and parses client_secret', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'id': 'sess_1',
          'object': 'realtime.session',
          'expires_at': 1739820000,
          'session': {'model': 'gpt-realtime', 'voice': 'alloy'},
          'client_secret': {
            'value': 'ek_abc123',
            'expires_at': 1739906400,
          },
        },
        assertRequest: (request) {
          expect(request.headers['Authorization'], 'Bearer sk-test');
          expect(request.url.toString(),
              'https://api.openai.com/v1/realtime/sessions');
          expect(request.method, 'POST');
          final body = decodedJsonBody(request);
          expect(body['model'], 'gpt-realtime');
          expect(body['voice'], 'alloy');
          expect(body['instructions'], 'Be brief.');
          expect(body['modalities'], ['text', 'audio']);
          return null;
        },
      );

      final realtime = OpenAIRealtime();
      final session = await realtime.createSession(
        modalities: ['text', 'audio'],
        voice: 'alloy',
        instructions: 'Be brief.',
      );

      expect(session.id, 'sess_1');
      expect(session.object, 'realtime.session');
      expect(session.expiresAt, 1739820000);
      expect(session.session['model'], 'gpt-realtime');
      expect(session.clientSecret?.value, 'ek_abc123');
      expect(session.clientSecret?.expiresAt, 1739906400);
      mock.verifyNoPending();
    });

    test('createTranscriptionSession hits transcription_sessions', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'id': 'ts_1',
          'object': 'realtime.transcription_session',
          'session': {'input_audio_format': 'pcm16'},
        },
        assertRequest: (request) {
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/realtime/transcription_sessions',
          );
          expect(request.method, 'POST');
          return null;
        },
      );

      final session = await OpenAIRealtime().createTranscriptionSession();

      expect(session.id, 'ts_1');
      expect(session.object, 'realtime.transcription_session');
      expect(session.session['input_audio_format'], 'pcm16');
      expect(session.clientSecret, isNull);
      mock.verifyNoPending();
    });

    test('createClientSecret wraps session map in request body', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'value': 'ek_xyz',
          'expires_at': 1234,
          'session': {'model': 'gpt-realtime-mini'},
        },
        assertRequest: (request) {
          expect(request.url.toString(),
              'https://api.openai.com/v1/realtime/client_secrets');
          final body = decodedJsonBody(request);
          expect(body['session']['model'], 'gpt-realtime-mini');
          expect(body['session']['voice'], 'nova');
          return null;
        },
      );

      final secret = await OpenAIRealtime().createClientSecret(
        session: {'model': 'gpt-realtime-mini', 'voice': 'nova'},
      );

      // Loose response shape: fields may sit at top level.
      expect(secret.id, '');
      expect(secret.session['model'], 'gpt-realtime-mini');
      mock.verifyNoPending();
    });

    test('createTranslationClientSecret uses translations path', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'value': 'ek_tr',
          'expires_at': 5678,
          'session': {'model': 'gpt-realtime'},
        },
        assertRequest: (request) {
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/realtime/translations/client_secrets',
          );
          return null;
        },
      );

      final secret = await OpenAIRealtime()
          .createTranslationClientSecret(session: {'model': 'gpt-realtime'});

      expect(secret.session['model'], 'gpt-realtime');
      mock.verifyNoPending();
    });
  });
}
