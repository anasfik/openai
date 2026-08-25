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
        adminApiKeys = OpenAIAdminApiKeys(config),
        usage = OpenAIUsage(config),
        spendLimits = OpenAISpendLimits(config),
        certificates = OpenAICertificates(config),
        groups = OpenAIGroups(config),
        serviceAccounts = OpenAIServiceAccounts(config),
        dataRetention = OpenAIDataRetention(config),
        roles = OpenAIRoles(config);

  final OpenAIProjects projects;

  final OpenAIOrgUsers users;

  final OpenAIInvites invites;

  final OpenAIAuditLogs auditLogs;

  final OpenAICosts costs;

  final OpenAIRateLimits rateLimits;

  final OpenAIAdminApiKeys adminApiKeys;

  final OpenAIUsage usage;

  final OpenAISpendLimits spendLimits;

  final OpenAICertificates certificates;

  final OpenAIGroups groups;

  final OpenAIServiceAccounts serviceAccounts;

  final OpenAIDataRetention dataRetention;

  final OpenAIRoles roles;
}

class OpenAIProjects {
  final OpenAIClientConfig? _config;

  OpenAIProjects(this._config);

  String get _endpoint => 'organization/projects';

  Future<OpenAIOrgPage<OrgProject>> list({String? after, int? limit}) async {
    return OpenAINetworkingClient.get(
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
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, _endpoint),
      body: {'name': name},
      onSuccess: OrgProject.fromMap,
      config: _config,
    );
  }

  Future<OrgProject> retrieve({required String projectId}) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint, projectId),
      onSuccess: OrgProject.fromMap,
      config: _config,
    );
  }

  Future<OrgProject> archive({required String projectId}) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/$projectId/archive'),
      onSuccess: OrgProject.fromMap,
      config: _config,
    );
  }

  /// Model permissions for a project. Payload schema is loose; raw map.
  Future<Map<String, dynamic>> modelPermissions({
    required String projectId,
  }) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(
        _config,
        '$_endpoint/$projectId/model_permissions',
      ),
      onSuccess: (map) => map,
      config: _config,
    );
  }

  /// Hosted tool permissions for a project. Payload schema is loose; raw map.
  Future<Map<String, dynamic>> hostedToolPermissions({
    required String projectId,
  }) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(
        _config,
        '$_endpoint/$projectId/hosted_tool_permissions',
      ),
      onSuccess: (map) => map,
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
    return OpenAINetworkingClient.get(
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
    return OpenAINetworkingClient.get(
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
    return OpenAINetworkingClient.get(
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
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, _endpoint),
      body: {'email': email, 'role': role},
      onSuccess: OrgInvite.fromMap,
      config: _config,
    );
  }

  Future<bool> delete({required String inviteId}) async {
    return OpenAINetworkingClient.delete(
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
    return OpenAINetworkingClient.get(
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
    return OpenAINetworkingClient.get(
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
    return OpenAINetworkingClient.get(
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
    return OpenAINetworkingClient.get(
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
    return OpenAINetworkingClient.post(
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
    return OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint, keyId),
      onSuccess: (map) => map['deleted'] as bool? ?? true,
      config: _config,
    );
  }
}

class OpenAIUsage {
  final OpenAIClientConfig? _config;

  OpenAIUsage(this._config);

  /// Usage report buckets for one of: completions, embeddings, moderations,
  /// images, audio_speeches, audio_transcriptions, vector_stores,
  /// code_interpreter_sessions, file_search_calls, web_search_calls.
  Future<List<Map<String, dynamic>>> usage({
    required String kind,
    required int startTime,
    int? endTime,
    int? bucketWidth,
    List<String>? projectIds,
    List<String>? groupBy,
    String? after,
    int? limit,
  }) async {
    // ponytail: project_ids/group_by joined as comma string since
    // buildWithQuery takes Map<String, String>; raw Uri when repeated
    // params are needed.
    return OpenAINetworkingClient.get<List<Map<String, dynamic>>>(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: 'organization/usage/$kind',
        query: {
          'start_time': startTime.toString(),
          if (endTime != null) 'end_time': endTime.toString(),
          if (bucketWidth != null) 'bucket_width': bucketWidth.toString(),
          if (projectIds != null && projectIds.isNotEmpty)
            'project_ids': projectIds.join(','),
          if (groupBy != null && groupBy.isNotEmpty)
            'group_by': groupBy.join(','),
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
        },
        config: _config,
      ),
      onSuccess: (map) => (map['data'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .toList(),
      config: _config,
    );
  }
}

class OpenAISpendLimits {
  final OpenAIClientConfig? _config;

  OpenAISpendLimits(this._config);

  String get _endpoint => 'organization/spend_limit';

  Future<OrgSpendLimit> get() async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint),
      onSuccess: OrgSpendLimit.fromMap,
      config: _config,
    );
  }

  Future<OrgSpendLimit> update({
    double? hardLimitUsd,
    double? softLimitUsd,
  }) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, _endpoint),
      body: {
        if (hardLimitUsd != null) 'hard_limit_usd': hardLimitUsd,
        if (softLimitUsd != null) 'soft_limit_usd': softLimitUsd,
      },
      onSuccess: OrgSpendLimit.fromMap,
      config: _config,
    );
  }

  /// Spend alerts.

  Future<OpenAIOrgPage<OrgSpendAlert>> listAlerts() async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/alerts'),
      onSuccess: (map) => OpenAIOrgPage.fromMap(map, OrgSpendAlert.fromMap),
      config: _config,
    );
  }

  Future<OrgSpendAlert> createAlert({
    required double thresholdUsd,
    String? projectId,
    String? teamId,
  }) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/alerts'),
      body: {
        'threshold_usd': thresholdUsd,
        if (projectId != null) 'project_id': projectId,
        if (teamId != null) 'team_id': teamId,
      },
      onSuccess: OrgSpendAlert.fromMap,
      config: _config,
    );
  }

  Future<bool> deleteAlert({required String alertId}) async {
    return OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/alerts', alertId),
      onSuccess: (map) => map['deleted'] as bool? ?? true,
      config: _config,
    );
  }
}

