# Resolved Issues

## #223 - a bug when api service returns

Problem:
- The networking client assumed the `error` field in a failed response was always a `Map<String, dynamic>`.
- When an API-compatible backend returned a payload like `{ "error": "Not Found", ... }`, the SDK threw a Dart type error instead of a `RequestFailedException`.

Changes:
- Added `requestFailedExceptionFromMap(...)` in [lib/src/core/networking/client.dart](./lib/src/core/networking/client.dart) to normalize error payload parsing.
- Updated request error handling in `get`, `postAndGetResponse`, `post`, `imageEditForm`, `imageVariationForm`, `fileUpload`, and `delete` to use the shared helper instead of directly casting `error` to a map.
- Added a regression test covering string-based error payloads in [test/regressions_test.dart](./test/regressions_test.dart).

## #190 - why createStream silently ignored the potenital json decode error ?

Problem:
- The stream client swallowed JSON decode failures while accumulating response data.
- Non-JSON error bodies in streamed failures could be ignored instead of being surfaced as a proper exception.

Changes:
- Updated `postStream(...)` in [lib/src/core/networking/client.dart](./lib/src/core/networking/client.dart) to stop swallowing terminal error responses.
- Added `requestFailedExceptionFromRawBody(...)` to convert non-JSON raw response bodies into a `RequestFailedException`.
- Added logic to emit a stream error when the server returns an error status with a non-empty raw body and no valid stream events were emitted.
- Added regression tests for raw non-JSON stream failures in [test/regressions_test.dart](./test/regressions_test.dart).

## #172 - OpenAIChatCompletionChoiceMessageContentItemModel.imageUrl Not working properly

Problem:
- The chat content model stored `imageUrl` as a map, but `toMap()` wrapped it again.
- That produced a nested `image_url` payload shape that did not match the API contract.

Changes:
- Fixed `OpenAIChatCompletionChoiceMessageContentItemModel.toMap()` in [lib/src/core/models/chat/sub_models/choices/sub_models/sub_models/content.dart](./lib/src/core/models/chat/sub_models/choices/sub_models/sub_models/content.dart) so it writes the existing `imageUrl` object directly.
- Added a regression test verifying the correct serialized `image_url` shape in [test/regressions_test.dart](./test/regressions_test.dart).

## #185 - Audio | Create Speech | return file bytes (Uint8List) for work on web and improve speed

Problem:
- The issue requested a byte-returning API for speech generation instead of always writing a file.

Changes:
- Confirmed the SDK already exposes `createSpeechBytes(...)` in [lib/src/instance/audio/audio.dart](./lib/src/instance/audio/audio.dart).
- Documented `createSpeechBytes(...)` in [README.md](./README.md) so the in-memory byte API is visible in the public usage docs.
