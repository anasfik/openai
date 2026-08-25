# 8.0.0

## Web support (the headline)

- **The package now compiles and runs on Flutter Web.** Every unconditional
  `dart:io` import is gone from `lib/`; file uploads are handled through a
  platform-neutral `OpenAIFile(bytes:, fileName:)` type, and disk helpers are
  conditionally imported. A web compile smoke test runs in CI.

## Resilience

- **Automatic retries** (`OpenAIRetryPolicy`, on by default): GET/DELETE retry
  on transient failures (408/429/5xx, connection errors); POST retries only on
  429/5xx. Exponential backoff with jitter; server `Retry-After` wins.
  Disable with `maxRetries: 1`.
- **Stream idle watchdog**: a stalled SSE connection now fails with a typed
  `StreamTimedOutException` instead of hanging forever.
- **Rate-limit visibility**: `x-ratelimit-*` headers are parsed after every
  request into `OpenAIResponseMeta.lastRateLimit`.

## Robustness

- Malformed or drifted API payloads no longer crash parsing: all major models
  tolerate missing/null/wrong-typed fields (covered by a fuzz test suite).
- Unknown vector-store chunking strategies and eval data-source types fall
  back instead of throwing `UnimplementedError`.
- Tool-call arguments sent as JSON objects by compatible providers are
  normalized to strings (#217).
- Non-JSON error bodies on any verb surface as `RequestFailedException`.

## Azure OpenAI (#142)

```dart
final azure = OpenAIClient(
  apiKey: '<key>',
  azure: const OpenAIAzure(
    resource: 'my-resource',
    apiVersion: '2024-10-21',
    deployments: {'gpt-4o': 'gpt4o-prod'},
  ),
);
```

Requests are rewritten to `/openai/deployments/{deployment}/...?api-version=`
transparently.

## Breaking changes from 7.x

- File-taking methods now require `OpenAIFile` instead of `dart:io` `File`.
  Use `await loadOpenAIFile('path')` on native platforms or construct
  `OpenAIFile(bytes: ..., fileName: ...)` anywhere.
- `audio.createSpeech` returns `Uint8List` bytes (optionally writing to disk
  when `outputDirectory`/`outputFileName` are provided as strings).
- Interfaces synced with implementations; stale abstract members removed.

## Full changelog of 7.0.0 features below (unchanged)

# 7.0.0

## Breaking / architecture

- **Per-client instances**: `OpenAIClient(apiKey: ..., baseUrl: ..., organization: ...)` lets you talk to multiple accounts or OpenAI-compatible providers in one app (#183). The legacy global facade (`OpenAI.apiKey = ...`, `OpenAI.instance`) keeps working unchanged.
- **One shared SSE decoder** for every streaming endpoint.
- Injectable HTTP transport for tests (`OpenAINetworkingClient.clientFactory`); CI no longer injects live API keys into test files.

## Fixed

- Streaming no longer duplicates events (#173) and closes immediately on `[DONE]` instead of hanging ~15s (#206).
- UTF-8 multibyte characters split across network chunks decode correctly in streams.
- In-band `{"error": ...}` payloads and non-SSE error bodies (HTML/plain text) surface as `RequestFailedException` instead of being swallowed.
- Query-string builder no longer produces `%3Fkey` params.
- Image sizes: added gpt-image-1 sizes (`1536x1024`, `1024x1536`, `auto`) alongside DALL-E sizes (#222).
- Chat: added `reasoningEffort` parameter for reasoning models (#207); `maxTokens` already maps to `max_completion_tokens`.
- Removed an undocumented telemetry module that reported usage metadata externally.

## Added

- **Batch API**: create / get / getAll / cancel.
- **Uploads API**: create / addPart / complete / cancel.
- **Graders**: real implementations of `runGrader()` and `validateGrader()` plus `toMap()` serialization for all grader types.
- **Fine-tuning (new API)** `/fine_tuning/jobs`: create, list, retrieve, cancel, pause, resume, events, checkpoints. Legacy `/fine-tunes` still available via `fineTune`.
- **Responses**: `createStream()` server-sent events (#221), stored-completion retrieval, `compact()`.
- **Chat completions**: retrieve stored completions and list their messages.
- **Videos API**: create, list, retrieve, delete, remix, content download.
- **Realtime REST**: sessions, transcription sessions, client secrets.
- **Audio**: voice listing and voice consent management.
- **Skills API** and **content provenance checks**.
- **Administration**: projects, users, invites, audit logs, costs, rate limits, admin API keys.
- **Files**: `uploadBytes()` to upload from in-memory `Uint8List` with filename (#164); byte-based uploads supported at transport level for web-friendly flows.
