import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_openai/dart_openai.dart';
import 'package:dart_openai/src/core/builder/headers.dart';
import 'package:dart_openai/src/core/constants/config.dart';
import 'package:dart_openai/src/core/utils/extensions.dart';
import 'package:dart_openai/src/core/utils/logger.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:meta/meta.dart';

import '../constants/strings.dart';
import 'sse.dart';

/// Networking layer. Every request flows through here so headers, timeouts,
/// and error handling stay consistent.
///
/// All methods accept an optional [OpenAIClientConfig]; when omitted they fall
/// back to the global statics configured through the legacy [OpenAI] facade.
@protected
@immutable
abstract class OpenAINetworkingClient {
  /// Injectable transport factory. Tests plug a mock here; production code
  /// leaves it null and gets the platform default.
  static http.Client Function()? clientFactory;

  static http.Client _defaultClient() => clientFactory?.call() ?? http.Client();

  static Map<String, String> _headers(OpenAIClientConfig? config) =>
      config?.buildHeaders() ?? HeadersBuilder.build();

  static Duration _timeout(OpenAIClientConfig? config) =>
      config?.requestsTimeOut ?? OpenAIConfig.requestsTimeOut;

  static Future<T> get<T>({
    required String from,
    bool returnRawResponse = false,
    T Function(Map<String, dynamic>)? onSuccess,
    http.Client? client,
    OpenAIClientConfig? config,
  }) async {
    OpenAILogger.logStartRequest(from);

    final uri = Uri.parse(from);
    final headers = _headers(config);

    final response = await _send(
      () => (client ?? _defaultClient()).get(uri, headers: headers),
      timeout: _timeout(config),
      method: 'GET',
      config: config,
    );

    OpenAILogger.logResponseBody(response);

    if (returnRawResponse) {
      return response.body as T;
    }

    OpenAILogger.requestToWithStatusCode(from, response.statusCode);
    OpenAILogger.startingDecoding();

    const utf8decoder = Utf8Decoder();

    final convertedBody = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw requestFailedExceptionFromRawBody(
          convertedBody, response.statusCode);
    }
    final decodedBody = decodeToMap(convertedBody);

    OpenAILogger.decodedSuccessfully();

