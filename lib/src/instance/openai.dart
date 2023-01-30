import 'package:meta/meta.dart';

import '../core/base/openai_client/base.dart';
import '../core/exceptions/api_key_not_set.dart';

@immutable

/// The main class of the package. It is a singleton class, so you can only have one instance of it.
/// You can also access the instance by calling the [OpenAI.instance] getter.
/// ```dart
/// final openai = OpenAI.instance;
/// ```
class OpenAI extends OpenAIClientBase {
  /// The singleton instance of [OpenAI].
  static final OpenAI _instance = OpenAI._();

  /// The singleton instance of [OpenAI], make sure to call the [OpenAI.initialize] method before accessing [instance], otherwise it will throw an [Exception].
  static OpenAI get instance {
    if (_internalApiKey == null) {
      throw MissingApiKeyException("""
      You must call the initialize method before accessing the instance of this class.
      Example:
      OpenAI.initialize(dotenv.env['OPENAI_API_KEY']);
      """);
    }

    return _instance;
  }

  /// The API key used to authenticate the requests.
  static String? _internalApiKey;

  /// This method is used to initialize the [OpenAI] instance, by providing the API key.
  /// ```dart
  /// OpenAI.initialize(dotenv.env['OPENAI_API_KEY']);
  /// ```
  static void initialize(String apiKey) {
    _internalApiKey = apiKey;
  }

  /// The constructor of [OpenAI]. It is private, so you can only access the instance by calling the [OpenAI.instance] getter.
  OpenAI._();
}
