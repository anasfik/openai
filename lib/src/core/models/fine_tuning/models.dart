/// Models for the /fine_tuning API.
library;

class OpenAIFineTuningJob {
  final String id;
  final String object;
  final String model;
  final int createdAt;
  final String? finishedAt;
  final String? fineTunedModel;
  final String organizationId;
  final List<String> resultFiles;
  final String status;
  final Map<String, dynamic> hyperparameters;
  final String trainingFile;
  final String? validationFile;
  final dynamic error;

  OpenAIFineTuningJob({
    required this.id,
    required this.model,
    required this.createdAt,
    required this.organizationId,
    required this.resultFiles,
    required this.status,
    required this.trainingFile,
    required this.hyperparameters,
    this.object = 'fine_tuning.job',
    this.finishedAt,
    this.fineTunedModel,
    this.validationFile,
    this.error,
  });

  factory OpenAIFineTuningJob.fromMap(Map<String, dynamic> map) {
    return OpenAIFineTuningJob(
      id: map['id']?.toString() ??  '',
      object: map['object']?.toString() ??  'fine_tuning.job',
      model: map['model']?.toString() ??  '',
      createdAt: map['created_at'] as int? ?? 0,
      finishedAt: map['finished_at']?.toString(),
      fineTunedModel: map['fine_tuned_model'] as String?,
      organizationId: map['organization_id']?.toString() ??  '',
      resultFiles: (map['result_files'] as List<dynamic>? ?? [])
          .map((e) => e is Map ? (e['id']?.toString() ?? '') : e.toString())
          .toList(),
      status: map['status']?.toString() ??  '',
      hyperparameters: map['hyperparameters'] as Map<String, dynamic>? ?? {},
      trainingFile: map['training_file'] is Map
          ? ((map['training_file'] as Map)['id']?.toString() ?? '')
          : map['training_file']?.toString() ??  '',
      validationFile: map['validation_file'] is Map
          ? (map['validation_file'] as Map)['id']?.toString()
          : map['validation_file'] as String?,
      error: map['error'],
    );
  }
}

class OpenAIFineTuningJobList {
  final List<OpenAIFineTuningJob> data;
  final bool hasMore;

  OpenAIFineTuningJobList({required this.data, required this.hasMore});

  factory OpenAIFineTuningJobList.fromMap(Map<String, dynamic> map) {
    return OpenAIFineTuningJobList(
      data: (map['data'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(OpenAIFineTuningJob.fromMap)
          .toList(),
      hasMore: map['has_more'] as bool? ?? false,
    );
  }
}

class OpenAIFineTuningEvent {
  final String id;
  final int createdAt;
  final String level;
  final String message;
  final String object;

  OpenAIFineTuningEvent({
    required this.id,
    required this.createdAt,
    required this.level,
    required this.message,
    this.object = 'fine_tuning.job.event',
  });

  factory OpenAIFineTuningEvent.fromMap(Map<String, dynamic> map) {
    return OpenAIFineTuningEvent(
      id: map['id']?.toString() ??  '',
      createdAt: map['created_at'] as int? ?? 0,
      level: map['level']?.toString() ??  'info',
      message: map['message']?.toString() ??  '',
      object: map['object']?.toString() ??  'fine_tuning.job.event',
    );
  }
}

class OpenAIFineTuningCheckpoint {
  final String id;
  final int createdAt;
  final String fineTunedModelCheckpoint;
  final String fineTuningJobId;
  final Map<String, dynamic> metrics;
  final int stepNumber;

  OpenAIFineTuningCheckpoint({
    required this.id,
    required this.createdAt,
    required this.fineTunedModelCheckpoint,
    required this.fineTuningJobId,
    required this.metrics,
    required this.stepNumber,
  });

  factory OpenAIFineTuningCheckpoint.fromMap(Map<String, dynamic> map) {
    return OpenAIFineTuningCheckpoint(
      id: map['id']?.toString() ??  '',
      createdAt: map['created_at'] as int? ?? 0,
      fineTunedModelCheckpoint:
          map['fine_tuned_model_checkpoint']?.toString() ??  '',
      fineTuningJobId: map['fine_tuning_job_id']?.toString() ??  '',
      metrics: map['metrics'] as Map<String, dynamic>? ?? {},
      stepNumber: map['step_number'] as int? ?? 0,
    );
  }
}
