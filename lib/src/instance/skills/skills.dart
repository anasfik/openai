import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/skills/models.dart';
import 'package:dart_openai/src/core/networking/client.dart';

/// The Skills API (`/skills`).
class OpenAISkills {
  final OpenAIClientConfig? _config;

  OpenAISkills([this._config]);

  String get _endpoint => OpenAIStrings.endpoints.skills;

  /// Lists skills.
  Future<OpenAISkillList> list({String? after, int? limit}) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: _endpoint,
        query: {
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
        },
        config: _config,
      ),
      onSuccess: OpenAISkillList.fromMap,
      config: _config,
    );
  }

  /// Retrieves a skill.
  Future<OpenAISkillModel> retrieve({required String skillId}) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint, skillId),
      onSuccess: OpenAISkillModel.fromMap,
      config: _config,
    );
  }

  /// Deletes a skill.
  Future<Map<String, dynamic>> delete({required String skillId}) async {
    return OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint, skillId),
      onSuccess: (response) => response,
      config: _config,
    );
  }

  /// Retrieves the content of a skill.
  Future<Map<String, dynamic>> getContent({required String skillId}) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/$skillId/content'),
      onSuccess: (response) => response,
      config: _config,
    );
  }

  /// Lists versions of a skill.
  Future<List<Map<String, dynamic>>> listVersions({
    required String skillId,
  }) async {
    return OpenAINetworkingClient.get<List<Map<String, dynamic>>>(
      from: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/$skillId/versions'),
      onSuccess: (response) => (response['data'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .toList(),
      config: _config,
    );
  }

  /// Retrieves a specific version of a skill.
  Future<Map<String, dynamic>> getVersion({
    required String skillId,
    required String version,
  }) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(
        _config,
        '$_endpoint/$skillId/versions/$version',
      ),
      onSuccess: (response) => response,
      config: _config,
    );
  }

  /// Retrieves the content of a specific skill version
  /// (`GET /skills/{id}/versions/{version}/content`). Raw response map.
  Future<Map<String, dynamic>> getVersionContent({
    required String skillId,
    required String version,
  }) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(
        _config,
        '$_endpoint/$skillId/versions/$version/content',
      ),
      onSuccess: (response) => response,
      config: _config,
    );
  }
}
