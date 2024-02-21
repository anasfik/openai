import "dart:async";
import "dart:convert";
import "dart:io";
import "package:dart_openai/src/core/constants/config.dart";
import "package:dart_openai/src/core/utils/extensions.dart";

import 'package:dart_openai/dart_openai.dart';
import "package:dart_openai/src/core/builder/headers.dart";
import "package:dart_openai/src/core/utils/logger.dart";
import "package:http/http.dart" as http;
import "package:meta/meta.dart";

import '../constants/strings.dart';

import "../utils/streaming_http_client_default.dart"
    if (dart.library.js) 'package:dart_openai/src/core/utils/streaming_http_client_web.dart'
    if (dart.library.io) 'package:dart_openai/src/core/utils/streaming_http_client_io.dart';

/// Handling exceptions returned by OpenAI Stream API.
final class _OpenAIChatStreamSink implements EventSink<String> {
  final EventSink<String> _sink;

  final List<String> _carries = [];

  _OpenAIChatStreamSink(this._sink);

  void add(String str) {
    final isStartOfResponse = str.startsWith(OpenAIStrings.streamResponseStart);
    final isEndOfResponse = str.contains(OpenAIStrings.streamResponseEnd);
    final isDataResponseBoundaries = isStartOfResponse || isEndOfResponse;

    if (isDataResponseBoundaries) {
      addCarryIfNeeded();

      _sink.add(str);
    } else {
      _carries.add(str);
    }
  }

  void addError(Object error, [StackTrace? stackTrace]) {
    _sink.addError(error, stackTrace);
  }

  void addSlice(String str, int start, int end, bool isLast) {
    if (start == 0 && end == str.length) {
      add(str);
    } else {
      add(str.substring(start, end));
    }

    if (isLast) close();
  }

  void addCarryIfNeeded() {
    if (_carries.isNotEmpty) {
      _sink.add(_carries.join());

      _carries.clear();
    }
  }

  void close() {
    addCarryIfNeeded();
    _sink.close();
  }
}

class OpenAIChatStreamLineSplitter
    extends StreamTransformerBase<String, String> {
  const OpenAIChatStreamLineSplitter();

  Stream<String> bind(Stream<String> stream) {
    Stream<String> lineStream = LineSplitter().bind(stream);

    return Stream<String>.eventTransformed(
      lineStream,
      (sink) => _OpenAIChatStreamSink(sink),
    );
  }
}

const openAIChatStreamLineSplitter = const LineSplitter();

@protected
@immutable
abstract class OpenAINetworkingClient {
  static Future<T> get<T>({
    required String from,
    bool returnRawResponse = false,
    T Function(Map<String, dynamic>)? onSuccess,
    http.Client? client,
  }) async {
    OpenAILogger.logStartRequest(from);

    final uri = Uri.parse(from);
    final headers = HeadersBuilder.build();

    final response = client == null
        ? await http
            .get(uri, headers: headers)
            .timeout(OpenAIConfig.requestsTimeOut)
        : await client.get(uri, headers: headers);

    OpenAILogger.logResponseBody(response);

    if (returnRawResponse) {
      return response.body as T;
    }

    OpenAILogger.requestToWithStatusCode(from, response.statusCode);
    OpenAILogger.startingDecoding();

    final utf8decoder = Utf8Decoder();

    final convertedBody = utf8decoder.convert(response.bodyBytes);
    final Map<String, dynamic> decodedBody = decodeToMap(convertedBody);

    OpenAILogger.decodedSuccessfully();

    if (doesErrorExists(decodedBody)) {
      final Map<String, dynamic> error =
          decodedBody[OpenAIStrings.errorFieldKey];
      final message = error[OpenAIStrings.messageFieldKey];
      final statusCode = response.statusCode;

      final exception = RequestFailedException(message, statusCode);
      OpenAILogger.errorOcurred(exception);

      throw exception;
    } else {
      OpenAILogger.requestFinishedSuccessfully();

      return onSuccess!(decodedBody);
    }
  }

