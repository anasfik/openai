import 'dart:async';
import 'dart:convert';

import '../constants/strings.dart';
import '../exceptions/request_failure.dart';
import '../utils/logger.dart';
import '../utils/extensions.dart';

/// Single SSE decoder used by every streaming endpoint.
///
/// Contract:
/// - Decodes UTF-8 across chunk boundaries.
/// - Emits every `data: {json}` event exactly once.
/// - Closes immediately after the `data: [DONE]` sentinel (no hang).
/// - Surfaces in-band `{"error": ...}` payloads as [RequestFailedException].
/// - If the response was a non-SSE error body, emits it as an error instead of
///   silently completing.
Stream<Map<String, dynamic>> openAIParseSseStream(
  Stream<List<int>> byteStream, {
  int? statusCode,
}) async* {
  final buffer = StringBuffer();
  var emittedAny = false;
  Map<String, dynamic>? firstErrorPayload;

  final lines = byteStream.transform(const Utf8Decoder()).transform(const LineSplitter());

  await for (final line in lines) {
    if (line.isEmpty || line.startsWith(':')) continue;

    if (!line.startsWith(OpenAIStrings.streamResponseStart)) {
      buffer.write(line);
      continue;
    }

    final data = line.substring(OpenAIStrings.streamResponseStart.length);

    if (data.startsWith(OpenAIStrings.streamResponseEnd)) {
      OpenAILogger.streamResponseDone();
      return;
    }

    final Map<String, dynamic> decoded;
    try {
      decoded = jsonDecode(data) as Map<String, dynamic>;
    } on FormatException {
      // Partial/garbled line — keep going, next boundary event will flush.
      continue;
    }

    if (decoded[OpenAIStrings.errorFieldKey] != null) {
      firstErrorPayload ??= decoded;
      continue;
    }

    emittedAny = true;
    yield decoded;
  }

  final trailing = buffer.toString().trim();
  if (!emittedAny && firstErrorPayload == null && trailing.isNotEmpty) {
    throw RequestFailedException(trailing.canBeParsedToJson
        ? jsonEncode(_decodeOrNull(trailing) ?? trailing)
        : trailing, statusCode ?? 0);
  }

  if (firstErrorPayload != null) {
    throw _exceptionFromErrorPayload(firstErrorPayload, statusCode);
  }
}

RequestFailedException _exceptionFromErrorPayload(
  Map<String, dynamic> payload,
  int? statusCode,
) {
  final error = payload[OpenAIStrings.errorFieldKey];
  if (error is Map<String, dynamic>) {
    final message = error[OpenAIStrings.messageFieldKey]?.toString();
    return RequestFailedException(
      message == null || message.isEmpty ? jsonEncode(error) : message,
      statusCode ?? 0,
    );
  }
  return RequestFailedException(jsonEncode(payload), statusCode ?? 0);
}

Map<String, dynamic>? _decodeOrNull(String source) {
  try {
    return jsonDecode(source) as Map<String, dynamic>;
  } on FormatException {
    return null;
  }
}
