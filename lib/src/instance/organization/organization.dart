import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/models/organization/models.dart';
import 'package:dart_openai/src/core/networking/client.dart';

class OpenAIOrganization {
  OpenAIOrganization([OpenAIClientConfig? config])
      : projects = OpenAIProjects(config),
        users = OpenAIOrgUsers(config),
        invites = OpenAIInvites(config),
        auditLogs = OpenAIAuditLogs(config),
        costs = OpenAICosts(config),
        rateLimits = OpenAIRateLimits(config),
        adminApiKeys = OpenAIAdminApiKeys(config);

  final OpenAIProjects projects;

  final OpenAIOrgUsers users;

  final OpenAIInvites invites;

  final OpenAIAuditLogs auditLogs;

  final OpenAICosts costs;

  final OpenAIRateLimits rateLimits;

  final OpenAIAdminApiKeys adminApiKeys;
}

class OpenAIProjects {
  final OpenAIClientConfig? _config;

  OpenAIProjects(this._config);

  String get _endpoint => 'organization/projects';

  Future<OpenAIOrgPage<OrgProject>> list({String? after, int? limit}) async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: _endpoint,
        query: {
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
        },
        config: _config,
      ),
      onSuccess: (map) => OpenAIOrgPage.fromMap(map, OrgProject.fromMap),
      config: _config,
    );
  }

  Future<OrgProject> create({required String name}) async {
    return await OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, _endpoint),
      body: {'name': name},
      onSuccess: OrgProject.fromMap,
      config: _config,
    );
  }

  Future<OrgProject> retrieve({required String projectId}) async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint, projectId),
      onSuccess: OrgProject.fromMap,
      config: _config,
    );
  }

  Future<OrgProject> archive({required String projectId}) async {
    return await OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/$projectId/archive'),
      onSuccess: OrgProject.fromMap,
      config: _config,
    );
  }
}

class OpenAIOrgUsers {
  final OpenAIClientConfig? _config;

  OpenAIOrgUsers(this._config);

  String get _endpoint => 'organization/users';

  Future<OpenAIOrgPage<OrgUser>> list({
    String? after,
    String? email,
    int? limit,
  }) async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: _endpoint,
        query: {
          if (after != null) 'after': after,
          if (email != null) 'email': email,
          if (limit != null) 'limit': limit.toString(),
        },
        config: _config,
      ),
      onSuccess: (map) => OpenAIOrgPage.fromMap(map, OrgUser.fromMap),
      config: _config,
    );
  }

  Future<OrgUser> retrieve({required String userId}) async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint, userId),
      onSuccess: OrgUser.fromMap,
      config: _config,
    );
  }
}

class OpenAIInvites {
  final OpenAIClientConfig? _config;

  OpenAIInvites(this._config);

  String get _endpoint => 'organization/invites';

  Future<OpenAIOrgPage<OrgInvite>> list({
    String? after,
    int? limit,
  }) async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: _endpoint,
        query: {
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
        },
        config: _config,
      ),
      onSuccess: (map) => OpenAIOrgPage.fromMap(map, OrgInvite.fromMap),
      config: _config,
    );
  }

  Future<OrgInvite> create({
    required String email,
    required String role,
  }) async {
    return await OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, _endpoint),
      body: {'email': email, 'role': role},
      onSuccess: OrgInvite.fromMap,
      config: _config,
    );
  }

  Future<bool> delete({required String inviteId}) async {
    return await OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint, inviteId),
      onSuccess: (map) => map['deleted'] as bool? ?? true,
      config: _config,
    );
  }
}

class OpenAIAuditLogs {
  final OpenAIClientConfig? _config;

  OpenAIAuditLogs(this._config);

  Future<OpenAIOrgPage<AuditLogEntry>> list({
    int? effectiveAtGt,
    int? effectiveAtLt,
    String? resourceContains,
    List<String>? eventTypes,
    int? limit,
    String? after,
  }) async {
    // ponytail: event_types/group_by joined as comma string since
    // buildWithQuery takes Map<String, String>; switch to raw Uri when
    // repeated params are needed.
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: 'organization/audit_logs',
        query: {
          if (effectiveAtGt != null) 'effective_at[gt]': '$effectiveAtGt',
          if (effectiveAtLt != null) 'effective_at[lt]': '$effectiveAtLt',
          if (resourceContains != null) 'resource_name': resourceContains,
          if (eventTypes != null && eventTypes.isNotEmpty)
            'event_types[]': eventTypes.join(','),
          if (limit != null) 'limit': limit.toString(),
          if (after != null) 'after': after,
        },
        config: _config,
      ),
      onSuccess: (map) => OpenAIOrgPage.fromMap(map, AuditLogEntry.fromMap),
      config: _config,
    );
  }
}

class OpenAICosts {
  final OpenAIClientConfig? _config;

  OpenAICosts(this._config);

  Future<OpenAIOrgPage<CostBucket>> list({
    required int startTime,
    int? endTime,
    int? limit,
    String? after,
    List<String>? groupBy,
  }) async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: 'organization/costs',
        query: {
          'start_time': startTime.toString(),
          if (endTime != null) 'end_time': endTime.toString(),
          if (limit != null) 'limit': limit.toString(),
          if (after != null) 'after': after,
          if (groupBy != null && groupBy.isNotEmpty)
            'group_by': groupBy.join(','),
        },
        config: _config,
      ),
      onSuccess: (map) => OpenAIOrgPage.fromMap(map, CostBucket.fromMap),
      config: _config,
    );
  }
}

class OpenAIRateLimits {
  final OpenAIClientConfig? _config;

  OpenAIRateLimits(this._config);

  Future<OpenAIOrgPage<RateLimit>> list({
    int? limit,
    String? after,
  }) async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: 'organization/rate_limits',
        query: {
          if (limit != null) 'limit': limit.toString(),
          if (after != null) 'after': after,
        },
        config: _config,
      ),
      onSuccess: (map) => OpenAIOrgPage.fromMap(map, RateLimit.fromMap),
      config: _config,
    );
  }
}

class OpenAIAdminApiKeys {
  final OpenAIClientConfig? _config;

  OpenAIAdminApiKeys(this._config);

  String get _endpoint => 'organization/admin_api_keys';

  Future<OpenAIOrgPage<AdminApiKey>> list({
    int? limit,
    String? after,
  }) async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: _endpoint,
        query: {
          if (limit != null) 'limit': limit.toString(),
          if (after != null) 'after': after,
        },
        config: _config,
      ),
      onSuccess: (map) => OpenAIOrgPage.fromMap(map, AdminApiKey.fromMap),
      config: _config,
    );
  }

  Future<AdminApiKey> create({
    required String name,
    String? scope,
  }) async {
    return await OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, _endpoint),
      body: {
        'name': name,
        if (scope != null) 'scope': scope,
      },
      onSuccess: AdminApiKey.fromMap,
      config: _config,
    );
  }

  Future<bool> delete({required String keyId}) async {
    return await OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint, keyId),
      onSuccess: (map) => map['deleted'] as bool? ?? true,
      config: _config,
    );
  }
}
