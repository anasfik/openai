import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:dart_openai/src/instance/provenance/provenance.dart';
import 'package:dart_openai/src/instance/skills/skills.dart';
import 'package:test/test.dart';

import 'helpers/mock_client.dart';

void main() {
  OpenAISkills skills() =>
      OpenAISkills(const OpenAIClientConfig(apiKey: 'sk-test'));

  OpenAIProvenance provenance() =>
      OpenAIProvenance(const OpenAIClientConfig(apiKey: 'sk-test'));

  group('skills endpoints', () {
    test('list hits /skills and parses wrapper', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'data': [
            {
              'id': 'skill_1',
              'object': 'skill',
              'name': 'code-review',
              'created_at': 1750000000,
              'version': '2',
            },
          ],
          'has_more': false,
        },
        assertRequest: (request) {
          expect(request.method, 'GET');
          expect(request.url.toString(), 'https://api.openai.com/v1/skills');
        },
      );

      final list = await skills().list();

      expect(list.data.single.id, 'skill_1');
      expect(list.data.single.name, 'code-review');
      expect(list.data.single.createdAt, 1750000000);
      expect(list.data.single.version, '2');
      expect(list.hasMore, isFalse);
    });

    test('retrieve hits /skills/{id}', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'id': 'skill_9', 'object': 'skill', 'name': 'writer'},
        assertRequest: (request) {
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/skills/skill_9',
          );
        },
      );

      final skill = await skills().retrieve(skillId: 'skill_9');

      expect(skill.id, 'skill_9');
      expect(skill.name, 'writer');
    });

    test('delete hits /skills/{id} with DELETE', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'id': 'skill_3', 'deleted': true},
        assertRequest: (request) {
          expect(request.method, 'DELETE');
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/skills/skill_3',
          );
        },
      );

      final result = await skills().delete(skillId: 'skill_3');

      expect(result['deleted'], isTrue);
    });

    test('getContent hits /skills/{id}/content', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'files': [
            {'path': 'SKILL.md'}
          ]
        },
        assertRequest: (request) {
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/skills/skill_5/content',
          );
        },
      );

      final content = await skills().getContent(skillId: 'skill_5');

      expect((content['files'] as List).first['path'], 'SKILL.md');
    });

    test('listVersions hits /skills/{id}/versions', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'data': [
            {'version': '1'},
            {'version': '2'},
          ],
        },
        assertRequest: (request) {
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/skills/skill_7/versions',
          );
        },
      );

      final versions = await skills().listVersions(skillId: 'skill_7');

      expect(versions.length, 2);
      expect(versions[1]['version'], '2');
    });

    test('getVersion hits /skills/{id}/versions/{version}', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'version': '3', 'changelog': 'fixes'},
        assertRequest: (request) {
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/skills/skill_7/versions/3',
          );
        },
      );

      final version =
          await skills().getVersion(skillId: 'skill_7', version: '3');

      expect(version['changelog'], 'fixes');
    });
  });

  group('content provenance checks', () {
    test('create posts flexible body passthrough', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'id': 'cpc_1', 'status': 'completed'},
        assertRequest: (request) {
          expect(request.method, 'POST');
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/content_provenance_checks',
          );
          final body = decodedJsonBody(request);
          expect(body['input'], 'some text');
          expect(body['nested'], {'a': 1});
          expect(body['items'], [1, 2, 3]);
        },
      );

      final check = await provenance().create({
        'input': 'some text',
        'nested': {'a': 1},
        'items': [1, 2, 3],
      });

      expect(check['id'], 'cpc_1');
      expect(check['status'], 'completed');
    });
  });
}
