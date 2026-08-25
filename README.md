# dart_openai

[![Pub Version](https://img.shields.io/pub/v/dart_openai)](https://pub.dev/packages/dart_openai)
[![Pub Likes](https://img.shields.io/pub/likes/dart_openai)](https://pub.dev/packages/dart_openai)
[![Pub Points](https://img.shields.io/pub/points/dart_openai)](https://pub.dev/packages/dart_openai)
[![Tests](https://img.shields.io/github/actions/workflow/status/anasfik/openai/dart.yml?label=tests)](https://github.com/anasfik/openai/actions)
[![License](https://img.shields.io/github/license/anasfik/openai)](./LICENSE)

Unofficial Dart/Flutter SDK for the OpenAI API. Typed clients for every major API surface: Responses, Chat Completions, Realtime, Videos, Batch, Fine-tuning, Vector Stores, Evals and more. Works on all platforms, including Flutter Web.

Maintained by [Anas Fikhi](https://gwhyyy.com) ([@anasfik](https://github.com/anasfik)).

## Installation

```yaml
dependencies:
  dart_openai: ^7.0.0
```

```bash
dart pub get
```

## Quickstart

```dart
import 'package:dart_openai/dart_openai.dart';

Future<void> main() async {
  final client = OpenAIClient(apiKey: Platform.environment['OPENAI_API_KEY']!);

  final completion = await client.chat.create(
    model: 'gpt-4o',
    messages: [
      const OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.user,
        content: 'Say hello in five words.',
      ),
    ],
  );

  print(completion.choices.first.message.content);
}
```

Prefer the global facade? It still works:

```dart
OpenAI.apiKey = 'sk-...';
await OpenAI.instance.chat.create(model: 'gpt-4o', messages: [...]);
```

## Multiple clients and compatible providers

Every `OpenAIClient` owns its configuration. Run several accounts, Azure resources, or OpenAI-compatible providers side by side without global state:

```dart
final production = OpenAIClient(apiKey: 'sk-prod');

final deepseek = OpenAIClient(
  apiKey: 'ds-...',
  baseUrl: 'https://api.deepseek.com',
);

final localLlama = OpenAIClient(
  apiKey: 'not-needed',
  baseUrl: 'http://localhost:1234/v1',
);
```

Works with any provider that implements the OpenAI wire format: DeepSeek, LM Studio, Ollama, Groq, Together, Azure OpenAI gateways, and others.

## Streaming

One SSE engine backs every streaming endpoint. It closes on `[DONE]`, never duplicates events, and surfaces errors as exceptions instead of swallowing them.

Responses API events:

```dart
final events = client.responses.createStream(
  model: 'gpt-4o',
  input: 'Write a haiku about databases.',
);

await for (final event in events) {
  if (event['type'] == 'response.output_text.delta') {
    stdout.write(event['delta']);
  }
}
```

Chat Completions deltas:

```dart
final chunks = client.chat.createStream(model: 'gpt-4o', messages: messages);

await for (final chunk in chunks) {
  stdout.write(chunk.choices.first.delta?.content);
}
```

Images emit partial results as they render (`createStream`), and stored completions support retrieval and listing.

## API coverage

| API | Accessor |
|---|---|
| Responses (incl. streaming, compact) | `client.responses` |
| Chat Completions (tools, vision, reasoning params, stored completions) | `client.chat` |
| Conversations | `client.conversations` |
| Audio (speech, transcription, translation, voices, consents) | `client.audio` |
| Images (generation, edit, variation, streaming partials) | `client.image` |
| Embeddings | `client.embedding` |
| Files (incl. byte uploads) | `client.file` |
| Uploads (multipart sessions) | `client.uploads` |
| Batch | `client.batch` |
| Vector Stores (+ files, + file batches) | `client.vectorStores` |
| Containers (+ files) | `client.container` |
| Models / Moderation | `client.model` / `client.moderation` |
| Evals | `client.evals` |
| Graders (incl. run and validate) | `client.graders` |
| Fine-tuning jobs (current API) | `client.fineTuning` |
| Videos (generate, remix, download) | `client.videos` |
| Realtime sessions and client secrets | `client.realtime` |
| Skills | `client.skills` |
| Content provenance checks | `client.provenance` |
| Administration (projects, users, invites, audit logs, costs, rate limits, API keys) | `client.organization` |
| Completions and Edits (legacy) | `client.completion` / `client.edit` |

Not planned: Assistants v1 and Threads (superseded by the Responses API), ChatKit.

## Error handling

All failures throw typed exceptions you can catch precisely:

```dart
try {
  await client.chat.create(model: 'gpt-4o', messages: messages);
} on RequestFailedException catch (e) {
  // Non-2xx from the API: e.message, e.statusCode
} on MissingApiKeyException catch (e) {
  // No key configured for this client
} on OpenAIUnexpectedException catch (e) {
  // Malformed response that is not an API error payload
}
```

Error payloads are normalized across providers. Whether a provider returns `{"error": {"message": ...}}`, a bare string error, or an HTML error page, you get a `RequestFailedException` with the body preserved.

## Configuration

Per-client options: `apiKey`, `organization`, `baseUrl`, `version`, `requestsTimeOut`, `extraHeaders`.

Global facade equivalents: `OpenAI.apiKey`, `OpenAI.organization`, `OpenAI.baseUrl`, `OpenAI.requestsTimeOut`, plus `OpenAI.showLogs` and `OpenAI.showResponsesLogs` for request debugging.

Reasoning models (o-series, GPT-5 family): pass `reasoningEffort: 'low'` and use `maxTokens`, which maps to `max_completion_tokens`. Incompatible sampling parameters are rejected by the API; use `extraParams` to pass anything not yet modeled.

## Migrating from 6.x

Nothing breaks if you used the global facade. To adopt per-client instances, replace global configuration with construction:

```dart
// Before (still supported)
OpenAI.apiKey = 'sk-...';
await OpenAI.instance.chat.create(...);

// After
final client = OpenAIClient(apiKey: 'sk-...');
await client.chat.create(...);
```

Full list of changes: [CHANGELOG.md](./CHANGELOG.md).

## Testing

The test suite runs entirely against mocked HTTP. No API keys required:

```bash
dart test
```

Live integration tests run only when `OPEN_AI_API_KEY` is present in the environment.

## Contributing

Bug reports and feature requests go through [GitHub Issues](https://github.com/anasfik/openai/issues). Pull requests welcome: keep diffs focused, add or update tests for changed behavior, and follow the existing module layout (`lib/src/instance/<module>/` with models under `lib/src/core/models/<module>/`). Commit messages use [Conventional Commits](https://www.conventionalcommits.org).

## License

MIT. See [LICENSE](./LICENSE).

## Support

- Documentation: [pub.dev/documentation/dart_openai](https://pub.dev/documentation/dart_openai/latest/)
- Issues: [github.com/anasfik/openai/issues](https://github.com/anasfik/openai/issues)
- Sponsor: [github.com/sponsors/anasfik](https://github.com/sponsors/anasfik)
