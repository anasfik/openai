import 'package:dart_openai/src/core/base/model/base.dart';
import 'package:dart_openai/src/core/models/model/model.dart';
import 'package:dart_openai/src/core/utils/logger.dart';
import '../../core/builder/base_api_url.dart';
import '../../core/networking/client.dart';
import 'package:meta/meta.dart';

@immutable
@protected
class OpenAIModel implements OpenAIModelBase {
  @override
  String get endpoint => "/models";

  /// This function fetches for models and provide their informations..
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

  /// This function fetches for a single model and get its informations based on it's id
  /// Example:
  /// ```dart
  ///  OpenAIModelModel model = await OpenAI.instance.model.retrieve("MODEL ID");
  ///  print(model.id)
  /// ```
  @override
  Future<OpenAIModelModel> retrieve(String modelId) async {
    return await OpenAINetworkingClient.get<OpenAIModelModel>(
      from: BaseApiUrlBuilder.build(endpoint, modelId),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIModelModel.fromJson(response);
      },
    );
  }

  /// delete a fine tune model, returns true if deleted
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
