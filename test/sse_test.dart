import 'dart:async';
import 'dart:convert';

import 'package:dart_openai/src/core/exceptions/request_failure.dart';
import 'package:dart_openai/src/core/networking/sse.dart';
import 'package:test/test.dart';

void main() {
  Stream<Map<String, dynamic>> parse(List<List<int>> chunks) =>
      openAIParseSseStream(Stream.fromIterable(chunks));

  List<int> chunk(String s) => utf8.encode(s);

  test('emits every data event in order', () async {
    final events = await parse([
      chunk('data: {"a":1}\n\ndata: {"a":2}\n\ndata: [DONE]\n\n'),
    ]).toList();

    expect(events, [
      {'a': 1},
      {'a': 2},
    ]);
  });

  test('handles events split across byte chunks', () async {
    final full = chunk('data: {"a":1}\n\ndata: {"b":2}\n\ndata: [DONE]\n\n');
    final half = full.length ~/ 2;
    final events =
        await parse([full.sublist(0, half), full.sublist(half)]).toList();

    expect(events.length, 2);
  });

  test('decodes multibyte utf-8 characters split across chunks', () async {
    // 'héllo 🎉' contains a 2-byte char and a 4-byte emoji.
    const text = 'héllo 🎉';
    final payload = jsonEncode({'text': text});
    final line = utf8.encode('data: $payload\n\ndata: [DONE]\n\n');
    // Split mid-emoji.
    final cut = line.length - 3;
    final events = await parse(
      [line.sublist(0, cut), line.sublist(cut)],
    ).toList();

    expect(events.single['text'], text);
  });

  test('closes immediately after the DONE sentinel', () async {
    final controller = StreamController<List<int>>();
    final parsed = openAIParseSseStream(controller.stream).toList();

    controller.add(chunk('data: {"a":1}\n\n'));
    await Future<void>.delayed(Duration.zero);
    controller.add(chunk('data: [DONE]\n\n'));
    await Future<void>.delayed(Duration.zero);
    // Data after DONE must never surface and the stream must be done.
    controller.add(chunk('data: {"late":true}\n\n'));
    await controller.close();

    final events = await parsed.timeout(const Duration(seconds: 2));
    expect(events, [
      {'a': 1},
    ]);
  });

  test('surfaces in-band error payloads as RequestFailedException', () async {
    await expectLater(
      parse([chunk('data: {"error": {"message": "boom", "type": "x"}}\n\n')]),
      emitsError(isA<RequestFailedException>().having(
        (e) => e.message,
        'message',
        'boom',
      )),
    );
  });

  test('surfaces non-SSE error bodies as RequestFailedException', () async {
    await expectLater(
      parse([chunk('<html>forbidden</html>')]),
      emitsError(isA<RequestFailedException>().having(
        (e) => e.message,
        'message',
        '<html>forbidden</html>',
      )),
    );
  });

  test('ignores comments and empty lines', () async {
    final events = await parse([
      chunk(': keep-alive\n\ndata: {"a":1}\n\n\n\n'),
      chunk('data: [DONE]\n\n'),
    ]).toList();

    expect(events, [
      {'a': 1},
    ]);
  });

  test('emits each event exactly once regardless of chunk boundaries (#173)',
      () async {
    const payload = '{"choices":[{"delta":{"content":"hi"}}]}';
    final line = utf8.encode('data: $payload\n\n');
    final events = <Map<String, dynamic>>[];
    // Feed one byte at a time — worst-case fragmentation.
    await for (final e in openAIParseSseStream(
      Stream.fromIterable(line.map((b) => [b])),
    )) {
      events.add(e);
    }
    expect(events.length, 1);
    expect(events.single['choices'][0]['delta']['content'], 'hi');
  });
}
