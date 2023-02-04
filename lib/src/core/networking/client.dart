import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:openai/src/core/builder/headers.dart';
import 'package:openai/src/core/utils/logger.dart';

import '../exceptions/request_failure.dart';

class OpenAINetworkingClient {
  static Future<T> get<T>({
    required String from,
    bool returnRawResponse = false,
    T Function(Map<String, dynamic>)? onSuccess,
  }) async {
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
      return onSuccess!(decodedBody);
    }
  }

  static Future<T> post<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    Map<String, dynamic>? body,
  }) async {
    OpenAILogger.log("starting request to $to");

    final http.Response response = await http.post(
      Uri.parse(to),
      headers: HeadersBuilder.build(),
      body: body != null ? jsonEncode(body) : null,
    );

    OpenAILogger.log(
        "request to $to finished with status code ${response.statusCode}");

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

  static Stream<T> postStream<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    required Map<String, dynamic> body,
  }) async* {
    final http.Client client = http.Client();
    final clientRequest = client.post(
      Uri.parse(to),
      headers: HeadersBuilder.build(),
      body: jsonEncode(body),
    );
    final response = clientRequest.asStream();

    await for (var chunk in response) {
      String eventData = utf8.decode(chunk.bodyBytes);

      List<String> dataLines = eventData.split("\n");

      for (var line in dataLines) {
        if (line.startsWith("data: ")) {
          String data = line.substring(6);
          if (data.startsWith("[DONE]")) {
            client.close();
            return;
          }
          final decoded = jsonDecode(data) as Map<String, dynamic>;

          yield onSuccess(decoded);
        }
      }
    }
  }

  static Future imageEditForm<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    required File image,
    required File? mask,
    required Map<String, String> body,
  }) async {
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
    required Map<String, dynamic> body,
    required File image,
  }) async {
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
}
