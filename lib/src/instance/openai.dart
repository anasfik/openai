import 'package:meta/meta.dart';
import 'package:dart_openai/src/instance/edits/edits.dart';
import 'package:dart_openai/src/instance/moderations/moderations.dart';
import '../core/base/openai_client/base.dart';
import '../core/builder/headers.dart';
import '../core/constants/config.dart';
import '../core/exceptions/api_key_not_set.dart';
import '../core/utils/logger.dart';
import 'audio/audio.dart';
import 'chat/chat.dart';
import 'completion/completion.dart';
import 'embedding/embedding.dart';
import 'files/files.dart';
import 'fine_tunes/fine_tunes.dart';
import 'images/images.dart';
import 'model/model.dart';

/// The main class of the package. It is a singleton class, so you can only have one instance of it.
/// You can also access the instance by calling the [OpenAI.instance] getter.
/// ```dart
/// final openai = OpenAI.instance;
/// ```
@immutable
final class OpenAI extends OpenAIClientBase {
  /// The singleton instance of [OpenAI].
  static final OpenAI _instance = OpenAI._();

  /// The API key used to authenticate the requests.
  static String? _internalApiKey;

  /// The singleton instance of [OpenAI], make sure to set your OpenAI API key via the [OpenAI.apiKey] setter before accessing the [OpenAI.instance], otherwise it will throw an [Exception].
  /// A [MissingApiKeyException] will be thrown, if the API key is not set.
  static OpenAI get instance {
    if (_internalApiKey == null) {
      throw MissingApiKeyException("""
      You must set the api key before accessing the instance of this class.
      Example:
      OpenAI.apiKey = "Your API Key";
      """);
    }

    return _instance;
  }

  /// {@macro openai_config_requests_timeOut}
  static Duration get requestsTimeOut => OpenAIConfig.requestsTimeOut;

  // /// {@macro openai_config_is_web}
  // static bool get isWeb => OpenAIConfig.isWeb;

  /// The [OpenAIModel] instance, used to access the model endpoints.
  /// Please, refer to the Models page from the official OpenAI documentation website in order to know what models are available and what's the use case of every model.
  OpenAIModel get model => OpenAIModel();

  /// The [OpenAICompletion] instance, used to access the completion endpoints.
  OpenAICompletion get completion => OpenAICompletion();

  /// The [OpenAIEdits] instance, used to access the edits endpoints.
  OpenAIEdits get edit => OpenAIEdits();

  /// The [OpenAIImages] instance, used to access the images endpoints.
  OpenAIImages get image => OpenAIImages();

  /// The [OpenAIEmbedding] instance, used to access the embeddings endpoints.
  OpenAIEmbedding get embedding => OpenAIEmbedding();

  /// The [OpenAIFiles] instance, used to access the files endpoints.
  OpenAIFiles get file => OpenAIFiles();

  /// The [OpenAIFineTunes] instance, used to access the fine-tunes endpoints.
  OpenAIFineTunes get fineTune => OpenAIFineTunes();

  /// The [OpenAIModeration] instance, used to access the moderation endpoints.
  OpenAIModeration get moderation => OpenAIModeration();

  /// The [OpenAIChat] instance, used to access the chat endpoints.
  OpenAIChat get chat => OpenAIChat();

  /// The [OpenAIAudio] instance, used to access the audio endpoints.
  OpenAIAudio get audio => OpenAIAudio();

  /// The organization id, if set, it will be used in all the requests to the OpenAI API.
  static String? get organization => HeadersBuilder.organization;

  /// The base API url, by default it is set to the OpenAI API url.
  /// You can change it by calling the [OpenAI.baseUrl] setter.
  static String get baseUrl => OpenAIConfig.baseUrl;

  /// {@macro openai_config_requests_timeOut}
  static set requestsTimeOut(Duration requestsTimeOut) {
    OpenAIConfig.requestsTimeOut = requestsTimeOut;
    OpenAILogger.requestsTimeoutChanged(requestsTimeOut);
  }

  // /// The HTTP client that will be used to make the requests to the OpenAI API.
  // /// you can set yout own client, or just set to [null] to use the default client.
  // ///
  // /// Example:
  // /// ```dart
  // /// final theClientUsedByThePackageAtAnyMoment = OpenAI.httpClient;
  // /// ```
  // static http.Client get httpClient => OpenAINetworkingClient.httpClient;

  /// This is used to initialize the [OpenAI] instance, by providing the API key.
  /// All the requests will be authenticated using this API key.
  /// ```dart
  /// OpenAI.apiKey = "YOUR_API_KEY";
  /// ```
  static set apiKey(String apiKey) {
    HeadersBuilder.apiKey = apiKey;
    _internalApiKey = apiKey;
  }

  /// This is used to set the base url of the OpenAI API, by default it is set to [OpenAIConfig.baseUrl].
  static set baseUrl(String baseUrl) {
    OpenAIConfig.baseUrl = baseUrl;
  }

  /// If you have multiple organizations, you can set it's id with this.
  /// once this is set, it will be used in all the requests to the OpenAI API.
  ///
  /// Example:
  ///
  /// ```dart
  /// OpenAI.organization = "YOUR_ORGANIZATION_ID";
  /// ```
  static set organization(String? organizationId) {
    HeadersBuilder.organization = organizationId;
  }

  /// This controls whether to log steps inside the process of making a request, this helps debugging and pointing where something went wrong.
  /// This uses  [dart:developer] internally, so it will show anyway only while debugging code.
  ///
  /// By default it is set to [true].
  ///
  /// Example:
  /// ```dart
  /// OpenAI.instance.showLogs = false;
  /// ```
  static set showLogs(bool newValue) {
    OpenAILogger.isActive = newValue;
  }

  /// This controls whether to log responses bodies or not.
  /// This uses  [dart:developer] internally, so it will show anyway only while debugging code.
  ///
  /// By default it is set to [false].
  ///
  /// Example:
  /// ```dart
  /// OpenAI.showResponsesLogs = true;
  /// ```
  static set showResponsesLogs(bool showResponsesLogs) {
    OpenAILogger.showResponsesLogs = showResponsesLogs;
  }

  // /// Wether the package is running on the web or not, example of this is the use of Flutter web.
  // ///
  // /// By default it is set to [false].
  // ///
  // /// ```dart
  // /// OpenAI.isWeb = kIsWeb;
  // /// ```
  // ///
  // static set isWeb(bool newValue) {
  //   OpenAIConfig.isWeb = newValue;
  // }

  // /// Sets the given [client] as the new client that will be used in the requests made by the package.
  // ///
  // /// Example:
  // /// ```dart
  // /// OpenAI.httpClient = http.Client(); /// assuming that you imported the http package
  // /// ```
  // static set httpClient(http.Client client) {
  //   OpenAINetworkingClient.httpClient = client;
  // }

  /// The constructor of [OpenAI]. It is private, so you can only access the instance by calling the [OpenAI.instance] getter.
  OpenAI._();

  /// Adds the given [headers] to all future requests made using the package.
  ///
  /// Example:
  /// ```dart
  /// OpenAI.includeHeaders({
  ///  "X-My-Header": "My Header Value",
  /// });
  /// ```
  static void includeHeaders(Map<String, dynamic> headers) {
    HeadersBuilder.includeHeaders(headers);
  }
}
