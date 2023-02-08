import 'package:dart_openai/src/core/base/model/base.dart';
import 'package:dart_openai/src/core/models/model/model.dart';
import 'package:dart_openai/src/core/utils/logger.dart';
import '../../core/builder/base_api_url.dart';
import '../../core/networking/client.dart';
import 'package:meta/meta.dart';

/// The class that handles all the requests related to the models in the OpenAI API.
/// it provides methods to list all the models, retrieve a model by it's id, and delete a fine-tuned model that you did made.
@immutable
@protected
class OpenAIModel implements OpenAIModelBase {
  @override
  String get endpoint => "/models";

  /// Lists all the models available in the OpenAI API and returns a list of [OpenAIModelModel] objects.
  /// Refer to [Models](https://platform.openai.com/docs/models/models) for more information about the available models.
  ///
  /// Example:
  /// ```dart
  ///  List<OpenAIModelModel> models = await OpenAI.instance.model.list();
  ///  print(models.first.id);
  /// ```
  @override
  Future<List<OpenAIModelModel>> list() async {
    return await OpenAINetworkingClient.get<List<OpenAIModelModel>>(
      from: BaseApiUrlBuilder.build(
        endpoint,
      ),
      onSuccess: (Map<String, dynamic> response) {
        final List<dynamic> data = response['data'];
        return data
            .map((dynamic model) => OpenAIModelModel.fromJson(model))
            .toList();
      },
    );
  }

  /// Retrieves a model by it's id and returns a [OpenAIModelModel] object, if the model is not found, it will throw a [RequestFailedException].
  ///
  /// Example:
  /// ```dart
  ///  OpenAIModelModel model = await OpenAI.instance.model.retrieve("MODEL ID");
  ///  print(model.id)
  /// ```
  @override
  Future<OpenAIModelModel> retrieve(String id) async {
    return await OpenAINetworkingClient.get<OpenAIModelModel>(
      from: BaseApiUrlBuilder.build(endpoint, id),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIModelModel.fromJson(response);
      },
    );
  }

  /// Deletes a fine-tuned model, returns [true] if the model did been deleted successfully, if the model is not found, it will throw a [RequestFailedException].
  /// Example:
  /// ```dart
  /// bool deleted = await OpenAI.instance.fineTune.delete("FINE TUNE ID");
  /// ```
  Future<bool> delete(String fineTuneId) async {
    final String fineTuneModelDelete = "$endpoint/$fineTuneId";

    return await OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.build(fineTuneModelDelete),
      onSuccess: (Map<String, dynamic> response) {
        return response['deleted'];
      },
    );
  }

  OpenAIModel() {
    OpenAILogger.logEndpoint(endpoint);
  }
}
