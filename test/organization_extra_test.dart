import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:dart_openai/src/instance/organization/organization.dart';
import 'package:test/test.dart';

import 'helpers/mock_client.dart';

void main() {
  OpenAIOrganization client() => OpenAIOrganization(
        const OpenAIClientConfig(apiKey: 'sk-a'),
      );

  group('usage', () {
    test('builds /v1/organization/usage/completions url and parses buckets',
        () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'data': [
              {
                'start_time': 1700000000,
                'end_time': 1700086400,
                'result': {'input_tokens': 10},
              },
              {'start_time': 1700086400},
            ],
            'has_more': false,
          },
          assertRequest: (request) {
            expect(
              request.url.toString(),
              startsWith(
                'https://api.openai.com/v1/organization/usage/completions?start_time=1700000000',
              ),
            );
            expect(request.url.queryParameters, {
              'start_time': '1700000000',
              'end_time': '1700086400',
              'bucket_width': '86400',
              'project_ids': 'proj_1,proj_2',
              'group_by': 'model',
              'after': 'b0',
              'limit': '2',
            });
            return null;
          });

      final buckets = await client().usage.usage(
            kind: 'completions',
            startTime: 1700000000,
            endTime: 1700086400,
            bucketWidth: 86400,
            projectIds: ['proj_1', 'proj_2'],
            groupBy: ['model'],
            after: 'b0',
            limit: 2,
          );

      expect(buckets.length, 2);
      expect(buckets.first['result']['input_tokens'], 10);
    });

    test('embeddings kind lands on its own path', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'data': [],
            'has_more': false,
          },
          assertRequest: (request) {
            expect(request.url.path, '/v1/organization/usage/embeddings');
            return null;
          });

      final buckets = await client().usage.usage(
            kind: 'embeddings',
            startTime: 1,
          );
      expect(buckets, isEmpty);
    });
  });

  group('spend limits & alerts', () {
    test('spend_limit get parses limits', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'id': 'sl_1',
            'hard_limit_usd': 100.5,
            'soft_limit_usd': 80,
          },
          assertRequest: (request) {
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/spend_limit',
            );
            return null;
          });

      final limit = await client().spendLimits.get();
      expect(limit.id, 'sl_1');
      expect(limit.hardLimitUsd, 100.5);
      expect(limit.softLimitUsd, 80);
    });

    test('spend_limit post sends usd body', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'id': 'sl_1',
            'hard_limit_usd': 500,
          },
          assertRequest: (request) {
            expect(request.method, 'POST');
            final body = decodedJsonBody(request);
            expect(body['hard_limit_usd'], 500.0);
            expect(body.containsKey('soft_limit_usd'), isFalse);
            return null;
          });

      await client().spendLimits.update(hardLimitUsd: 500);
    });

    test('alert create then delete round trip', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'id': 'al_1',
            'threshold_usd': 25,
            'project_id': 'proj_3',
          },
          assertRequest: (request) {
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/spend_limit/alerts',
            );
            final body = decodedJsonBody(request);
            expect(body['threshold_usd'], 25.0);
            expect(body['project_id'], 'proj_3');
            return null;
          });
      mock.expectJson(
          body: {
            'id': 'al_1',
            'deleted': true,
          },
          assertRequest: (request) {
            expect(request.method, 'DELETE');
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/spend_limit/alerts/al_1',
            );
            return null;
          });

      final org = client();
      final alert = await org.spendLimits.createAlert(
        thresholdUsd: 25,
        projectId: 'proj_3',
      );
      expect(alert.id, 'al_1');
      expect(await org.spendLimits.deleteAlert(alertId: alert.id), isTrue);
    });
  });

  group('certificates', () {
    test('activate posts certificate_ids to activate path', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'activated': ['cert_1'],
          },
          assertRequest: (request) {
            expect(request.method, 'POST');
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/certificates/activate',
            );
            expect(decodedJsonBody(request)['certificate_ids'], ['cert_1']);
            return null;
          });

      final result = await client().certificates.activate(ids: ['cert_1']);
      expect(result['activated'], ['cert_1']);
    });

    test('delete hits certificate id path', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'id': 'cert_2',
            'deleted': true,
          },
          assertRequest: (request) {
            expect(request.method, 'DELETE');
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/certificates/cert_2',
            );
            return null;
          });

      final deleted =
          await client().certificates.delete(certificateId: 'cert_2');
      expect(deleted, isTrue);
    });
  });

  group('groups', () {
    test('create posts name body', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'id': 'grp_1',
            'name': 'eng',
            'description': 'engineers',
          },
          assertRequest: (request) {
            expect(request.method, 'POST');
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/groups',
            );
            final body = decodedJsonBody(request);
            expect(body['name'], 'eng');
            expect(body['description'], 'engineers');
            return null;
          });

      final group =
          await client().groups.create(name: 'eng', description: 'engineers');
      expect(group.id, 'grp_1');
      expect(group.name, 'eng');
    });

    test('add users posts user_ids to group users path', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {},
          assertRequest: (request) {
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/groups/grp_1/users',
            );
            expect(decodedJsonBody(request)['user_ids'], ['user_1', 'user_2']);
            return null;
          });

      await client()
          .groups
          .addUsers(groupId: 'grp_1', userIds: ['user_1', 'user_2']);
    });

    test('group roles land on roles path', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'data': [
              {'id': 'role_owner', 'name': 'Owner'},
            ],
          },
          assertRequest: (request) {
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/groups/grp_1/roles',
            );
            return null;
          });

      final roles = await client().groups.listRoles(groupId: 'grp_1');
      expect(roles.single['id'], 'role_owner');
    });
  });

  group('service accounts', () {
    test('delete hits project service account path', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'id': 'sa_1',
            'deleted': true,
          },
          assertRequest: (request) {
            expect(request.method, 'DELETE');
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/projects/proj_7/service_accounts/sa_1',
            );
            return null;
          });

      final deleted = await client().serviceAccounts.delete(
            projectId: 'proj_7',
            serviceAccountId: 'sa_1',
          );
      expect(deleted, isTrue);
    });

    test('api key delete nests under service account', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {'deleted': true},
          assertRequest: (request) {
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/projects/proj_7/service_accounts/sa_1/api_keys/key_9',
            );
            return null;
          });

      final deleted = await client().serviceAccounts.deleteApiKey(
            projectId: 'proj_7',
            serviceAccountId: 'sa_1',
            apiKeyId: 'key_9',
          );
      expect(deleted, isTrue);
    });
  });

  group('data retention', () {
    test('per-project path and body', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'id': 'dr_1',
            'retention_window_days': 30,
          },
          assertRequest: (request) {
            expect(request.method, 'POST');
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/projects/proj_7/data_retention',
            );
            expect(decodedJsonBody(request)['retention_window_days'], 30);
            return null;
          });

      final config = await client().dataRetention.updateForProject(
            projectId: 'proj_7',
            retentionWindowDays: 30,
          );
      expect(config.retentionWindowDays, 30);
    });
  });

  group('permissions', () {
    test('project model_permissions path', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'data': [
              {'id': 'gpt-4o'},
            ],
          },
          assertRequest: (request) {
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/projects/proj_7/model_permissions',
            );
            return null;
          });

      final result =
          await client().projects.modelPermissions(projectId: 'proj_7');
      expect((result['data'] as List).length, 1);
    });

    test('project hosted_tool_permissions path', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {'enabled': true},
          assertRequest: (request) {
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/projects/proj_7/hosted_tool_permissions',
            );
            return null;
          });

      final result =
          await client().projects.hostedToolPermissions(projectId: 'proj_7');
      expect(result['enabled'], isTrue);
    });
  });

  group('roles', () {
    test('list and retrieve paths', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'data': [
              {'id': 'role_owner', 'name': 'Owner'},
              {'id': 'role_member', 'name': 'Member'},
            ],
            'has_more': false,
          },
          assertRequest: (request) {
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/roles',
            );
            return null;
          });
      mock.expectJson(
          body: {
            'id': 'role_member',
            'name': 'Member',
          },
          assertRequest: (request) {
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/roles/role_member',
            );
            return null;
          });

      final org = client();
      final page = await org.roles.list();
      expect(page.data.last.id, 'role_member');

      final role = await org.roles.retrieve(roleId: 'role_member');
      expect(role.name, 'Member');
    });
  });

  group('aggregator', () {
    test('exposes new modules sharing one config', () {
      final org = client();
      expect(org.usage, isA<OpenAIUsage>());
      expect(org.spendLimits, isA<OpenAISpendLimits>());
      expect(org.certificates, isA<OpenAICertificates>());
      expect(org.groups, isA<OpenAIGroups>());
      expect(org.serviceAccounts, isA<OpenAIServiceAccounts>());
      expect(org.dataRetention, isA<OpenAIDataRetention>());
      expect(org.roles, isA<OpenAIRoles>());
    });
  });
}
