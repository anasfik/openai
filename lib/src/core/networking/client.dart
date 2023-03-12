import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dart_openai/openai.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:dart_openai/src/core/builder/headers.dart';
import 'package:dart_openai/src/core/utils/logger.dart';

import '../exceptions/request_failure.dart';

class OpenAINetworkingClient {
  static Future<T> get<T>({
    required String from,
    bool returnRawResponse = false,
    T Function(Map<String, dynamic>)? onSuccess,
  }) async {
    if (isOpenAIDioRegistered())
      return await _get<T>(
        from: from,
        returnRawResponse: returnRawResponse,
        onSuccess: onSuccess,
      );

    OpenAILogger.log("starting request to $from");

    final http.Response response = await http.get(
      Uri.parse(from),
      headers: HeadersBuilder.build(),
    );

    if (returnRawResponse) {
      return response.body as T;
    }
    OpenAILogger.log(
        "request to $from finished with status code ${response.statusCode}");

    OpenAILogger.log("starting decoding response body");
    Utf8Decoder utf8decoder = Utf8Decoder();
    final Map<String, dynamic> decodedBody =
        jsonDecode(utf8decoder.convert(response.bodyBytes))
            as Map<String, dynamic>;

    OpenAILogger.log("response body decoded successfully");

    if (decodedBody['error'] != null) {
      OpenAILogger.log("an error occurred, throwing exception");
      final Map<String, dynamic> error = decodedBody['error'];
      throw RequestFailedException(
        error["message"],
        response.statusCode,
      );
    } else {
      OpenAILogger.log("request finished successfully");
      return onSuccess!(decodedBody);
    }
  }

  static Stream<T> getStream<T>({
    required String from,
    required T Function(Map<String, dynamic>) onSuccess,
  }) {
    if (isOpenAIDioRegistered())
      return _getStream<T>(
        from: from,
        onSuccess: onSuccess,
      );
    final controller = StreamController<T>();
    final http.Client client = http.Client();

    final request = http.Request("GET", Uri.parse(from));
    request.headers.addAll(HeadersBuilder.build());

    void close() {
      client.close();
      controller.close();
    }

    client.send(request).then((streamedResponse) {
      streamedResponse.stream.listen((value) {
        final String data = utf8.decode(value);

        final List<String> dataLines =
            data.split("\n").where((element) => element.isNotEmpty).toList();

        for (String line in dataLines) {
          if (line.startsWith("data: ")) {
            final String data = line.substring(6);
            if (data.startsWith("[DONE]")) {
              OpenAILogger.log("stream response is done");

              return;
            }

            final decoded = jsonDecode(data) as Map<String, dynamic>;
            controller.add(onSuccess(decoded));
          }
        }
      }, onDone: () {
        close();
      }, onError: (err) {
        controller.addError(err);
      });
    });

    return controller.stream;
  }

