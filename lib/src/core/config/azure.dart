import 'dart:convert';

import 'client_config.dart';

/// Azure OpenAI settings for an [OpenAIClient].
///
/// Azure exposes models through *deployments* rather than model names:
/// `POST {resource}/openai/deployments/{deployment}/chat/completions?api-version=...`
///
/// When [OpenAIClientConfig.azure] is set, the networking layer transparently
/// rewrites outgoing JSON requests this way: any request whose body carries a
/// `model` field has that model mapped through [deployments] (falling back to
/// using the raw model id as the deployment name) and the URL is rewritten to
/// Azure's shape with [apiVersion] appended.
///
/// ```dart
/// final azure = OpenAIClient(
///   apiKey: '<azure-key>',
///   azure: const OpenAIAzure(
///     resource: 'my-resource',
///     apiVersion: '2024-10-21',
///     deployments: {'gpt-4o': 'gpt-4o-prod'},
///   ),
/// );
/// await azure.chat.create(model: 'gpt-4o', messages: [...]);
/// ```
class OpenAIAzure {
  /// Azure resource name (the `{resource}` in `{resource}.openai.azure.com`).
  final String resource;

  /// Azure API version query parameter, e.g. `2024-10-21`.
  final String apiVersion;

  /// Maps SDK model ids to your deployment names.
  final Map<String, String> deployments;

  /// Custom domain, e.g. when using Azure Government or a private endpoint.
  /// Defaults to `{resource}.openai.azure.com`.
  final String? domain;

  const OpenAIAzure({
    required this.resource,
    required this.apiVersion,
    this.deployments = const {},
    this.domain,
  });

  String get host => domain ?? '$resource.openai.azure.com';

  String deploymentFor(String model) => deployments[model] ?? model;
}

/// Rewrites a standard OpenAI request into its Azure equivalent.
(Uri, Map<String, dynamic>) openAIAzureRewrite({
  required Uri uri,
  required Map<String, dynamic>? body,
  required OpenAIClientConfig config,
}) {
  final azure = config.azure!;
  final segments = List<String>.from(uri.pathSegments);
  // Standard shape: /{version}/{operation...} — drop version segment.
  if (segments.isNotEmpty && segments.first == config.version) {
    segments.removeAt(0);
  }

  String? deployment;
  if (body != null && body.containsKey('model')) {
    final model = body['model']?.toString();
    if (model != null && model.isNotEmpty) {
      deployment = azure.deploymentFor(model);
      body = {...body}..['model'] = deployment;
    }
  }

  final rewritten = <String>['openai'];
  if (deployment != null && segments.isNotEmpty) {
    // /chat/completions -> /deployments/{deployment}/chat/completions
    rewritten.addAll(['deployments', deployment, ...segments]);
  } else {
    rewritten.addAll(segments);
  }

  final query = Map<String, String>.from(uri.queryParameters)
    ..['api-version'] = azure.apiVersion;

  return (
    uri.replace(
        scheme: 'https',
        host: azure.host,
        pathSegments: rewritten,
        queryParameters: query),
    body ?? const {},
  );
}

/// Convenience encoder used by the transport before sending rewritten bodies.
String encodeBody(Map<String, dynamic> body) => jsonEncode(body);
