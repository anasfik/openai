import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/io/openai_file.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:dart_openai/src/instance/realtime/realtime.dart';
import 'package:dart_openai/src/instance/skills/skills.dart';
import 'package:dart_openai/src/instance/videos/videos.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

import 'helpers/mock_client.dart';

void main() {
  const config = OpenAIClientConfig(apiKey: 'sk-test');

  OpenAIVideos videos() => OpenAIVideos(config);
  OpenAIRealtime realtime() => OpenAIRealtime(config);
  OpenAISkills skills() => OpenAISkills(config);

  OpenAIFile videoFile() => const OpenAIFile(
        bytes: [1, 2, 3, 4],
        fileName: 'input.mp4',
        contentType: 'video/mp4',
      );

  group('videos edits/extensions/characters', () {
    test('createEdit posts multipart to /v1/videos/edits with video field',
        () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'id': 'video_edit',
          'object': 'video',
          'status': 'queued',
          'progress': 0,
          'prompt': 'make it snow',
        },
        assertRequest: (request) {
          expect(request.method, 'POST');
          expect(request.url.toString(),
              'https://api.openai.com/v1/videos/edits');
          final multipart = request as http.MultipartRequest;
          expect(multipart.fields['model'], 'sora-2');
          expect(multipart.fields['prompt'], 'make it snow');
          expect(multipart.fields['seconds'], '8');
          expect(multipart.files.single.field, 'video');
          expect(multipart.files.single.filename, 'input.mp4');
          expect(multipart.files.single.length, 4);
          return null;
        },
      );

      final video = await videos().createEdit(
        model: 'sora-2',
        prompt: 'make it snow',
        video: videoFile(),
        seconds: '8',
      );

      expect(video.id, 'video_edit');
      expect(video.status, 'queued');
    });

    test('createExtension posts multipart to /v1/videos/extensions',
        () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'id': 'video_ext',
          'object': 'video',
          'status': 'queued',
          'prompt': 'continue the scene',
        },
        assertRequest: (request) {
          expect(request.method, 'POST');
          expect(request.url.toString(),
              'https://api.openai.com/v1/videos/extensions');
          final multipart = request as http.MultipartRequest;
          expect(multipart.fields['prompt'], 'continue the scene');
          expect(multipart.fields.containsKey('model'), isFalse);
          expect(multipart.files.single.field, 'video');
          expect(multipart.files.single.filename, 'input.mp4');
          return null;
        },
      );

      final video = await videos().createExtension(
        prompt: 'continue the scene',
        video: videoFile(),
      );

      expect(video.id, 'video_ext');
      expect(video.prompt, 'continue the scene');
    });

    test('listCharacters GETs /v1/videos/characters', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'object': 'list',
          'data': [
            {'id': 'char_1', 'object': 'video.character', 'name': 'nova'},
          ],
        },
        assertRequest: (request) {
          expect(request.method, 'GET');
          expect(request.url.toString(),
              'https://api.openai.com/v1/videos/characters');
          return null;
        },
      );

      final characters = await videos().listCharacters();

      expect(characters['object'], 'list');
      expect((characters['data'] as List).first['id'], 'char_1');
    });

    test('retrieveCharacter hits /v1/videos/characters/{id}', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'id': 'char_2', 'object': 'video.character', 'name': 'orion'},
        assertRequest: (request) {
          expect(request.method, 'GET');
          expect(request.url.toString(),
              'https://api.openai.com/v1/videos/characters/char_2');
          return null;
        },
      );

      final character =
          await videos().retrieveCharacter(characterId: 'char_2');

      expect(character['name'], 'orion');
    });

    test('deleteCharacter DELETEs /v1/videos/characters/{id}', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'id': 'char_3', 'deleted': true},
        assertRequest: (request) {
          expect(request.method, 'DELETE');
          expect(request.url.toString(),
              'https://api.openai.com/v1/videos/characters/char_3');
          return null;
        },
      );

      final result = await videos().deleteCharacter(characterId: 'char_3');

      expect(result['deleted'], isTrue);
    });
  });

  group('realtime call control', () {
    test('acceptCall POSTs sdp to /v1/realtime/calls/{id}/accept', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'accepted': true},
        assertRequest: (request) {
          expect(request.method, 'POST');
          expect(request.url.toString(),
              'https://api.openai.com/v1/realtime/calls/call_1/accept');
          expect(decodedJsonBody(request)['type'], 'sdp');
          expect(decodedJsonBody(request)['sdp'], 'v=0 o=- ...');
          return null;
        },
      );

      final result = await realtime().acceptCall(
        callId: 'call_1',
        sdp: 'v=0 o=- ...',
      );

      expect(result['accepted'], isTrue);
    });

    test('rejectCall POSTs /v1/realtime/calls/{id}/reject', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {},
        assertRequest: (request) {
          expect(request.method, 'POST');
          expect(request.url.toString(),
              'https://api.openai.com/v1/realtime/calls/call_2/reject');
          return null;
        },
      );

      await realtime().rejectCall(callId: 'call_2');
    });

    test('hangupCall DELETEs /v1/realtime/calls/{id}', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {},
        assertRequest: (request) {
          expect(request.method, 'DELETE');
          expect(request.url.toString(),
              'https://api.openai.com/v1/realtime/calls/call_3');
          return null;
        },
      );

      await realtime().hangupCall(callId: 'call_3');
    });

    test('referCall POSTs target to /v1/realtime/calls/{id}/refer', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'referred': true},
        assertRequest: (request) {
          expect(request.method, 'POST');
          expect(request.url.toString(),
              'https://api.openai.com/v1/realtime/calls/call_4/refer');
          expect(decodedJsonBody(request)['target'], 'sip:agent@example.com');
          return null;
        },
      );

      final result = await realtime().referCall(
        callId: 'call_4',
        target: 'sip:agent@example.com',
      );

      expect(result['referred'], isTrue);
    });
  });

  group('skills version content', () {
    test('getVersionContent GETs /skills/{id}/versions/{version}/content',
        () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'files': [
            {'path': 'SKILL.md', 'version': '3'},
          ],
        },
        assertRequest: (request) {
          expect(request.method, 'GET');
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/skills/skill_7/versions/3/content',
          );
          return null;
        },
      );

      final content = await skills().getVersionContent(
        skillId: 'skill_7',
        version: '3',
      );

      expect((content['files'] as List).first['path'], 'SKILL.md');
      expect((content['files'] as List).first['version'], '3');
    });
  });
}
