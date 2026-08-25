import 'package:dart_openai/dart_openai.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:test/test.dart';

import 'helpers/mock_client.dart';

void main() {
  group('audio voices & voice consents', () {
    test('listVoices hits /audio/voices and returns raw maps', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'data': [
            {'voice_id': 'v1', 'name': 'alloy'},
            {'name': 'verse'},
          ],
        },
        assertRequest: (request) {
          expect(request.method, 'GET');
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/audio/voices',
          );
          return null;
        },
      );

      final voices = await OpenAIClient(apiKey: 'sk-a').audio.listVoices();

      expect(voices.length, 2);
      expect(voices[0]['voice_id'], 'v1');
      expect(voices[1]['name'], 'verse');
      mock.verifyNoPending();
    });

    test('getVoiceConsent hits /audio/voice_consents/{id}', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'id': 'consent_1', 'status': 'verified'},
        assertRequest: (request) {
          expect(request.method, 'GET');
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/audio/voice_consents/consent_1',
          );
          return null;
        },
      );

      final consent = await OpenAIClient(apiKey: 'sk-a').audio.getVoiceConsent(
            consentId: 'consent_1',
          );

      expect(consent['id'], 'consent_1');
      expect(consent['status'], 'verified');
      mock.verifyNoPending();
    });

    test('deleteVoiceConsent sends DELETE to /audio/voice_consents/{id}',
        () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'id': 'consent_2', 'deleted': true},
        assertRequest: (request) {
          expect(request.method, 'DELETE');
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/audio/voice_consents/consent_2',
          );
          return null;
        },
      );

      final result =
          await OpenAIClient(apiKey: 'sk-a').audio.deleteVoiceConsent(
                consentId: 'consent_2',
              );

      expect(result['deleted'], isTrue);
      mock.verifyNoPending();
    });
  });
}
