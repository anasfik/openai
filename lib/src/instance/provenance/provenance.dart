import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/networking/client.dart';

/// The content provenance checks API (`/content_provenance_checks`).
class OpenAIProvenance {
  final OpenAIClientConfig? _config;

  OpenAIProvenance([this._config]);

  String get _endpoint => OpenAIStrings.endpoints.contentProvenanceChecks;

  /// Creates a content provenance check with a flexible body.
  Future<Map<String, dynamic>> create(Map<String, dynamic> body) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, _endpoint),
      body: body,
      onSuccess: (response) => response,
      config: _config,
    );
  }
}