class OpenAICertificates {
  final OpenAIClientConfig? _config;

  OpenAICertificates(this._config);

  String get _endpoint => 'organization/certificates';

  /// Payload schema is loose; raw page of maps.
  Future<OpenAIOrgPage<Map<String, dynamic>>> list({
    String? after,
    int? limit,
  }) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: _endpoint,
        query: {
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
        },
        config: _config,
      ),
      onSuccess: (map) => OpenAIOrgPage.fromMap(map, (m) => m),
      config: _config,
    );
  }

  Future<Map<String, dynamic>> create({
    required String name,
    required String certificate,
    String? purpose,
  }) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, _endpoint),
      body: {
        'name': name,
        'certificate': certificate,
        if (purpose != null) 'purpose': purpose,
      },
      onSuccess: (map) => map,
      config: _config,
    );
  }

  Future<bool> delete({required String certificateId}) async {
    return OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint, certificateId),
      onSuccess: (map) => map['deleted'] as bool? ?? true,
      config: _config,
    );
  }

  Future<Map<String, dynamic>> activate({required List<String> ids}) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/activate'),
      body: {'certificate_ids': ids},
      onSuccess: (map) => map,
      config: _config,
    );
  }

  Future<Map<String, dynamic>> deactivate({required List<String> ids}) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/deactivate'),
      body: {'certificate_ids': ids},
      onSuccess: (map) => map,
      config: _config,
    );
  }
}

class OpenAIGroups {
  final OpenAIClientConfig? _config;

  OpenAIGroups(this._config);

  String get _endpoint => 'organization/groups';