  static Stream<T> getStream<T>({
    required String from,
    required T Function(Map<String, dynamic>) onSuccess,
    http.Client? client,
  }) {
    final controller = StreamController<T>();

    final clientForUse = client ?? _streamingHttpClient();

    final uri = Uri.parse(from);

    final httpMethod = OpenAIStrings.getMethod;

    final request = http.Request(httpMethod, uri);

    request.headers.addAll(HeadersBuilder.build());

    Future<void> close() {
      return Future.wait([
        Future.delayed(Duration.zero, clientForUse.close),
        controller.close(),
      ]);
    }

    clientForUse
        .send(request)
        // .timeout(OpenAIConfig.requestsTimeOut)
        .then((streamedResponse) {
      streamedResponse.stream.listen(
        (value) {
          final data = utf8.decode(value);

          final dataLines = openAIChatStreamLineSplitter
              .convert(data)
              .where((element) => element.isNotEmpty)
              .toList();

          for (String line in dataLines) {
            if (line.startsWith(OpenAIStrings.streamResponseStart)) {
              final String data = line.substring(6);
              if (data.startsWith(OpenAIStrings.streamResponseEnd)) {
                OpenAILogger.streamResponseDone();

                return;
              }

              final decoded = decodeToMap(data);
              controller.add(onSuccess(decoded));
            }
          }
        },
        onDone: () {
          close();
        },
        onError: (err) {
          controller.addError(err);
        },
      );
    });

    return controller.stream;
  }

  static Future<File> postAndExpectFileResponse({
    required String to,
    required File Function(File fileRes) onFileResponse,
    required String outputFileName,
    required Directory? outputDirectory,
    Map<String, dynamic>? body,
    http.Client? client,
  }) async {
    OpenAILogger.logStartRequest(to);

    final uri = Uri.parse(to);

    final headers = HeadersBuilder.build();

    final handledBody = body != null ? jsonEncode(body) : null;

    final response = client == null
        ? await http
            .post(uri, headers: headers, body: handledBody)
            .timeout(OpenAIConfig.requestsTimeOut)
        : await client.post(uri, headers: headers, body: handledBody);

    OpenAILogger.requestToWithStatusCode(to, response.statusCode);

    OpenAILogger.startingTryCheckingForError();

    final isJsonDecodedMap = tryDecodedToMap(response.body);

    if (isJsonDecodedMap) {
      final decodedBody = decodeToMap(response.body);

      if (doesErrorExists(decodedBody)) {
        OpenAILogger.errorFoundInRequest();

        final error = decodedBody[OpenAIStrings.errorFieldKey];

        final message = error[OpenAIStrings.messageFieldKey];

        final statusCode = response.statusCode;

        final exception = RequestFailedException(message, statusCode);
        OpenAILogger.errorOcurred(exception);

        throw exception;
      } else {
        OpenAILogger.unexpectedResponseGotten();

        throw OpenAIUnexpectedException(
          "Expected file response, but got non-error json response",
          response.body,
        );
      }
    } else {
      OpenAILogger.noErrorFound();

      OpenAILogger.requestFinishedSuccessfully();

      final fileTypeHeader = "content-type";

      final fileExtensionFromBodyResponseFormat =
          response.headers[fileTypeHeader]?.split("/").last ?? "mp3";

      final fileName =
          outputFileName + "." + fileExtensionFromBodyResponseFormat;

      File file = File(
        "${outputDirectory != null ? outputDirectory.path : ''}" +
            "/" +
            fileName,
      );

      OpenAILogger.creatingFile(fileName);

      await file.create();
      OpenAILogger.fileCreatedSuccessfully(fileName);
      OpenAILogger.writingFileContent(fileName);

      file = await file.writeAsBytes(
        response.bodyBytes,
        mode: FileMode.write,
      );

      OpenAILogger.fileContentWrittenSuccessfully(fileName);

      return onFileResponse(file);
    }
  }

