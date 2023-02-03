import 'package:collection/collection.dart';
import 'sub_models/event.dart';
import 'sub_models/hyper_params.dart';
import 'sub_models/training_files.dart';

export 'sub_models/event.dart';
export 'sub_models/hyper_params.dart';
export 'sub_models/training_files.dart';

class OpenAIFineTuneModel {
  final String id;
  final String model;
  final DateTime createdAt;
  final List<OpenAIFineTuneEventModel>? events;
  final String? fineTunedModel;
  final OpenAiFineTuneHyperParamsModel? hyperparams;
  final String? organizationId;
  final List<String> resultFiles;
  final String status;
  final List<String>? validationFiles;
  final List<OpenAiFineTuneTrainingFilesModel?> trainingFiles;
  final DateTime? updatedAt;

  OpenAIFineTuneModel({
    required this.id,
    required this.model,
    required this.createdAt,
    required this.events,
    required this.fineTunedModel,
    required this.hyperparams,
    required this.organizationId,
    required this.resultFiles,
    required this.status,
    required this.validationFiles,
    required this.trainingFiles,
    required this.updatedAt,
  });

  factory OpenAIFineTuneModel.fromJson(Map<String, dynamic> json) {
    return OpenAIFineTuneModel(
      id: json['id'],
      model: json['model'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] * 1000),
      events: (json['events'] as List?)
          ?.map((e) => OpenAIFineTuneEventModel.fromJson(e))
          .toList(),
      fineTunedModel: json['fine_tuned_model'],
      hyperparams: OpenAiFineTuneHyperParamsModel.fromJson(json['hyperparams']),
      organizationId: json['organization_id'],
      resultFiles:
          (json['result_files'] as List).map((e) => e.toString()).toList(),
      status: json['status'],
      validationFiles:
          (json['validation_files'] as List).map((e) => e.toString()).toList(),
      trainingFiles: (json['training_files'] as List)
          .map((e) => OpenAiFineTuneTrainingFilesModel.fromJson(e))
          .toList(),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updated_at'] * 1000),
    );
  }

  @override
  String toString() {
    return 'OpenAIFineTuneModel(id: $id, model: $model, createdAt: $createdAt, events: $events, fineTunedModel: $fineTunedModel, hyperparams: $hyperparams, organizationId: $organizationId, resultFiles: $resultFiles, status: $status, validationFiles: $validationFiles, trainingFiles: $trainingFiles, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant OpenAIFineTuneModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.model == model &&
        other.createdAt == createdAt &&
        listEquals(other.events, events) &&
        other.fineTunedModel == fineTunedModel &&
        other.hyperparams == hyperparams &&
        other.organizationId == organizationId &&
        listEquals(other.resultFiles, resultFiles) &&
        other.status == status &&
        listEquals(other.validationFiles, validationFiles) &&
        listEquals(other.trainingFiles, trainingFiles) &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        model.hashCode ^
        createdAt.hashCode ^
        events.hashCode ^
        fineTunedModel.hashCode ^
        hyperparams.hashCode ^
        organizationId.hashCode ^
        resultFiles.hashCode ^
        status.hashCode ^
        validationFiles.hashCode ^
        trainingFiles.hashCode ^
        updatedAt.hashCode;
  }
}
