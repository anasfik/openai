import '../core/base/openAI_client/base.dart';
import '../core/builder/headers.dart';
import '../core/constants/config.dart';
import '../core/exceptions/export.dart';
import '../core/utils/logger.dart';
import 'azure_completion/azure_completion.dart';

class AzureOpenAI extends OpenAIClientBase {
  /// The singleton instance of [AzureOpenAI].
  static final AzureOpenAI _instance = AzureOpenAI._();

  /// The API key used to authenticate the requests.
  static String? _internalApiKey;

  /// The singleton instance of [AzureOpenAI], make sure to call the [AzureOpenAI.initialize] method before accessing [instance], otherwise it will throw an [Exception].
  /// A [MissingApiKeyException] will be thrown, if the API key is not set.
  static AzureOpenAI get instance {
    if (_internalApiKey == null) {
      throw MissingApiKeyException("""
      You must set the api key before accessing the instance of this class.
      Example:
      AzureOpenAI.apiKey = "Your API Key";
      """);
    }

    return _instance;
  }

  // /// The [AzureOpenAIModel] instance, used to access the model endpoints.
  // /// Please, refer to the Models page from the official AzureOpenAI documentation website in order to know what models are available and what's the use case of every model.
  // AzureOpenAIModel get model => AzureOpenAIModel();

  /// The [AzureOpenAICompletion] instance, used to access the completion endpoints.
  AzureOpenAICompletion get completion => AzureOpenAICompletion();

  // /// The [AzureOpenAIEdits] instance, used to access the edits endpoints.
  // AzureOpenAIEdits get edit => AzureOpenAIEdits();

  // /// The [AzureOpenAIImages] instance, used to access the images endpoints.
  // AzureOpenAIImages get image => AzureOpenAIImages();

  // /// The [AzureOpenAIEmbedding] instance, used to access the embeddings endpoints.
  // AzureOpenAIEmbedding get embedding => AzureOpenAIEmbedding();

  // /// The [AzureOpenAIFiles] instance, used to access the files endpoints.
  // AzureOpenAIFiles get file => AzureOpenAIFiles();

  // /// The [AzureOpenAIFineTunes] instance, used to access the fine-tunes endpoints.
  // AzureOpenAIFineTunes get fineTune => AzureOpenAIFineTunes();

  // /// The [AzureOpenAIModeration] instance, used to access the moderation endpoints.
  // AzureOpenAIModeration get moderation => AzureOpenAIModeration();

  // /// The [AzureOpenAIChat] instance, used to access the chat endpoints.
  // AzureOpenAIChat get chat => AzureOpenAIChat();

  // /// The [AzureOpenAIAudio] instance, used to access the audio endpoints.
  // AzureOpenAIAudio get audio => AzureOpenAIAudio();

  // /// The organization id, if set, it will be used in all the requests to the AzureOpenAI API.
  // static String? get organization => HeadersBuilder.organization;

  /// The base API url, by default it is set to the AzureOpenAI API url.
  /// You can change it by calling the [AzureOpenAI.baseUrl] setter.
  static String get templateUrl => AzureOpenAIConfig.buildUrlForResource(
        resourceEndpoint: "THIS_IS_A_PLACEHOLDER_FOR_ENDPOINTS",
      );

  // /// The HTTP client that will be used to make the requests to the AzureOpenAI API.
  // /// you can set yout own client, or just set to [null] to use the default client.
  // ///
  // /// Example:
  // /// ```dart
  // /// final theClientUsedByThePackageAtAnyMoment = AzureOpenAI.httpClient;
  // /// ```
  // static http.Client get httpClient => AzureOpenAINetworkingClient.httpClient;

  /// This is used to initialize the [AzureOpenAI] instance, by providing the API key.
  /// All the requests will be authenticated using this API key.
  /// ```dart
  /// AzureOpenAI.apiKey = "YOUR_API_KEY";
  /// ```
  static set apiKey(String apiKey) {
    HeadersBuilder.apiKey = apiKey;
    _internalApiKey = apiKey;
  }

  static void configureRestAPI({
    required String yourResourceName,
    required String yourDeploymentName,
    required DateTime apiVersion,
  }) {
    AzureOpenAIConfig.resourceName = yourResourceName;
    AzureOpenAIConfig.deploymentName = yourDeploymentName;
    AzureOpenAIConfig.apiVersion = apiVersion;
  }

  /// This controls whether to log steps inside the process of making a request, this helps debugging and pointing where something went wrong.
  /// This uses  [dart:developer] internally, so it will show anyway only while debugging code.
  ///
  /// By default it is set to [true].
  ///
  /// Example:
  /// ```dart
  /// AzureOpenAI.instance.showLogs = false;
  /// ```
  static set showLogs(bool newValue) {
    OpenAILogger.isActive = newValue;
  }

  // /// Sets the given [client] as the new client that will be used in the requests made by the package.
  // ///
  // /// Example:
  // /// ```dart
  // /// AzureOpenAI.httpClient = http.Client(); /// assuming that you imported the http package
  // /// ```
  // static set httpClient(http.Client client) {
  //   AzureOpenAINetworkingClient.httpClient = client;
  // }

  /// The constructor of [AzureOpenAI]. It is private, so you can only access the instance by calling the [AzureOpenAI.instance] getter.
  AzureOpenAI._();

  /// Adds the given [headers] to all future requests made using the package.
  ///
  /// Example:
  /// ```dart
  /// AzureOpenAI.includeHeaders({
  ///  "X-My-Header": "My Header Value",
  /// });
  /// ```
  static void includeHeaders(Map<String, dynamic> headers) {
    HeadersBuilder.includeHeaders(headers);
  }
}
