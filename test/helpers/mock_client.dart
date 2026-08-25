import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/test.dart';

/// A scripted HTTP client for tests: returns queued responses in order and
/// records every request so tests can assert on method/url/headers/body.
class MockClient extends http.BaseClient {
  final List<_ScriptedResponse> _queue = [];
  final List<http.BaseRequest> requests = [];

  void expectJson({
    required Map<String, dynamic> body,
    int statusCode = 200,
    Map<String, String> headers = const {'content-type': 'application/json'},
    Object? Function(http.BaseRequest request)? assertRequest,
  }) {
    _queue.add(_ScriptedResponse(
      bytes: utf8.encode(jsonEncode(body)),
      statusCode: statusCode,
      headers: headers,
      assertRequest: assertRequest,
    ));
  }

  void expectSse({
    required List<String> dataEvents,
    int statusCode = 200,
    bool endWithDone = true,
    Object? Function(http.BaseRequest request)? assertRequest,
  }) {
    final buffer = StringBuffer();
    for (final event in dataEvents) {
      buffer.write('data: $event\n\n');
    }
    if (endWithDone) {
      buffer.write('data: [DONE]\n\n');
    }
    _queue.add(_ScriptedResponse(
      bytes: utf8.encode(buffer.toString()),
      statusCode: statusCode,
      headers: const {
        'content-type': 'text/event-stream',
        'cache-control': 'no-cache',
      },
      assertRequest: assertRequest,
    ));
  }

  void expectRaw({
    required String body,
    int statusCode = 200,
    Map<String, String> headers = const {},
    Object? Function(http.BaseRequest request)? assertRequest,
  }) {
    _queue.add(_ScriptedResponse(
      bytes: utf8.encode(body),
      statusCode: statusCode,
      headers: headers,
      assertRequest: assertRequest,
    ));
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    requests.add(request);
    if (_queue.isEmpty) {
      fail(
          'MockClient received an unexpected request: ${request.method} ${request.url}');
    }
    final scripted = _queue.removeAt(0);
    final assertion = scripted.assertRequest;
    if (assertion != null) {
      final result = assertion(request);
      if (result is Future) await result;
    }
    return http.StreamedResponse(
      Stream.fromIterable([scripted.bytes]),
      scripted.statusCode,
      headers: scripted.headers,
    );
  }

  void verifyNoPending() {
    expect(_queue, isEmpty, reason: 'not all scripted responses were consumed');
  }
}

class _ScriptedResponse {
  final List<int> bytes;
  final int statusCode;
  final Map<String, String> headers;
  final Object? Function(http.BaseRequest request)? assertRequest;

  _ScriptedResponse({
    required this.bytes,
    required this.statusCode,
    required this.headers,
    this.assertRequest,
  });
}

/// Decodes a captured request body (JSON or multipart fields).
Map<String, dynamic> decodedJsonBody(http.BaseRequest request) {
  final request_ = request as http.Request;
  return jsonDecode(request_.body) as Map<String, dynamic>;
}

Map<String, String> multipartFields(http.BaseRequest request) {
  // MultipartRequest keeps fields accessible via content-type boundary parse;
  // easiest reliable path: reconstruct from the request itself.
  final request_ = request as http.MultipartRequest;
  return request_.fields;
}
