class OpenAIRunGraderResponseModel {
  final num reward;
  final Map<String, dynamic>? metadata;
  final Map<String, dynamic>? subRewards;
  final Map<String, dynamic>? modelGraderTokenUsagePerModel;

  OpenAIRunGraderResponseModel({
    required this.metadata,
    required this.reward,
    required this.modelGraderTokenUsagePerModel,
    required this.subRewards,
  });
}
