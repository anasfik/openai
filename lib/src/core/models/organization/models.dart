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
