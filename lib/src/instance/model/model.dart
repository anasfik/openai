import 'package:dart_openai/src/core/base/model/base.dart';
import 'package:dart_openai/src/core/models/model/model.dart';
import 'package:dart_openai/src/core/utils/logger.dart';
import '../../core/builder/base_api_url.dart';
import '../../core/constants/strings.dart';
import '../../core/networking/client.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

/// {@template openai_model}
/// The class that handles all the requests related to the models in the OpenAI API.
/// {@endtemplate}
@immutable
@protected
interface class OpenAIModel implements OpenAIModelBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.models;

  /// {@macro openai_model}
  OpenAIModel() {
    OpenAILogger.logEndpoint(endpoint);
  }

  /// Lists all the models available in the OpenAI API and returns a list of [OpenAIModelModel] objects.
  /// Refer to [Models](https://platform.openai.com/docs/models/models) for more information about the available models.
  ///
  /// Example:
  /// ```dart
  ///  List<OpenAIModelModel> models = await OpenAI.instance.model.list();
  ///  print(models.first.id);
  /// ```
  @override
  Future<List<OpenAIModelModel>> list({
    http.Client? client,
  }) async {
    return await OpenAINetworkingClient.get<List<OpenAIModelModel>>(
      from: BaseApiUrlBuilder.build(
        endpoint,
      ),
      onSuccess: (Map<String, dynamic> response) {
        final List data = response['data'];

        return data.map((model) => OpenAIModelModel.fromMap(model)).toList();
      },
      client: client,
    );
  }

  /// Retrieves a model by it's id and returns a [OpenAIModelModel] object, if the model is not found, it will throw a [RequestFailedException].
  ///
  /// [id] is the id of the model to use for this request.
  ///
  /// Example:
  /// ```dart
  /// OpenAIModelModel model = await OpenAI.instance.model.retrieve("text-davinci-003");
  /// print(model.id)
  /// ```
  @override
  Future<OpenAIModelModel> retrieve(
    String id, {
    http.Client? client,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIModelModel>(
      from: BaseApiUrlBuilder.build(endpoint, id),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIModelModel.fromMap(response);
      },
      client: client,
    );
  }

  /// Deletes a fine-tuned model, returns [true] if the model did been deleted successfully, if the model is not found, it will throw a [RequestFailedException].
  ///
  /// [fineTuneId] is the id of the fine-tuned model to delete.
  ///
  /// Example:
  /// ```dart
  /// bool deleted = await OpenAI.instance.fineTune.delete("fine-tune-id");
  /// ```
  @override
  Future<bool> delete(
    String fineTuneId, {
    http.Client? client,
  }) async {
    final String fineTuneModelDelete = "$endpoint/$fineTuneId";

    return await OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.build(fineTuneModelDelete),
      onSuccess: (Map<String, dynamic> response) {
        return response['deleted'];
      },
      client: client,
    );
  }
}