  static Future<T> post<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    Map<String, dynamic>? body,
    http.Client? client,
  }) async {
    OpenAILogger.logStartRequest(to);

    final uri = Uri.parse(to);

    final headers = HeadersBuilder.build();

    final handledBody = body != null ? jsonEncode(body) : null;

    final response = client == null
        ? await http
            .post(uri, headers: headers, body: handledBody)
            .timeout(OpenAIConfig.requestsTimeOut)
        : await client.post(uri, headers: headers, body: handledBody);

    OpenAILogger.logResponseBody(response);

    OpenAILogger.requestToWithStatusCode(to, response.statusCode);

    OpenAILogger.startingDecoding();

    Utf8Decoder utf8decoder = Utf8Decoder();

    final convertedBody = utf8decoder.convert(response.bodyBytes);

    final Map<String, dynamic> decodedBody = decodeToMap(convertedBody);

    OpenAILogger.decodedSuccessfully();

    if (doesErrorExists(decodedBody)) {
      final Map<String, dynamic> error =
          decodedBody[OpenAIStrings.errorFieldKey];
      final message = error[OpenAIStrings.messageFieldKey];
      final statusCode = response.statusCode;

      final exception = RequestFailedException(message, statusCode);
      OpenAILogger.errorOcurred(exception);

      throw exception;
    } else {
      OpenAILogger.requestFinishedSuccessfully();

      return onSuccess(decodedBody);
    }
  }

  static Stream<T> postStream<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    required Map<String, dynamic> body,
    http.Client? client,
  }) async* {
    try {
      final clientForUse = client ?? _streamingHttpClient();
      final uri = Uri.parse(to);
      final headers = HeadersBuilder.build();
      final httpMethod = OpenAIStrings.postMethod;
      final request = http.Request(httpMethod, uri);
      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      OpenAILogger.logStartRequest(to);
      try {
        final respond = await clientForUse.send(request);

        try {
          OpenAILogger.startReadStreamResponse();
          final stream = respond.stream
              .transform(utf8.decoder)
              .transform(openAIChatStreamLineSplitter);

          try {
            String respondData = "";
            await for (final value
                in stream.where((event) => event.isNotEmpty)) {
              final data = value;
              respondData += data;

              final dataLines = data
                  .split("\n")
                  .where((element) => element.isNotEmpty)
                  .toList();

              for (String line in dataLines) {
                if (line.startsWith(OpenAIStrings.streamResponseStart)) {
                  final String data = line.substring(6);
                  if (data.contains(OpenAIStrings.streamResponseEnd)) {
                    OpenAILogger.streamResponseDone();
                    break;
                  }
                  final decoded = jsonDecode(data) as Map<String, dynamic>;
                  yield onSuccess(decoded);
                  continue;
                }

                Map<String, dynamic> decodedData = {};
                try {
                  decodedData = decodeToMap(respondData);
                } catch (error) {/** ignore, data has not been received */}

                if (doesErrorExists(decodedData)) {
                  final error = decodedData[OpenAIStrings.errorFieldKey]
                      as Map<String, dynamic>;
                  var message = error[OpenAIStrings.messageFieldKey] as String;
                  message = message.isEmpty ? jsonEncode(error) : message;
                  final statusCode = respond.statusCode;
                  final exception = RequestFailedException(message, statusCode);

                  yield* Stream<T>.error(
                    exception,
                  ); // Error cases sent from openai
                }
              }
            } // end of await for
          } catch (error, stackTrace) {
            yield* Stream<T>.error(
              error,
              stackTrace,
            ); // Error cases in handling stream
          }
        } catch (error, stackTrace) {
          yield* Stream<T>.error(
            error,
            stackTrace,
          ); // Error cases in decoding stream from response
        }
      } catch (e) {
        yield* Stream<T>.error(e); // Error cases in getting response
      }
    } catch (e) {
      yield* Stream<T>.error(e); //Error cases in making request
    }
  }

  static Future imageEditForm<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    required File image,
    required File? mask,
    required Map<String, String> body,
  }) async {
    OpenAILogger.logStartRequest(to);

    final uri = Uri.parse(to);

    final headers = HeadersBuilder.build();

    final httpMethod = OpenAIStrings.postMethod;

    final request = http.MultipartRequest(httpMethod, uri);

    request.headers.addAll(headers);

    final file = await http.MultipartFile.fromPath("image", image.path);

    final maskFile = mask != null
        ? await http.MultipartFile.fromPath("mask", mask.path)
        : null;

    request.files.add(file);

    if (maskFile != null) request.files.add(maskFile);

    request.fields.addAll(body);

    final response = await request.send().timeout(OpenAIConfig.requestsTimeOut);

    OpenAILogger.requestToWithStatusCode(to, response.statusCode);

    OpenAILogger.startingDecoding();

    final String encodedBody = await response.stream.bytesToString();

    OpenAILogger.logResponseBody(encodedBody);

    final Map<String, dynamic> decodedBody = decodeToMap(encodedBody);

    OpenAILogger.decodedSuccessfully();

    if (doesErrorExists(decodedBody)) {
      final Map<String, dynamic> error =
          decodedBody[OpenAIStrings.errorFieldKey];

      final message = error[OpenAIStrings.messageFieldKey];
      final statusCode = response.statusCode;

      final exception = RequestFailedException(message, statusCode);
      OpenAILogger.errorOcurred(exception);

      throw exception;
    } else {
      OpenAILogger.requestFinishedSuccessfully();

      return onSuccess(decodedBody);
    }
  }

  static Future<T> imageVariationForm<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    // ignore: avoid-unused-parameters
    required Map<String, String> body,
    required File image,
  }) async {
    OpenAILogger.logStartRequest(to);

    final httpMethod = OpenAIStrings.postMethod;

    final request = http.MultipartRequest(httpMethod, Uri.parse(to));

    request.headers.addAll(HeadersBuilder.build());

    final imageFile = await http.MultipartFile.fromPath("image", image.path);

    request.fields.addAll(body);
    request.files.add(imageFile);

    final http.StreamedResponse response =
        await request.send().timeout(OpenAIConfig.requestsTimeOut);

    OpenAILogger.requestToWithStatusCode(to, response.statusCode);

    OpenAILogger.startingDecoding();

    final String encodedBody = await response.stream.bytesToString();

    OpenAILogger.logResponseBody(encodedBody);

    final Map<String, dynamic> decodedBody = decodeToMap(encodedBody);

    OpenAILogger.decodedSuccessfully();

    if (doesErrorExists(decodedBody)) {
      final Map<String, dynamic> error =
          decodedBody[OpenAIStrings.errorFieldKey];
      final message = error[OpenAIStrings.messageFieldKey];
      final statusCode = response.statusCode;

      final exception = RequestFailedException(message, statusCode);
      OpenAILogger.errorOcurred(exception);

      throw exception;
    } else {
      OpenAILogger.requestFinishedSuccessfully();

      return onSuccess(decodedBody);
    }
  }

  static Future<T> fileUpload<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    required Map<String, String> body,
    required File file,
    Map<String, dynamic> Function(String rawResponse)? responseMapAdapter,
  }) async {
    OpenAILogger.logStartRequest(to);

    final uri = Uri.parse(to);
    final headers = HeadersBuilder.build();

    final httpMethod = OpenAIStrings.postMethod;
    final request = http.MultipartRequest(httpMethod, uri);

    request.headers.addAll(headers);

    final multiPartFile = await http.MultipartFile.fromPath("file", file.path);

    request.files.add(multiPartFile);
    request.fields.addAll(body);

    final http.StreamedResponse response =
        await request.send().timeout(OpenAIConfig.requestsTimeOut);

    final String responseBody = await response.stream.bytesToString();

    OpenAILogger.logResponseBody(responseBody);

    OpenAILogger.requestToWithStatusCode(to, response.statusCode);

    OpenAILogger.startingDecoding();

    var resultBody;

    resultBody = switch ((responseBody.canBeParsedToJson, responseMapAdapter)) {
      (true, _) => decodeToMap(responseBody),
      (_, null) => responseBody,
      (_, final func) => func!(responseBody),
    };

    OpenAILogger.decodedSuccessfully();
    if (doesErrorExists(resultBody)) {
      final Map<String, dynamic> error =
          resultBody[OpenAIStrings.errorFieldKey];
      final message = error[OpenAIStrings.messageFieldKey];
      final statusCode = response.statusCode;

      final exception = RequestFailedException(message, statusCode);
      OpenAILogger.errorOcurred(exception);

      throw exception;
    } else {
      OpenAILogger.requestFinishedSuccessfully();

      return onSuccess(resultBody);
    }
  }

  static Future<T> delete<T>({
    required String from,
    required T Function(Map<String, dynamic> response) onSuccess,
    http.Client? client,
  }) async {
    OpenAILogger.logStartRequest(from);

    final headers = HeadersBuilder.build();
    final uri = Uri.parse(from);

    final response = client == null
        ? await http
            .delete(uri, headers: headers)
            .timeout(OpenAIConfig.requestsTimeOut)
        : await client.delete(uri, headers: headers);

    OpenAILogger.logResponseBody(response);

    OpenAILogger.requestToWithStatusCode(from, response.statusCode);

    OpenAILogger.startingDecoding();

    final Map<String, dynamic> decodedBody = decodeToMap(response.body);

    OpenAILogger.decodedSuccessfully();

    if (doesErrorExists(decodedBody)) {
      final Map<String, dynamic> error =
          decodedBody[OpenAIStrings.errorFieldKey];
      final String message = error[OpenAIStrings.messageFieldKey];
      final statusCode = response.statusCode;

      final exception = RequestFailedException(message, statusCode);
      OpenAILogger.errorOcurred(exception);

      throw exception;
    } else {
      OpenAILogger.requestFinishedSuccessfully();

      return onSuccess(decodedBody);
    }
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

  static http.Client _streamingHttpClient() {
    return createClient();
  }
}
