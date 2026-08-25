import 'package:dart_openai/dart_openai.dart';

/// Realtime REST — mint ephemeral client secrets for browser/mobile WS use.
Future<void> main() async {
  final client = OpenAIClient(apiKey: const String.fromEnvironment('KEY'));

  final session = await client.realtime.createSession(
    model: 'gpt-realtime',
    voice: 'alloy',
    modalities: ['text', 'audio'],
  );

  print('session id: ${session.id}');
  print('client secret: ${session.clientSecret?.value}');
}
