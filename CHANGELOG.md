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