  Future<OpenAIOrgPage<OrgGroup>> list({String? after, int? limit}) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: _endpoint,
        query: {
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
        },
        config: _config,
      ),
      onSuccess: (map) => OpenAIOrgPage.fromMap(map, OrgGroup.fromMap),
      config: _config,
    );
  }

  Future<OrgGroup> create({
    required String name,
    String? description,
  }) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, _endpoint),
      body: {
        'name': name,
        if (description != null) 'description': description,
      },
      onSuccess: OrgGroup.fromMap,
      config: _config,
    );
  }

  /// Update via POST (no PATCH in the networking layer).
  Future<OrgGroup> update({
    required String groupId,
    String? name,
    String? description,
  }) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, _endpoint, groupId),
      body: {
        if (name != null) 'name': name,
        if (description != null) 'description': description,
      },
      onSuccess: OrgGroup.fromMap,
      config: _config,
    );
  }

  Future<bool> delete({required String groupId}) async {
    return OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint, groupId),
      onSuccess: (map) => map['deleted'] as bool? ?? true,
      config: _config,
    );
  }

  Future<List<Map<String, dynamic>>> listUsers(
      {required String groupId}) async {
    return OpenAINetworkingClient.get<List<Map<String, dynamic>>>(
      from: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/$groupId/users'),
      onSuccess: (map) => (map['data'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .toList(),
      config: _config,
    );
  }

  Future<bool> addUsers({
    required String groupId,
    required List<String> userIds,
  }) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/$groupId/users'),
      body: {'user_ids': userIds},
      onSuccess: (map) => true,
      config: _config,
    );
  }

  Future<bool> removeUser({
    required String groupId,
    required String userId,
  }) async {
    return OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(
          _config, '$_endpoint/$groupId/users', userId),
      onSuccess: (map) => map['deleted'] as bool? ?? true,
      config: _config,
    );
  }

  Future<List<Map<String, dynamic>>> listRoles(
      {required String groupId}) async {
    return OpenAINetworkingClient.get<List<Map<String, dynamic>>>(
      from: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/$groupId/roles'),
      onSuccess: (map) => (map['data'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .toList(),
      config: _config,
    );
  }
}

class OpenAIServiceAccounts {
  final OpenAIClientConfig? _config;

  OpenAIServiceAccounts(this._config);

  String _base(String projectId) =>
      'organization/projects/$projectId/service_accounts';

  Future<OpenAIOrgPage<OrgServiceAccount>> list({
    required String projectId,
    String? after,
    int? limit,
  }) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: _base(projectId),
        query: {
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
        },
        config: _config,
      ),
      onSuccess: (map) => OpenAIOrgPage.fromMap(map, OrgServiceAccount.fromMap),
      config: _config,
    );
  }

  Future<OrgServiceAccount> create({
    required String projectId,
    required String name,
    required String role,
  }) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, _base(projectId)),
      body: {'name': name, 'role': role},
      onSuccess: OrgServiceAccount.fromMap,
      config: _config,
    );
  }

  Future<bool> delete({
    required String projectId,
    required String serviceAccountId,
  }) async {
    return OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(
        _config,
        _base(projectId),
        serviceAccountId,
      ),
      onSuccess: (map) => map['deleted'] as bool? ?? true,
      config: _config,
    );
  }

  Future<bool> deleteApiKey({
    required String projectId,
    required String serviceAccountId,
    required String apiKeyId,
  }) async {
    return OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(
        _config,
        '${_base(projectId)}/$serviceAccountId/api_keys',
        apiKeyId,
      ),
      onSuccess: (map) => map['deleted'] as bool? ?? true,
      config: _config,
    );
  }
}

class OpenAIDataRetention {
  final OpenAIClientConfig? _config;

  OpenAIDataRetention(this._config);

  String get _endpoint => 'organization/data_retention';

  Future<DataRetentionConfig> get() async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint),
      onSuccess: DataRetentionConfig.fromMap,
      config: _config,
    );
  }

  Future<DataRetentionConfig> update({required int retentionWindowDays}) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, _endpoint),
      body: {'retention_window_days': retentionWindowDays},
      onSuccess: DataRetentionConfig.fromMap,
      config: _config,
    );
  }

  Future<DataRetentionConfig> getForProject({
    required String projectId,
  }) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(
        _config,
        'organization/projects/$projectId/data_retention',
      ),
      onSuccess: DataRetentionConfig.fromMap,
      config: _config,
    );
  }

  Future<DataRetentionConfig> updateForProject({
    required String projectId,
    required int retentionWindowDays,
  }) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(
        _config,
        'organization/projects/$projectId/data_retention',
      ),
      body: {'retention_window_days': retentionWindowDays},
      onSuccess: DataRetentionConfig.fromMap,
      config: _config,
    );
  }
}

class OpenAIRoles {
  final OpenAIClientConfig? _config;

  OpenAIRoles(this._config);

  String get _endpoint => 'organization/roles';

  Future<OpenAIOrgPage<OrgRole>> list() async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint),
      onSuccess: (map) => OpenAIOrgPage.fromMap(map, OrgRole.fromMap),
      config: _config,
    );
  }

  Future<OrgRole> retrieve({required String roleId}) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint, roleId),
      onSuccess: OrgRole.fromMap,
      config: _config,
    );
  }
}
