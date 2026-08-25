import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:dart_openai/src/instance/organization/organization.dart';
import 'package:test/test.dart';

import 'helpers/mock_client.dart';

void main() {
  group('projects', () {
    test('list builds url and parses page', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'data': [
              {
                'id': 'proj_1',
                'name': 'A',
                'status': 'active',
                'created_at': 10
              },
              {'id': 'proj_2'},
            ],
            'has_more': true,
            'first_id': 'proj_1',
            'last_id': 'proj_2',
          },
          assertRequest: (request) {
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/projects?after=p0&limit=5',
            );
          });

      final client = OpenAIOrganization(
        OpenAIClientConfig(apiKey: 'sk-a'),
      );
      final page = await client.projects.list(after: 'p0', limit: 5);

      expect(page.data.length, 2);
      expect(page.data.first.name, 'A');
      expect(page.data.last.id, 'proj_2');
      expect(page.hasMore, isTrue);
      expect(page.lastId, 'proj_2');
    });

    test('create posts name body', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'id': 'proj_9', 'name': 'New', 'status': 'active'},
        assertRequest: (request) {
          expect(request.method, 'POST');
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/organization/projects',
          );
          expect(decodedJsonBody(request)['name'], 'New');
        },
      );

      final client = OpenAIOrganization(
        OpenAIClientConfig(apiKey: 'sk-a'),
      );
      final project = await client.projects.create(name: 'New');
      expect(project.id, 'proj_9');
    });

    test('archive posts to archive path', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'id': 'proj_1', 'status': 'archived'},
        assertRequest: (request) {
          expect(request.method, 'POST');
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/organization/projects/proj_1/archive',
          );
        },
      );

      final client = OpenAIOrganization(
        OpenAIClientConfig(apiKey: 'sk-a'),
      );
      final project = await client.projects.archive(projectId: 'proj_1');
      expect(project.status, 'archived');
    });
  });

  group('users', () {
    test('list builds url and parses user', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'data': [
              {
                'id': 'user_1',
                'name': 'Gwh',
                'email': 'g@x.com',
                'role': 'owner',
                'added_at': 20,
              }
            ],
            'has_more': false,
          },
          assertRequest: (request) {
            expect(
              request.url.toString(),
              'https://api.openai.com/v1/organization/users',
            );
          });

      final client = OpenAIOrganization(
        OpenAIClientConfig(apiKey: 'sk-a'),
      );
      final page = await client.users.list();

      expect(page.data.single.email, 'g@x.com');
      expect(page.data.single.role, 'owner');
    });
  });

  group('invites', () {
    test('create posts email and role body', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'id': 'inv_1',
          'email': 'n@x.com',
          'role': 'reader',
          'status': 'invited'
        },
        assertRequest: (request) {
          final body = decodedJsonBody(request);
          expect(body['email'], 'n@x.com');
          expect(body['role'], 'reader');
        },
      );

      final client = OpenAIOrganization(
        OpenAIClientConfig(apiKey: 'sk-a'),
      );
      final invite =
          await client.invites.create(email: 'n@x.com', role: 'reader');
      expect(invite.status, 'invited');
    });

    test('delete sends DELETE to invite path', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'id': 'inv_1', 'deleted': true},
        assertRequest: (request) {
          expect(request.method, 'DELETE');
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/organization/invites/inv_1',
          );
        },
      );

      final client = OpenAIOrganization(
        OpenAIClientConfig(apiKey: 'sk-a'),
      );
      final deleted = await client.invites.delete(inviteId: 'inv_1');
      expect(deleted, isTrue);
    });
  });

  group('audit logs', () {
    test('builds query params', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'data': [
              {
                'id': 'log_1',
                'type': 'api_key.updated',
                'effective_at': 100,
                'actor': {'type': 'user'},
                'resource': {'type': 'api_key'},
              }
            ],
            'has_more': false,
          },
          assertRequest: (request) {
            expect(request.url.queryParameters, {
              'effective_at[gt]': '50',
              'effective_at[lt]': '200',
              'resource_name': 'api_key',
              'event_types[]': 'api_key.updated,project.created',
              'limit': '10',
              'after': 'log_0',
            });
          });

      final client = OpenAIOrganization(
        OpenAIClientConfig(apiKey: 'sk-a'),
      );
      final page = await client.auditLogs.list(
        effectiveAtGt: 50,
        effectiveAtLt: 200,
        resourceContains: 'api_key',
        eventTypes: ['api_key.updated', 'project.created'],
        limit: 10,
        after: 'log_0',
      );

      expect(page.data.single.type, 'api_key.updated');
      expect(page.data.single.actor['type'], 'user');
    });
  });

  group('costs', () {
    test('start_time required and included in query', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
          body: {
            'data': [
              {
                'start_time': 1700000000,
                'end_time': 1700086400,
                'result': {'usage.costs': 12.5},
              }
            ],
            'has_more': false,
          },
          assertRequest: (request) {
            expect(request.url.queryParameters['start_time'], '1700000000');
            expect(request.url.queryParameters['group_by'], 'line_item');
          });

      final client = OpenAIOrganization(
        OpenAIClientConfig(apiKey: 'sk-a'),
      );
      final page = await client.costs.list(
        startTime: 1700000000,
        endTime: 1700086400,
        groupBy: ['line_item'],
      );

      expect(page.data.single.result['usage.costs'], 12.5);
    });
  });

  group('rate limits & admin api keys', () {
    test('rate limits list parses bucket map', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(body: {
        'data': [
          {
            'id': 'rl_1',
            'model': 'gpt-4',
            'bucket': {'x-ratelimit-limit-requests': 100},
          }
        ],
        'has_more': false,
      });

      final client = OpenAIOrganization(
        OpenAIClientConfig(apiKey: 'sk-a'),
      );
      final page = await client.rateLimits.list();

      expect(page.data.single.model, 'gpt-4');
      expect(
        page.data.single.bucket['x-ratelimit-limit-requests'],
        100,
      );
    });

    test('admin api key create posts body with optional scope', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'id': 'key_1',
          'name': 'ops',
          'scope': 'registry.write',
          'value': 'sk-admin-1',
          'created_at': 30,
        },
        assertRequest: (request) {
          final body = decodedJsonBody(request);
          expect(body['name'], 'ops');
          expect(body['scope'], 'registry.write');
        },
      );

      final client = OpenAIOrganization(
        OpenAIClientConfig(apiKey: 'sk-a'),
      );
      final key = await client.adminApiKeys.create(
        name: 'ops',
        scope: 'registry.write',
      );
      expect(key.value, 'sk-admin-1');
      expect(key.scope, 'registry.write');
    });

    test('admin api key delete sends DELETE to key path', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'id': 'key_1', 'deleted': true},
        assertRequest: (request) {
          expect(request.method, 'DELETE');
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/organization/admin_api_keys/key_1',
          );
        },
      );

      final client = OpenAIOrganization(
        OpenAIClientConfig(apiKey: 'sk-a'),
      );
      final deleted = await client.adminApiKeys.delete(keyId: 'key_1');
      expect(deleted, isTrue);
    });
  });

  group('aggregator', () {
    test('exposes sub modules sharing one config', () {
      final org = OpenAIOrganization(
        OpenAIClientConfig(apiKey: 'sk-a'),
      );
      expect(org.projects, isA<OpenAIProjects>());
      expect(org.users, isA<OpenAIOrgUsers>());
      expect(org.invites, isA<OpenAIInvites>());
      expect(org.auditLogs, isA<OpenAIAuditLogs>());
      expect(org.costs, isA<OpenAICosts>());
      expect(org.rateLimits, isA<OpenAIRateLimits>());
      expect(org.adminApiKeys, isA<OpenAIAdminApiKeys>());
    });
  });
}
