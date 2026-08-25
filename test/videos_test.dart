import 'dart:convert';

import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:dart_openai/src/instance/videos/videos.dart';
import 'package:test/test.dart';

import 'helpers/mock_client.dart';

void main() {
  OpenAIVideos videos() =>
      OpenAIVideos(const OpenAIClientConfig(apiKey: 'sk-test'));

  group('videos endpoints', () {
    test('create posts correct body and parses async job', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'id': 'video_1',
          'object': 'video',
          'created_at': 1750000000,
          'model': 'sora-2',
          'prompt': 'a cat surfing',
          'status': 'queued',
          'progress': 0,
          'seconds': 4,
          'size': '720x1280',
        },
        assertRequest: (request) {
          expect(request.method, 'POST');
          expect(request.url.toString(), 'https://api.openai.com/v1/videos');
          final body = decodedJsonBody(request);
          expect(body['model'], 'sora-2');
          expect(body['prompt'], 'a cat surfing');
          expect(body['seconds'], '4');
          expect(body['size'], '720x1280');
        },
      );

      final video = await videos().create(
        model: 'sora-2',
        prompt: 'a cat surfing',
        seconds: '4',
        size: '720x1280',
      );

      expect(video.id, 'video_1');
      expect(video.object, 'video');
      expect(video.status, 'queued');
      expect(video.progress, 0);
    });

    test('create omits optional fields when null', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'id': 'video_2', 'object': 'video', 'status': 'queued'},
        assertRequest: (request) {
          final body = decodedJsonBody(request);
          expect(body.containsKey('seconds'), isFalse);
          expect(body.containsKey('size'), isFalse);
          expect(body.containsKey('input_reference'), isFalse);
        },
      );

      await videos().create(model: 'sora-2', prompt: 'test');
    });

    test('list parses data and has_more with query params', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'object': 'list',
          'data': [
            {
              'id': 'video_1',
              'object': 'video',
              'model': 'sora-2',
              'prompt': 'p',
              'status': 'completed',
              'progress': 100,
            },
            {
              'id': 'video_2',
              'object': 'video',
              'model': 'sora-2',
              'prompt': 'q',
              'status': 'failed',
              'progress': 42,
              'error': {'message': 'boom'},
            },
          ],
          'has_more': true,
        },
        assertRequest: (request) {
          expect(request.url.toString(),
              'https://api.openai.com/v1/videos?after=video_0&limit=10');
        },
      );

      final list = await videos().list(after: 'video_0', limit: 10);

      expect(list.data.length, 2);
      expect(list.hasMore, isTrue);
      expect(list.data[0].status, 'completed');
      expect(list.data[0].progress, 100);
      expect(list.data[1].status, 'failed');
      expect((list.data[1].error as Map)['message'], 'boom');
    });

    test('retrieve hits /v1/videos/{id}', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'id': 'video_9',
          'object': 'video',
          'status': 'in_progress',
          'progress': 55,
        },
        assertRequest: (request) {
          expect(request.method, 'GET');
          expect(request.url.toString(),
              'https://api.openai.com/v1/videos/video_9');
        },
      );

      final video = await videos().retrieve(videoId: 'video_9');

      expect(video.status, 'in_progress');
      expect(video.progress, 55);
    });

    test('delete hits DELETE /v1/videos/{id} and parses response', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {'id': 'video_3', 'object': 'video', 'deleted': true},
        assertRequest: (request) {
          expect(request.method, 'DELETE');
          expect(request.url.toString(),
              'https://api.openai.com/v1/videos/video_3');
        },
      );

      final deleted = await videos().delete(videoId: 'video_3');

      expect(deleted.id, 'video_3');
      expect(deleted.object, 'video');
    });

    test('remix posts prompt to /v1/videos/{id}/remix', () async {
      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectJson(
        body: {
          'id': 'video_remix',
          'object': 'video',
          'status': 'queued',
          'prompt': 'make it night time',
        },
        assertRequest: (request) {
          expect(request.method, 'POST');
          expect(request.url.toString(),
              'https://api.openai.com/v1/videos/video_1/remix');
          expect(decodedJsonBody(request)['prompt'], 'make it night time');
        },
      );

      final remixed = await videos().remix(
        videoId: 'video_1',
        prompt: 'make it night time',
      );

      expect(remixed.id, 'video_remix');
      expect(remixed.prompt, 'make it night time');
    });

    test('downloadContent GETs /v1/videos/{id}/content and returns raw body',
        () async {
      final mp4Bytes = utf8.encode('fake-mp4-bytes');
      final base64Body = base64.encode(mp4Bytes);

      final mock = MockClient();
      OpenAINetworkingClient.clientFactory = () => mock;
      mock.expectRaw(
        body: base64Body,
        headers: {'content-type': 'video/mp4'},
        assertRequest: (request) {
          expect(request.method, 'GET');
          expect(request.url.toString(),
              'https://api.openai.com/v1/videos/video_1/content');
        },
      );

      final content = await videos().downloadContent(videoId: 'video_1');

      expect(content, base64Body);
      expect(base64.decode(content), mp4Bytes);
    });
  });
}
