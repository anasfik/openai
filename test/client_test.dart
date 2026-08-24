import 'package:dart_openai/dart_openai.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:dart_openai/src/core/models/batch/batch.dart';
import 'package:dart_openai/src/core/models/uploads/uploads.dart';
import 'package:test/test.dart';

import 'helpers/mock_client.dart';

void main() {
  group('client config & auth', () {
    test('default client sends bearer token and organization headers',
        () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(body: {'id': 'batch_1', 'object': 'batch'});

      final client = OpenAIClient(
        apiKey: 'sk-a',
        organization: 'org-1',
      );

      await client.batch.get(batchId: 'batch_1');

      final request = mock.requests.single;
      expect(request.headers['Authorization'], 'Bearer sk-a');
      expect(request.headers['OpenAI-Organization'], 'org-1');
      expect(request.url.toString(), 'https://api.openai.com/v1/batches/batch_1');
    });

    test('two clients are isolated from each other', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(body: {'id': 'x', 'data': []});
      mock.expectJson(body: {'id': 'y', 'data': []});

      final a = OpenAIClient(apiKey: 'sk-a');
      final b = OpenAIClient(apiKey: 'sk-b');

      await a.model.list();
      await b.model.list();

      expect(mock.requests[0].headers['Authorization'], 'Bearer sk-a');
      expect(mock.requests[1].headers['Authorization'], 'Bearer sk-b');
    });

    test('compatible provider overrides base url and adds custom headers',
        () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(body: {'data': []});

      final deepseek = OpenAIClient(
        apiKey: 'ds-1',
        baseUrl: 'https://api.deepseek.com',
        version: 'v1',
        extraHeaders: {'X-Provider': 'deepseek'},
      );

      await deepseek.model.list();

      final request = mock.requests.single;
      expect(request.url.host, 'api.deepseek.com');
      expect(request.headers['X-Provider'], 'deepseek');
      expect(request.headers['Authorization'], 'Bearer ds-1');
    });
  });

  group('batch endpoints', () {
    test('create posts correct body and parses model', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'id': 'batch_abc',
          'object': 'batch',
          'endpoint': '/v1/chat/completions',
          'input_file_id': 'file-1',
          'status': 'validating',
          'completion_window': '24h',
        },
        assertRequest: (request) {
          expect(request.url.toString(), 'https://api.openai.com/v1/batches');
          expect(request.method, 'POST');
          final body = decodedJsonBody(request);
          expect(body['completion_window'], '24h');
          expect(body['input_file_id'], 'file-1');
        },
      );

      final client = OpenAIClient(apiKey: 'sk-a');
      final batch = await client.batch.create(
        completionWindow: '24h',
        endpoint: '/v1/chat/completions',
        inputFileId: 'file-1',
      );

      expect(batch.id, 'batch_abc');
      expect(batch.status, 'validating');
      mock.verifyNoPending();
    });

    test('getAll builds query params', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(body: {
        'data': [],
        'first_id': '',
        'last_id': '',
        'has_more': false,
      }, assertRequest: (request) {
        expect(request.url.queryParameters, {'after': 'b2', 'limit': '10'});
      });

      final client = OpenAIClient(apiKey: 'sk-a');
      final list = await client.batch.getAll(after: 'b2', limit: 10);
      expect(list.data, isEmpty);
    });

    test('cancel posts to the cancel path', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'id': 'batch_abc', 'status': 'cancelling'},
        statusCode: 200,
        assertRequest: (request) {
          expect(
            request.url.toString(),
            'https://api.openai.com/v1/batches/batch_abc/cancel',
          );
        },
      );

      final client = OpenAIClient(apiKey: 'sk-a');
      final batch = await client.batch.cancel(batchId: 'batch_abc');
      expect(batch.status, 'cancelling');
    });
  });

  group('uploads endpoints', () {
    test('create posts upload session body', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(body: {
        'id': 'upload_1',
        'bytes': 100,
        'filename': 'f.jsonl',
        'purpose': 'fine-tune',
        'status': 'pending',
      }, assertRequest: (request) {
        final body = decodedJsonBody(request);
        expect(body['mime_type'], 'application/jsonl');
        expect(body['purpose'], 'fine-tune');
      });

      final client = OpenAIClient(apiKey: 'sk-a');
      final upload = await client.uploads.create(
        bytes: 100,
        filename: 'f.jsonl',
        mimeType: 'application/jsonl',
        purpose: 'fine-tune',
      );
      expect(upload.id, 'upload_1');
    });

    test('cancel posts to cancel path', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(body: {
        'id': 'upload_1',
        'status': 'cancelled',
      }, assertRequest: (request) {
        expect(
            request.url.toString(),
            'https://api.openai.com/v1/uploads/upload_1/cancel');
      });

      final client = OpenAIClient(apiKey: 'sk-a');
      final upload = await client.uploads.cancel(uploadId: 'upload_1');
      expect(upload.status, 'cancelled');
    });
  });

  group('error handling', () {
    test('non-2xx with error json throws RequestFailedException', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        statusCode: 429,
        body: {
          'error': {'message': 'Rate limit reached', 'type': 'rate_limit'}
        },
      );

      final client = OpenAIClient(apiKey: 'sk-a');
      await expectLater(
        client.model.list(),
        throwsA(isA<RequestFailedException>().having(
          (e) => e.statusCode,
          'statusCode',
          429,
        )),
      );
    });
  });
}
