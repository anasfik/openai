import 'package:openai/src/core/base/model/base.dart';
import 'package:openai/src/core/models/model.dart';
import 'package:openai/src/core/utils/logger.dart';
import '../../core/builder/base_api_url.dart';
import '../../core/networking/client.dart';

class OpenAIModel implements OpenAIModelBase {
  @override
  String get endpoint => "/models";

  /// This function fetches for models and provide their informations..
  /// Example:
  ///```dart
  ///
  ///```
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
  ///```dart
  ///
  ///```
  @override
  Future<OpenAIModelModel> one(String modelId) async {
    return await OpenAINetworkingClient.get<OpenAIModelModel>(
      from: BaseApiUrlBuilder.build(endpoint, modelId),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIModelModel.fromJson(response);
      },
    );
  }

  OpenAIModel() {
    OpenAILogger.logEndpoint(endpoint);
  }
}
