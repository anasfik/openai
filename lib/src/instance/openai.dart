import 'package:meta/meta.dart';

import '../core/base/openai_client/base.dart';
import '../core/builder/headers.dart';
import '../core/exceptions/api_key_not_set.dart';
import 'model/model.dart';

/// The main class of the package. It is a singleton class, so you can only have one instance of it.
/// You can also access the instance by calling the [OpenAI.instance] getter.
/// ```dart
/// final openai = OpenAI.instance;
/// ```
@immutable
class OpenAI extends OpenAIClientBase {
  /// The singleton instance of [OpenAI].
  static final OpenAI _instance = OpenAI._();

  /// The API key used to authenticate the requests.
  static String? _internalApiKey;

  /// The singleton instance of [OpenAI], make sure to call the [OpenAI.initialize] method before accessing [instance], otherwise it will throw an [Exception].
  static OpenAI get instance {
    if (_internalApiKey == null) {
      throw MissingApiKeyException("""
      You must call the initialize method before accessing the instance of this class.
      Example:
      OpenAI.initialize("YOUR_API_KEY"");
      """);
    }

    return _instance;
  }

  /// This method is used to initialize the [OpenAI] instance, by providing the API key.
  /// ```dart
  /// OpenAI.apiKey = "YOUR_API_KEY";
  /// ```
  static set apiKey(String apiKey) {
    HeadersBuilder.apiKey = apiKey;
    _internalApiKey = apiKey;
  }

  /// If you have multiple organizations, you can set it's id with this
  /// Example:
  /// ```dart
  /// OpenAI.organization = "YOUR_ORGANIZATION_ID";
  /// ```
  static set organization(String organizationId) {
    HeadersBuilder.organization = organizationId;
  }

  OpenAIModel get model => OpenAIModel();

  /// The constructor of [OpenAI]. It is private, so you can only access the instance by calling the [OpenAI.instance] getter.
  OpenAI._();
}
