import 'dart:convert';
import 'package:dart_openai/dart_openai.dart';

/// Batch API — submit a JSONL file for async processing.
Future<void> main() async {
  final client = OpenAIClient(apiKey: const String.fromEnvironment('KEY'));

  // 1. Upload the batch input file (bytes work on every platform).
  final inputFile = await client.file.uploadBytes(
    bytes: [
      ...utf8JsonLine({
        'custom_id': 'request-1',
        'method': 'POST',
        'url': '/v1/chat/completions',
        'body': {
          'model': 'gpt-4o-mini',
          'messages': [
            {'role': 'user', 'content': 'Summarize the dart_openai SDK'}
          ],
        },
      }),
    ],
    fileName: 'batch-input.jsonl',
    purpose: 'batch',
  );

  // 2. Create the batch.
  final batch = await client.batch.create(
    completionWindow: '24h',
    endpoint: '/v1/chat/completions',
    inputFileId: inputFile.id,
  );

  print('batch ${batch.id} status: ${batch.status}');

  // 3. Poll until done.
  final done = await client.batch.get(batchId: batch.id);
  print('status now: ${done.status}');
}

List<int> utf8JsonLine(Map<String, dynamic> json) => jsonEncode(json).codeUnits;
