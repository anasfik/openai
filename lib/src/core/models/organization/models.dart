/// Models for the /organization API.
library;

class OpenAIOrgPage<T> {
  final List<T> data;
  final bool hasMore;
  final String? firstId;
  final String? lastId;

  OpenAIOrgPage({
    required this.data,
    required this.hasMore,
    this.firstId,
    this.lastId,
  });

  factory OpenAIOrgPage.fromMap(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) convert,
  ) {
    return OpenAIOrgPage<T>(
      data: (map['data'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(convert)
          .toList(),
      hasMore: map['has_more'] as bool? ?? false,
      firstId: map['first_id'] as String?,
      lastId: map['last_id'] as String?,
    );
  }
}

class OrgProject {
  final String id;
  final String name;
  final String status;
  final int createdAt;

  OrgProject({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
  });

  factory OrgProject.fromMap(Map<String, dynamic> map) {
    return OrgProject(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      status: map['status'] as String? ?? '',
      createdAt: map['created_at'] as int? ?? 0,
    );
  }
}

class OrgUser {
  final String id;
  final String name;
  final String email;
  final String role;
  final int addedAt;

  OrgUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.addedAt,
  });

  factory OrgUser.fromMap(Map<String, dynamic> map) {
    return OrgUser(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      role: map['role'] as String? ?? '',
      addedAt: map['added_at'] as int? ?? 0,
    );
  }
}

class OrgInvite {
  final String id;
  final String email;
  final String role;
  final String status;
  final int createdAt;

  OrgInvite({
    required this.id,
    required this.email,
    required this.role,
    required this.status,
    required this.createdAt,
  });

  factory OrgInvite.fromMap(Map<String, dynamic> map) {
    return OrgInvite(
      id: map['id'] as String? ?? '',
      email: map['email'] as String? ?? '',
      role: map['role'] as String? ?? '',
      status: map['status'] as String? ?? '',
      createdAt: map['created_at'] as int? ?? 0,
    );
  }
}

class AuditLogEntry {
  final String id;
  final String type;
  final int effectiveAt;
  final Map<String, dynamic> actor;
  final Map<String, dynamic> resource;

  AuditLogEntry({
    required this.id,
    required this.type,
    required this.effectiveAt,
    required this.actor,
    required this.resource,
  });

  factory AuditLogEntry.fromMap(Map<String, dynamic> map) {
    return AuditLogEntry(
      id: map['id'] as String? ?? '',
      type: map['type'] as String? ?? '',
      effectiveAt: map['effective_at'] as int? ?? 0,
      actor: map['actor'] as Map<String, dynamic>? ?? {},
      resource: map['resource'] as Map<String, dynamic>? ?? {},
    );
  }
}

class CostBucket {
  final int startTime;
  final int endTime;
  final Map<String, dynamic> result;

  CostBucket({
    required this.startTime,
    required this.endTime,
    required this.result,
  });

  factory CostBucket.fromMap(Map<String, dynamic> map) {
    return CostBucket(
      startTime: map['start_time'] as int? ?? 0,
      endTime: map['end_time'] as int? ?? 0,
      result: map['result'] as Map<String, dynamic>? ?? {},
    );
  }
}

class RateLimit {
  final String id;
  final String model;
  final Map<String, dynamic> bucket;

  RateLimit({
    required this.id,
    required this.model,
    required this.bucket,
  });

  factory RateLimit.fromMap(Map<String, dynamic> map) {
    return RateLimit(
      id: map['id'] as String? ?? '',
      model: map['model'] as String? ?? '',
      bucket: map['bucket'] as Map<String, dynamic>? ?? {},
    );
  }
}

class AdminApiKey {
  final String id;
  final String name;
  final String scope;
  final String? value;
  final int createdAt;

  AdminApiKey({
    required this.id,
    required this.name,
    required this.scope,
    required this.createdAt,
    this.value,
  });

  factory AdminApiKey.fromMap(Map<String, dynamic> map) {
    return AdminApiKey(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      scope: map['scope'] as String? ?? '',
      value: map['value'] as String?,
      createdAt: map['created_at'] as int? ?? 0,
    );
  }
}

class OrgSpendLimit {
  final String id;
  final double? hardLimitUsd;
  final double? softLimitUsd;

  OrgSpendLimit({
    required this.id,
    this.hardLimitUsd,
    this.softLimitUsd,
  });

  factory OrgSpendLimit.fromMap(Map<String, dynamic> map) {
    return OrgSpendLimit(
      id: map['id'] as String? ?? '',
      hardLimitUsd: (map['hard_limit_usd'] as num?)?.toDouble(),
      softLimitUsd: (map['soft_limit_usd'] as num?)?.toDouble(),
    );
  }
}

class OrgSpendAlert {
  final String id;
  final String? projectId;
  final String? teamId;
  final double? thresholdUsd;

  OrgSpendAlert({
    required this.id,
    this.projectId,
    this.teamId,
    this.thresholdUsd,
  });

  factory OrgSpendAlert.fromMap(Map<String, dynamic> map) {
    return OrgSpendAlert(
      id: map['id'] as String? ?? '',
      projectId: map['project_id'] as String?,
      teamId: map['team_id'] as String?,
      thresholdUsd: (map['threshold_usd'] as num?)?.toDouble(),
    );
  }
}

class OrgGroup {
  final String id;
  final String name;
  final String? description;

  OrgGroup({
    required this.id,
    required this.name,
    this.description,
  });

  factory OrgGroup.fromMap(Map<String, dynamic> map) {
    return OrgGroup(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      description: map['description'] as String?,
    );
  }
}

class OrgServiceAccount {
  final String id;
  final String name;
  final String role;
  final Map<String, dynamic> apiKey;

  OrgServiceAccount({
    required this.id,
    required this.name,
    required this.role,
    required this.apiKey,
  });

  factory OrgServiceAccount.fromMap(Map<String, dynamic> map) {
    return OrgServiceAccount(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      role: map['role'] as String? ?? '',
      apiKey: map['api_key'] as Map<String, dynamic>? ?? {},
    );
  }
}

class DataRetentionConfig {
  final String id;
  final int retentionWindowDays;

  DataRetentionConfig({
    required this.id,
    required this.retentionWindowDays,
  });

  factory DataRetentionConfig.fromMap(Map<String, dynamic> map) {
    return DataRetentionConfig(
      id: map['id'] as String? ?? '',
      retentionWindowDays: (map['retention_window_days'] as num?)?.toInt() ?? 0,
    );
  }
}

class OrgRole {
  final String id;
  final String name;

  OrgRole({
    required this.id,
    required this.name,
  });

  factory OrgRole.fromMap(Map<String, dynamic> map) {
    return OrgRole(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
    );
  }
}
