import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:openai/src/core/builder/headers.dart';
import 'package:openai/src/core/utils/logger.dart';

import '../exceptions/request_failure.dart';

class OpenAINetworkingClient {
  static Future<T> get<T>({
    required String from,
    required T Function(Map<String, dynamic>) onSuccess,
  }) async {
    OpenAILogger.log("starting request to $from");

    final response = await http.get(
      Uri.parse(from),
      headers: HeadersBuilder.build(),
    );

    OpenAILogger.log(
        "request to $from finished with status code ${response.statusCode}");

    OpenAILogger.log("starting decoding response body");
    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;
    OpenAILogger.log("response body decoded successfully");

    if (decodedBody['error'] != null) {
      OpenAILogger.log("an error occurred, throwing exception");
      final error = decodedBody['error'];
      throw RequestFailedException(
        error["message"],
        response.statusCode,
      );
    } else {
      OpenAILogger.log("request finished successfully");
      return onSuccess(decodedBody);
    }
  }

  static Future<T> post<T>({
    required String to,
    required T Function(Map<String, dynamic>) onSuccess,
    Map<String, dynamic>? body,
  }) async {
    OpenAILogger.log("starting request to $to");

    final response = await http.post(
      Uri.parse(to),
      headers: HeadersBuilder.build(),
      body: body != null ? jsonEncode(body) : null,
    );

    OpenAILogger.log(
        "request to $to finished with status code ${response.statusCode}");

    OpenAILogger.log("starting decoding response body");
    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;
    OpenAILogger.log("response body decoded successfully");

    if (decodedBody['error'] != null) {
      OpenAILogger.log("an error occurred, throwing exception");
      final error = decodedBody['error'];
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