    return _handleJsonBody(decodedBody, response.statusCode, onSuccess!);
  }

  /// Shared SSE streaming pipeline for GET and POST streams.
  static Stream<T> _stream<T>({
    required http.BaseRequest Function(http.Client) requestFactory,
    required T Function(Map<String, dynamic>) onSuccess,
    http.Client? client,
    OpenAIClientConfig? config,
  }) async* {
    final clientForUse = client ?? _defaultClient();
    try {
      final respond = await clientForUse
          .send(requestFactory(clientForUse))
          .timeout(_timeout(config));

      OpenAILogger.startReadStreamResponse();

      yield* openAIParseSseStream(respond.stream,
              statusCode: respond.statusCode)
          .map(onSuccess);
    } catch (error, stackTrace) {
      yield* Stream<T>.error(error, stackTrace);
    } finally {
      clientForUse.close();
    }
  }

  static Stream<T> getStream<T>({
    required String from,
    required T Function(Map<String, dynamic>) onSuccess,
    http.Client? client,
    OpenAIClientConfig? config,
  }) {
    OpenAILogger.logStartRequest(from);
    return _stream(
      onSuccess: onSuccess,
      client: client,
      config: config,
      requestFactory: (_) =>
          http.Request(OpenAIStrings.getMethod, Uri.parse(from)),
    );
  }

  /// Posts a JSON body expecting binary content (audio, images).
  ///
  /// Returns the raw bytes. When [outputDirectory] and [outputFileName] are
  /// provided on a native platform, the bytes are also written to disk.
  static Future<Uint8List> postAndExpectBytes({
    required String to,
    Map<String, dynamic>? body,
    String? outputDirectory,
    String? outputFileName,
    String? outputFileExtension,
    http.Client? client,
    OpenAIClientConfig? config,
  }) async {
    final response = await postAndGetResponse(
        to: to, body: body, client: client, config: config);

    if (outputDirectory != null && outputFileName != null) {
      final extension = outputFileExtension ??
          response.headers['content-type']?.split('/').last ??
          'mp3';
      await saveOpenAIBytes(
        bytes: response.bodyBytes,
        outputDirectory: outputDirectory,
        outputFileName: '$outputFileName.$extension',
      );
    }

    return response.bodyBytes;
  }

  static Future<Uint8List> postAndGetBytes({
    required String to,
    Map<String, dynamic>? body,
    http.Client? client,
    OpenAIClientConfig? config,
  }) async {
    final response = await postAndGetResponse(
        to: to, body: body, client: client, config: config);

    return response.bodyBytes;
  }

  static Future<http.Response> postAndGetResponse({
    required String to,
    Map<String, dynamic>? body,
    http.Client? client,
    OpenAIClientConfig? config,
  }) async {
    OpenAILogger.logStartRequest(to);

    final uri = Uri.parse(to);

    final headers = _headers(config);

    final handledBody = body != null ? jsonEncode(body) : null;

    final response = await _send(
      () => (client ?? _defaultClient())
          .post(uri, headers: headers, body: handledBody),
      timeout: _timeout(config),
      method: 'POST',
      config: config,
    );

    OpenAILogger.requestToWithStatusCode(to, response.statusCode);

    OpenAILogger.startingTryCheckingForError();

    final isJsonDecodedMap = tryDecodedToMap(response.body);

    if (isJsonDecodedMap) {
      final decodedBody = decodeToMap(response.body);

      if (doesErrorExists(decodedBody)) {
        OpenAILogger.errorFoundInRequest();
        throw _exceptionFrom(decodedBody, response.statusCode);
      } else {
        OpenAILogger.unexpectedResponseGotten();

        throw OpenAIUnexpectedException(
          'Expected file response, but got non-error json response',
          response.body,
        );
      }
    } else {
      OpenAILogger.noErrorFound();

      OpenAILogger.requestFinishedSuccessfully();

      return response;
    }
  }

  static Future<T> post<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    Map<String, dynamic>? body,
    http.Client? client,
    OpenAIClientConfig? config,
  }) async {
    OpenAILogger.logStartRequest(to);

    var uri = Uri.parse(to);
    var effectiveBody = body;

    if (config?.azure != null && body != null) {
      final (rewrittenUri, rewrittenBody) =
          openAIAzureRewrite(uri: uri, body: body, config: config!);
      uri = rewrittenUri;
      effectiveBody = rewrittenBody;
    }

    final headers = _headers(config);

    final handledBody =
        effectiveBody != null ? jsonEncode(effectiveBody) : null;

    final response = await _send(
      () => (client ?? _defaultClient())
          .post(uri, headers: headers, body: handledBody),
      timeout: _timeout(config),
      method: 'POST',
      config: config,
    );

    OpenAILogger.logResponseBody(response);

    OpenAILogger.requestToWithStatusCode(to, response.statusCode);

    OpenAILogger.startingDecoding();

    const utf8decoder = Utf8Decoder();

    final convertedBody = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw requestFailedExceptionFromRawBody(
          convertedBody, response.statusCode);
    }
    final decodedBody = decodeToMap(convertedBody);

    OpenAILogger.decodedSuccessfully();

    return _handleJsonBody(decodedBody, response.statusCode, onSuccess);
  }

  static Stream<T> postStream<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    required Map<String, dynamic> body,
    http.Client? client,
    OpenAIClientConfig? config,
  }) {
    OpenAILogger.logStartRequest(to);
    return _stream(
      onSuccess: onSuccess,
      client: client,
      config: config,
      requestFactory: (_) {
        var streamUri = Uri.parse(to);
        var streamBody = body;
        if (config?.azure != null) {
          final (u, b) = openAIAzureRewrite(
              uri: streamUri, body: streamBody, config: config!);
          streamUri = u;
          streamBody = b;
        }
        final request = http.Request(OpenAIStrings.postMethod, streamUri);
        request.headers.addAll(_headers(config));
        request.body = jsonEncode(streamBody);
        return request;
      },
    );
  }

  static Future imageEditForm<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    required OpenAIFile image,
    OpenAIFile? mask,
    required Map<String, String> body,
    OpenAIClientConfig? config,
  }) async {
    final decodedBody = await _multipart(
      to: to,
      fields: body,
      files: [
        multipartFromOpenAIFile('image', image),
        if (mask != null) multipartFromOpenAIFile('mask', mask),
      ],
      config: config,
    );
    return onSuccess(decodedBody);
  }

  static Future<T> imageVariationForm<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    // ignore: avoid-unused-parameters
    required Map<String, String> body,
    required OpenAIFile image,
    OpenAIClientConfig? config,
  }) async {
    final decodedBody = await _multipart(
      to: to,
      fields: body,
      files: [multipartFromOpenAIFile('image', image)],
      config: config,
    );
    return onSuccess(decodedBody);
  }

  static Future<T> fileUpload<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    required Map<String, String> body,
    OpenAIFile? file,
    String fileField = 'file',
    Map<String, dynamic> Function(String rawResponse)? responseMapAdapter,
    List<http.MultipartFile> extraFiles = const [],
    OpenAIClientConfig? config,
  }) async {
    assert(file != null || extraFiles.isNotEmpty, 'Provide a file to upload.');
    final resultBody = await _multipartRaw(
      to: to,
      fields: body,
      files: [
        if (file != null) multipartFromOpenAIFile(fileField, file),
        ...extraFiles,
      ],
      config: config,
    );

    final adapted = switch ((resultBody is String, responseMapAdapter)) {
      (false, _) => resultBody,
      (_, null) => resultBody,
      (_, final func?) => func(resultBody as String),
    };

    if (adapted is Map<String, dynamic> && doesErrorExists(adapted)) {
      throw _exceptionFrom(adapted, 400);
    }

    return onSuccess(adapted);
  }

  static Future<T> delete<T>({
    required String from,
    required T Function(Map<String, dynamic> response) onSuccess,
    http.Client? client,
    OpenAIClientConfig? config,
  }) async {
    OpenAILogger.logStartRequest(from);

    final headers = _headers(config);
    final uri = Uri.parse(from);

    final response = await _send(
      () => (client ?? _defaultClient()).delete(uri, headers: headers),
      timeout: _timeout(config),
      method: 'DELETE',
      config: config,
    );

    OpenAILogger.logResponseBody(response);

    OpenAILogger.requestToWithStatusCode(from, response.statusCode);

    OpenAILogger.startingDecoding();

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw requestFailedExceptionFromRawBody(
          response.body, response.statusCode);
    }
    final decodedBody = decodeToMap(response.body);

    OpenAILogger.decodedSuccessfully();

    return _handleJsonBody(decodedBody, response.statusCode, onSuccess);
  }

  // ---- shared internals ----

  static Future<http.Response> _send(
    Future<http.Response> Function() send, {
    required Duration timeout,
    required String method,
    OpenAIClientConfig? config,
  }) async {
    final policy = config?.retryPolicy ?? const OpenAIRetryPolicy();
    var attempt = 0;
    while (true) {
      attempt += 1;
      int? statusCode;
      int? retryAfterSecs;
      try {
        final response = await send().timeout(timeout);
        statusCode = response.statusCode;
        OpenAIResponseMeta.record(response.headers);
        if (!policy.shouldRetry(
            method: method,
            statusCode: statusCode,
            responseReceived: true,
            attempt: attempt)) {
          return response;
        }
        retryAfterSecs = int.tryParse(response.headers['retry-after'] ?? '');
      } catch (error) {
        // Connection-level failure: nothing received, always retriable.
        if (!policy.shouldRetry(
            method: method, responseReceived: false, attempt: attempt)) {
          rethrow;
        }
      }
      await Future<void>.delayed(
          policy.delayFor(attempt, retryAfterSeconds: retryAfterSecs));
    }
  }

  static Future<http.StreamedResponse> _sendMultipart(
    http.BaseRequest Function() requestFactory, {
    required Duration timeout,
    OpenAIClientConfig? config,
  }) async {
    final policy = config?.retryPolicy ?? const OpenAIRetryPolicy();
    var attempt = 0;
    while (true) {
      attempt += 1;
      int? statusCode;
      int? retryAfterSecs;
      try {
        final response =
            await _defaultClient().send(requestFactory()).timeout(timeout);
        statusCode = response.statusCode;
        OpenAIResponseMeta.record(response.headers);
        if (!policy.shouldRetry(
            method: 'POST',
            statusCode: statusCode,
            responseReceived: true,
            attempt: attempt)) {
          return response;
        }
        retryAfterSecs = int.tryParse(response.headers['retry-after'] ?? '');
      } catch (_) {
        if (!policy.shouldRetry(
            method: 'POST', responseReceived: false, attempt: attempt)) {
          rethrow;
        }
      }
      await Future<void>.delayed(
          policy.delayFor(attempt, retryAfterSeconds: retryAfterSecs));
    }
  }

  static Future<dynamic> _multipart({
    required String to,
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
    OpenAIClientConfig? config,
  }) async {
    return _multipartRaw(to: to, fields: fields, files: files, config: config);
  }

  static Future<dynamic> _multipartRaw({
    required String to,
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
    OpenAIClientConfig? config,
  }) async {
    OpenAILogger.logStartRequest(to);

    final request =
        http.MultipartRequest(OpenAIStrings.postMethod, Uri.parse(to));

    request.headers.addAll(_headers(config));
    request.fields.addAll(fields);
    request.files.addAll(files);

    final response = await _sendMultipart(
      () {
        final retryRequest =
            http.MultipartRequest(OpenAIStrings.postMethod, Uri.parse(to));
        retryRequest.headers.addAll(_headers(config));
        retryRequest.fields.addAll(fields);
        retryRequest.files.addAll(files);
        return retryRequest;
      },
      timeout: _timeout(config),
      config: config,
    );

    OpenAILogger.requestToWithStatusCode(to, response.statusCode);

    OpenAILogger.startingDecoding();

    final responseBody = await response.stream.bytesToString();

    OpenAILogger.logResponseBody(responseBody);

    if (doesErrorExistsOrIsErrorStatus(responseBody, response.statusCode)) {
      throw _exceptionFromOrRaw(responseBody, response.statusCode);
    }

    OpenAILogger.decodedSuccessfully();
    OpenAILogger.requestFinishedSuccessfully();

    return responseBody.canBeParsedToJson
        ? decodeToMap(responseBody)
        : responseBody;
  }

  static T _handleJsonBody<T>(
    Map<String, dynamic> decodedBody,
    int statusCode,
    T Function(Map<String, dynamic>) onSuccess,
  ) {
    if (doesErrorExists(decodedBody)) {
      throw _exceptionFrom(decodedBody, statusCode);
    }
    OpenAILogger.requestFinishedSuccessfully();
    return onSuccess(decodedBody);
  }

  static RequestFailedException _exceptionFrom(
    Map<String, dynamic> decodedBody,
    int statusCode,
  ) {
    return requestFailedExceptionFromMap(decodedBody, statusCode);
  }

  static RequestFailedException _exceptionFromOrRaw(
    String responseBody,
    int statusCode,
  ) {
    return requestFailedExceptionFromRawBody(responseBody, statusCode);
  }

  static Map<String, dynamic> decodeToMap(String responseBody) {
    try {
      return jsonDecode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      throw FormatException('Failed to decode JSON: $e');
    }
  }

  static bool tryDecodedToMap(String responseBody) {
    try {
      jsonDecode(responseBody) as Map<String, dynamic>;

      return true;
    } catch (e) {
      return false;
    }
  }

  static bool doesErrorExists(Map<String, dynamic> decodedResponseBody) {
    return decodedResponseBody[OpenAIStrings.errorFieldKey] != null;
  }

  /// True when the body contains an error field or the status code signals
  /// failure even without an error payload (some providers do this).
  static bool doesErrorExistsOrIsErrorStatus(String body, int statusCode) {
    if (statusCode < 200 || statusCode >= 300) {
      return true;
    }
    if (!body.canBeParsedToJson) {
      return false;
    }
    final decoded = tryDecodeOrNull(body);
    return decoded != null && doesErrorExists(decoded);
  }

  static Map<String, dynamic>? tryDecodeOrNull(String body) {
    try {
      return jsonDecode(body) as Map<String, dynamic>;
    } on FormatException {
      return null;
    }
  }

  static RequestFailedException requestFailedExceptionFromMap(
    Map<String, dynamic> decodedBody,
    int statusCode,
  ) {
    final error = decodedBody[OpenAIStrings.errorFieldKey];
    final fallbackMessage = jsonEncode(decodedBody);

    if (error is Map<String, dynamic>) {
      final message = error[OpenAIStrings.messageFieldKey]?.toString();

      return RequestFailedException(
        message == null || message.isEmpty ? jsonEncode(error) : message,
        statusCode,
      );
    }

    if (error is String && error.isNotEmpty) {
      final path = decodedBody['path']?.toString();
      final responseStatus = decodedBody['status'] ?? statusCode;

      return RequestFailedException(
        path == null ? error : '$error ($responseStatus @ $path)',
        statusCode,
      );
    }

    return RequestFailedException(fallbackMessage, statusCode);
  }

  static RequestFailedException requestFailedExceptionFromRawBody(
    String responseBody,
    int statusCode,
  ) {
    final trimmedBody = responseBody.trim();

    if (trimmedBody.isEmpty) {
      return RequestFailedException(
        'Request failed with status code $statusCode',
        statusCode,
      );
    }

    try {
      final decodedBody = decodeToMap(trimmedBody);
      return doesErrorExists(decodedBody)
          ? requestFailedExceptionFromMap(decodedBody, statusCode)
          : RequestFailedException(jsonEncode(decodedBody), statusCode);
    } on FormatException {
      return RequestFailedException(trimmedBody, statusCode);
    }
  }
}

/// Builds a multipart part from an [OpenAIFile] using platform-neutral bytes.
http.MultipartFile multipartFromOpenAIFile(String field, OpenAIFile file) {
  return http.MultipartFile.fromBytes(
    field,
    file.bytes,
    filename: file.fileName,
    contentType: file.contentType != null
        ? MediaType.parse(file.contentType!)
        : mediaTypeFromFileName(file.fileName),
  );
}

/// Infers a MIME type from a file extension. Pure string logic, web-safe.
MediaType? mediaTypeFromFileName(String fileName) {
  final extension = fileName.split('.').last.toLowerCase();
  switch (extension) {
    case 'png':
      return MediaType('image', 'png');
    case 'jpg':
    case 'jpeg':
      return MediaType('image', 'jpeg');
    case 'gif':
      return MediaType('image', 'gif');
    case 'bmp':
      return MediaType('image', 'bmp');
    case 'webp':
      return MediaType('image', 'webp');
    default:
      return null;
  }
}
