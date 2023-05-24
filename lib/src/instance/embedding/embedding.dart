import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/models/embedding/embedding.dart';
import 'package:meta/meta.dart';

import '../../core/base/embeddings/base.dart';
import '../../core/constants/strings.dart';
import '../../core/networking/client.dart';
import '../../core/utils/logger.dart';

import 'package:http/http.dart' as http;

/// {@template openai_embedding}
/// Get a vector representation of a given input that can be easily consumed by machine learning models and algorithms.
/// {@endtemplate}
@immutable
@protected
interface class OpenAIEmbedding implements OpenAIEmbeddingBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.embeddings;

  /// {@macro openai_embedding}
  OpenAIEmbedding() {
    OpenAILogger.logEndpoint(endpoint);
  }

  /// Creates an embedding vector representing the input text.
  ///
  /// [model] is the id of the model to use for completion.
  ///
  /// You can get a list of available models using the [OpenAI.instance.model.list] method, or by visiting the [Models Overview](https://platform.openai.com/docs/models/overview) page.
  ///
  /// [input] is the prompt(s) to generate completions for, encoded as a [String], [List<String>] of strings or tokens.
  /// If the type of [input] is not [String] or [List<String>], an assert will be thrown, or it will be converted to a [String] using the [input.toString()] method.
  ///
  /// [user] is the user ID to associate with the request. This is used to prevent abuse of the API.
  ///
  /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. [Learn more](https://platform.openai.com/docs/guides/safety-best-practices/end-user-ids).

  /// Example:
  ///```dart
  /// OpenAIEmbeddingsModel embeddings = await OpenAI.instance.embedding.create(
  ///  model: "text-embedding-ada-002",
  ///  input: "This is a text input just to test",
  /// );
  ///```
  @override
  Future<OpenAIEmbeddingsModel> create({
    required String model,
    required input,
    String? user,
    http.Client? client,
  }) async {
    assert(
      input is String || input is List<String>,
      "The input field should be a String, or a List<String>",
    );

    return await OpenAINetworkingClient.post<OpenAIEmbeddingsModel>(
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIEmbeddingsModel.fromMap(response);
      },
      to: BaseApiUrlBuilder.build(endpoint),
      body: {
        "model": model,
        if (input != null) "input": input,
        if (user != null) "user": user,
      },
    );
  }
}