  static Future<T> post<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    Map<String, dynamic>? body,
  }) async {
    if (isOpenAIDioRegistered())
      return await _post<T>(
        to: to,
        onSuccess: onSuccess,
        body: body,
      );
    OpenAILogger.log("starting request to $to");

    final http.Response response = await http.post(
      Uri.parse(to),
      headers: HeadersBuilder.build(),
      body: body != null ? jsonEncode(body) : null,
    );

    OpenAILogger.log(
        "request to $to finished with status code ${response.statusCode}");

    OpenAILogger.log("starting decoding response body");
    Utf8Decoder utf8decoder = Utf8Decoder();
    final Map<String, dynamic> decodedBody =
        jsonDecode(utf8decoder.convert(response.bodyBytes))
            as Map<String, dynamic>;
    OpenAILogger.log("response body decoded successfully");

    if (decodedBody['error'] != null) {
      OpenAILogger.log("an error occurred, throwing exception");
      final Map<String, dynamic> error = decodedBody['error'];
      throw RequestFailedException(
        error["message"],
        response.statusCode,
      );
    } else {
      OpenAILogger.log("request finished successfully");
      return onSuccess(decodedBody);
    }
  }

  // static Stream<T> postStream<T>({
  //   required String to,
  //   required T Function(Map<String, dynamic>) onSuccess,
  //   required Map<String, dynamic> body,
  // }) async* {
  //   OpenAILogger.log("starting request to $to");

  //   final http.Client client = http.Client();
  //   final clientRequest = client.post(
  //     Uri.parse(to),
  //     headers: HeadersBuilder.build(),
  //     body: jsonEncode(body),
  //   );

  //   final response = clientRequest.asStream();
  //   OpenAILogger.log("Starting to reading stream response");

  //   await for (var chunk in response) {
  //     String eventData = utf8.decode(chunk.bodyBytes);

  //     List<String> dataLines = eventData.split("\n");

  //     for (var line in dataLines) {
  //       if (line.startsWith("data: ")) {
  //         String data = line.substring(6);
  //         if (data.startsWith("[DONE]")) {
  //           OpenAILogger.log("stream response is done");
  //           client.close();
  //           return;
  //         }
  //         final decoded = jsonDecode(data) as Map<String, dynamic>;

  //         yield onSuccess(decoded);
  //       }
  //     }
  //   }
  // }

  static Stream<T> postStream<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    required Map<String, dynamic> body,
  }) {
    if (isOpenAIDioRegistered())
      return _postStream<T>(
        to: to,
        onSuccess: onSuccess,
        body: body,
      );
    StreamController<T> controller = StreamController<T>();

    final http.Client client = http.Client();
    http.Request request = http.Request(
      "POST",
      Uri.parse(to),
    );
    request.headers.addAll(HeadersBuilder.build());
    request.body = jsonEncode(body);

    void close() {
      client.close();
      controller.close();
    }

    OpenAILogger.log("starting request to $to");
    client.send(request).then(
      (respond) {
        OpenAILogger.log("Starting to reading stream response");
        respond.stream.listen(
          (value) {
            final String data = utf8.decode(value);

            final List<String> dataLines = data
                .split("\n")
                .where((element) => element.isNotEmpty)
                .toList();

            for (String line in dataLines) {
              if (line.startsWith("data: ")) {
                final String data = line.substring(6);
                if (data.contains("[DONE]")) {
                  OpenAILogger.log("stream response is done");

                  return;
                }

                final decoded = jsonDecode(data) as Map<String, dynamic>;

                controller.add(onSuccess(decoded));

                return;
              }
              final error = jsonDecode(data)['error'];
              if (error != null) {
                controller.addError(RequestFailedException(
                  error["message"],
                  respond.statusCode,
                ));
              }
            }
          },
          onDone: () {
            close();
          },
          onError: (error, stackTrace) {
            controller.addError(error, stackTrace);
          },
        );
      },
    );

    return controller.stream;
  }

  static Future imageEditForm<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    required File image,
    required File? mask,
    required Map<String, String> body,
  }) async {
    if (isOpenAIDioRegistered())
      return await _imageEditForm<T>(
        to: to,
        onSuccess: onSuccess,
        image: image,
        mask: mask,
        body: body,
      );

    OpenAILogger.log("starting request to $to");
    final http.MultipartRequest request = http.MultipartRequest(
      "POST",
      Uri.parse(to),
    );
    request.headers.addAll(HeadersBuilder.build());
    final http.MultipartFile file =
        await http.MultipartFile.fromPath("image", image.path);

    final http.MultipartFile? maskFile = mask != null
        ? await http.MultipartFile.fromPath("mask", mask.path)
        : null;

    request.files.add(file);
    if (maskFile != null) request.files.add(maskFile);
    request.fields.addAll(body);
    final http.StreamedResponse response = await request.send();
    OpenAILogger.log(
        "request to $to finished with status code ${response.statusCode}");

    OpenAILogger.log("starting decoding response body");
    final String encodedBody = await response.stream.bytesToString();
    final Map<String, dynamic> decodedBody =
        jsonDecode(encodedBody) as Map<String, dynamic>;
    OpenAILogger.log("response body decoded successfully");
    if (decodedBody['error'] != null) {
      OpenAILogger.log("an error occurred, throwing exception");
      final Map<String, dynamic> error = decodedBody['error'];
      throw RequestFailedException(
        error["message"],
        response.statusCode,
      );
    } else {
      OpenAILogger.log("request finished successfully");
      return onSuccess(decodedBody);
    }
  }

  static Future<T> imageVariationForm<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    // ignore: avoid-unused-parameters
    required Map<String, dynamic> body,
    required File image,
  }) async {
    if (isOpenAIDioRegistered())
      return await _imageVariationForm<T>(
        to: to,
        onSuccess: onSuccess,
        body: body,
        image: image,
      );
    OpenAILogger.log("starting request to $to");
    final http.MultipartRequest request = http.MultipartRequest(
      "POST",
      Uri.parse(to),
    );
    request.headers.addAll(HeadersBuilder.build());
    final http.MultipartFile imageFile =
        await http.MultipartFile.fromPath("image", image.path);
    request.files.add(imageFile);
    final http.StreamedResponse response = await request.send();
    OpenAILogger.log(
        "request to $to finished with status code ${response.statusCode},");

    OpenAILogger.log("starting decoding response body");
    final String encodedBody = await response.stream.bytesToString();
    final Map<String, dynamic> decodedBody =
        jsonDecode(encodedBody) as Map<String, dynamic>;
    OpenAILogger.log("response body decoded successfully");
    if (decodedBody['error'] != null) {
      OpenAILogger.log("an error occurred, throwing exception");
      final Map<String, dynamic> error = decodedBody['error'];
      throw RequestFailedException(
        error["message"],
        response.statusCode,
      );
    } else {
      OpenAILogger.log("request finished successfully");
      return onSuccess(decodedBody);
    }
  }

  static Future<T> fileUpload<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    required Map<String, String> body,
    required File file,
  }) async {
    if (isOpenAIDioRegistered())
      return await _fileUpload<T>(
        to: to,
        onSuccess: onSuccess,
        body: body,
        file: file,
      );
    OpenAILogger.log("starting request to $to");
    final http.MultipartRequest request = http.MultipartRequest(
      "POST",
      Uri.parse(to),
    );
    request.headers.addAll(HeadersBuilder.build());

    final http.MultipartFile multiPartFile =
        await http.MultipartFile.fromPath("file", file.path);

    request.files.add(multiPartFile);
    request.fields.addAll(body);
    final http.StreamedResponse response = await request.send();

    OpenAILogger.log(
        "request to $to finished with status code ${response.statusCode},");

    OpenAILogger.log("starting decoding response body");

    final String encodedBody = await response.stream.bytesToString();
    final Map<String, dynamic> decodedBody =
        jsonDecode(encodedBody) as Map<String, dynamic>;

    OpenAILogger.log("response body decoded successfully");
    if (decodedBody['error'] != null) {
      OpenAILogger.log("an error occurred, throwing exception");
      final Map<String, dynamic> error = decodedBody['error'];
      throw RequestFailedException(
        error["message"],
        response.statusCode,
      );
    } else {
      OpenAILogger.log("request finished successfully");
      return onSuccess(decodedBody);
    }
  }

  static Future<T> delete<T>({
    required String from,
    required T Function(Map<String, dynamic> response) onSuccess,
  }) async {
    if (isOpenAIDioRegistered())
      return await _delete<T>(
        from: from,
        onSuccess: onSuccess,
      );
    OpenAILogger.log("starting request to $from");

    final http.Response response = await http.delete(
      Uri.parse(from),
      headers: HeadersBuilder.build(),
    );

    OpenAILogger.log(
        "request to $from finished with status code ${response.statusCode}");

    OpenAILogger.log("starting decoding response body");
    final Map<String, dynamic> decodedBody =
        jsonDecode(response.body) as Map<String, dynamic>;
    OpenAILogger.log("response body decoded successfully");
    if (decodedBody['error'] != null) {
      OpenAILogger.log("an error occurred, throwing exception");
      final Map<String, dynamic> error = decodedBody['error'];
      throw RequestFailedException(
        error["message"],
        response.statusCode,
      );
    } else {
      OpenAILogger.log("request finished successfully");
      return onSuccess(decodedBody);
    }
  }

  /// use [Dio] in [GetIt]
  static Dio get _dio => getOpenAIDioOrNull()!;

  static Future<T> _get<T>({
    required String from,
    bool returnRawResponse = false,
    T Function(Map<String, dynamic>)? onSuccess,
  }) async {
    try {
      final response = await _dio.get(
        from,
        // options: Options(headers: HeadersBuilder.build()),
      );

      if (returnRawResponse) {
        return response.data as T;
      }

      final decodedBody = response.data as Map<String, dynamic>;

      if (decodedBody['error'] != null) {
        final error = decodedBody['error'];
        throw RequestFailedException(
          error["message"],
          response.statusCode!,
        );
      } else {
        return onSuccess!(decodedBody);
      }
    } on DioError catch (e) {
      throw RequestFailedException('${e.message}', e.response?.statusCode ?? 0);
    }
  }

  static Stream<T> _getStream<T>({
    required String from,
    required T Function(Map<String, dynamic>) onSuccess,
  }) async* {
    try {
      final response = await _dio.get(
        from,
        options: Options(responseType: ResponseType.stream),
      );

      final stream =
          (await response.data as Response<ResponseBody>).data!.stream;

      await for (final chunk in stream) {
        final String data = utf8.decode(chunk);

        final List<String> dataLines =
            data.split("\n").where((element) => element.isNotEmpty).toList();

        for (String line in dataLines) {
          if (line.startsWith("data: ")) {
            final String data = line.substring(6);
            if (data.startsWith("[DONE]")) {
              return;
            }

            final decoded = jsonDecode(data) as Map<String, dynamic>;

            yield onSuccess(decoded);
          }
        }
      }
    } on DioError catch (e) {
      throw RequestFailedException('${e.message}', e.response?.statusCode ?? 0);
    }
  }

  static Future<T> _post<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await _dio.post(
        to,
        data: body,
        // options: Options(headers: HeadersBuilder.build()),
      );

      final decodedBody = response.data as Map<String, dynamic>;

      if (decodedBody['error'] != null) {
        final error = decodedBody['error'];
        throw RequestFailedException(
          error["message"],
          response.statusCode!,
        );
      } else {
        return onSuccess(decodedBody);
      }
    } on DioError catch (e) {
      throw RequestFailedException('${e.message}', e.response?.statusCode ?? 0);
    }
  }

  static Stream<T> _postStream<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    required Map<String, dynamic> body,
  }) async* {
    StreamController<T> controller = StreamController<T>();

    try {
      Response<ResponseBody> response = await _dio.post(
        to,
        data: body,
        options: Options(responseType: ResponseType.stream),
      );
      OpenAILogger.log(
          "request to $to finished with status code ${response.statusCode}");
      if (response.statusCode == HttpStatus.ok) {
        Stream<Uint8List> stream = response.data!.stream;
        await for (var chunk in stream) {
          String eventData = utf8.decode(chunk);
          List<String> dataLines = eventData
              .split("\n")
              .where((element) => element.isNotEmpty)
              .toList();
          for (String line in dataLines) {
            if (line.startsWith("data: ")) {
              final String data = line.substring(6);
              if (data.contains("[DONE]")) {
                OpenAILogger.log("stream response is done");
                controller.close();
              } else {
                final decoded = jsonDecode(data) as Map<String, dynamic>;
                controller.add(onSuccess(decoded));
              }
            }
          }
        }
      }
    } catch (e) {
      controller.addError(e);
    }

    yield* controller.stream;
  }

  static Future<T> _imageEditForm<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    required File image,
    required File? mask,
    required Map<String, String> body,
  }) async {
    OpenAILogger.log("starting request to $to");
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path),
      if (mask != null) 'mask': await MultipartFile.fromFile(mask.path),
      ...body,
    });
    // final options = Options(headers: HeadersBuilder.build());

    try {
      Response response = await _dio.post(
        to,
        data: formData,
        // options: options,
      );
      OpenAILogger.log(
          "request to $to finished with status code ${response.statusCode}");
      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> decodedBody = response.data;
        OpenAILogger.log("response body decoded successfully");
        if (decodedBody['error'] != null) {
          OpenAILogger.log("an error occurred, throwing exception");
          final Map<String, dynamic> e = decodedBody['error'];
          throw RequestFailedException(
            e["message"],
            response.statusCode ?? 0,
          );
        } else {
          OpenAILogger.log("request finished successfully");
          return onSuccess(decodedBody);
        }
      } else {
        throw RequestFailedException(
          "Request failed with status code ${response.statusCode}",
          response.statusCode ?? 0,
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw RequestFailedException(
          e.response!.data['message'] ?? e.message,
          e.response!.statusCode!,
        );
      } else {
        throw e;
      }
    }
  }

  static Future<T> _imageVariationForm<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    required Map<String, dynamic> body,
    required File image,
  }) async {
    // _dio.options.headers = HeadersBuilder.build();
    // _dio.options.contentType = Headers.jsonContentType;

    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path),
      ...body,
    });

    final response = await _dio.post(to, data: formData);

    if (response.data['error'] != null) {
      final Map<String, dynamic> error = response.data['error'];
      throw RequestFailedException(
        error["message"],
        response.statusCode ?? 0,
      );
    } else {
      return onSuccess(response.data);
    }
  }

  static Future<T> _fileUpload<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    required Map<String, String> body,
    required File file,
  }) async {
    // _dio.options.headers = HeadersBuilder.build();
    // _dio.options.contentType = Headers.jsonContentType;

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
      ...body,
    });

    final response = await _dio.post(to, data: formData);

    if (response.data['error'] != null) {
      final Map<String, dynamic> error = response.data['error'];
      throw RequestFailedException(
        error["message"],
        response.statusCode ?? 0,
      );
    } else {
      return onSuccess(response.data);
    }
  }

  static Future<T> _delete<T>({
    required String from,
    required T Function(Map<String, dynamic>) onSuccess,
  }) async {
    // _dio.options.headers = HeadersBuilder.build();
    // _dio.options.contentType = Headers.jsonContentType;

    final response = await _dio.delete(from);

    if (response.data['error'] != null) {
      final Map<String, dynamic> error = response.data['error'];
      throw RequestFailedException(
        error["message"],
        response.statusCode ?? 0,
      );
    } else {
      return onSuccess(response.data);
    }
  }
}
