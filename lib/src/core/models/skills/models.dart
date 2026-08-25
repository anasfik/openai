/// Models for the /skills API.
library;

class OpenAISkillModel {
  final String id;
  final String? object;
  final String? name;
  final int? createdAt;
  final String? version;

  OpenAISkillModel({
    required this.id,
    this.object,
    this.name,
    this.createdAt,
    this.version,
  });

  factory OpenAISkillModel.fromMap(Map<String, dynamic> map) {
    return OpenAISkillModel(
      id: map['id'] as String? ?? '',
      object: map['object'] as String?,
      name: map['name'] as String?,
      createdAt: map['created_at'] as int?,
      version: map['version']?.toString(),
    );
  }
}

class OpenAISkillList {
  final List<OpenAISkillModel> data;
  final bool hasMore;

  OpenAISkillList({required this.data, required this.hasMore});

  factory OpenAISkillList.fromMap(Map<String, dynamic> map) {
    return OpenAISkillList(
      data: (map['data'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(OpenAISkillModel.fromMap)
          .toList(),
      hasMore: map['has_more'] as bool? ?? false,
    );
  }
}
