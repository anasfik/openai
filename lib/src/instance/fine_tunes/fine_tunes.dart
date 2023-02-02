import 'package:openai/src/core/builder/base_api_url.dart';
import 'package:openai/src/core/models/fine_tune/fine_tune.dart';
import 'package:openai/src/core/models/fine_tune/sub_models/event.dart';
import 'package:openai/src/core/networking/client.dart';
import 'package:openai/src/instance/model/model.dart';
import 'package:openai/src/instance/openai.dart';

import '../../core/base/fine_tunes/base.dart';

class OpenAIFineTunes implements OpenAIFineTunesBase {
  @override
  String get endpoint => "/fine-tunes";

  /// This function creates a fine-tune job.
  /// Example:
  /// ```dart
  /// OpenAIFineTuneModel fineTune = await OpenAI.instance.fineTune.create(
  ///  trainingFile: "FILE ID",
  /// );
  /// ```
  @override
  Future<OpenAIFineTuneModel> create({
    required String trainingFile,
    String? validationFile,
    String? model,
    int? nEpoches,
    int? batchSize,
    double? learningRateMultiplier,
    double? promptLossWeight,
    bool? computeClassificationMetrics,
    int? classificationNClass,
    int? classificationPositiveClass,
    int? classificationBetas,
    String? suffix,
  }) async {
    return await OpenAINetworkingClient.post(
      body: {
        "training_file": trainingFile,
        if (validationFile != null) "validation_file": validationFile,
        if (model != null) "model": model,
        if (nEpoches != null) "n_epochs": nEpoches,
        if (batchSize != null) "batch_size": batchSize,
        if (learningRateMultiplier != null)
          "learning_rate_multiplier": learningRateMultiplier,
        if (promptLossWeight != null) "prompt_loss_weight": promptLossWeight,
        if (computeClassificationMetrics != null)
          "compute_classification_metrics": computeClassificationMetrics,
        if (classificationNClass != null)
          "classification_n_class": classificationNClass,
        if (classificationPositiveClass != null)
          "classification_positive_class": classificationPositiveClass,
        if (classificationBetas != null)
          "classification_betas": classificationBetas,
        if (suffix != null) "suffix": suffix,
      },
      to: BaseApiUrlBuilder.build(endpoint),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIFineTuneModel.fromJson(response);
      },
    );
  }

  /// This function lists all fine-tune jobs.
  /// Example:
  /// ```dart
  /// List<OpenAIFineTuneModel> fineTunes = await OpenAI.instance.fineTune.list();
  /// ```
  @override
  Future<List> list() async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.build(endpoint),
      onSuccess: (Map<String, dynamic> response) {
        final dataList = response['data'] as List;
        return dataList.map((e) => OpenAIFineTuneModel.fromJson(e)).toList();
      },
    );
  }

  /// This function cancels a fine-tune job by its id.
  /// Example:
  /// ```dart
  ///  OpenAIFineTuneModel fineTune = await OpenAI.instance.fineTune.cancel("FINE TUNE ID");
  /// ```
  @override
  Future<OpenAIFineTuneModel> cancel(String fineTuneId) async {
    final String fineTuneCancelEndpoint = "$endpoint/$fineTuneId/cancel";

    return await OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.build(fineTuneCancelEndpoint),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIFineTuneModel.fromJson(response);
      },
    );
  }

  /// This function retrieves a fine-tune job by its id.
  /// Example:
  /// ```dart
  ///  bool deleted = await OpenAI.instance.fineTune.delete("FINE TUNE ID");
  /// ```
  @override
  Future<bool> delete(String fineTuneId) async {
    return await OpenAIModel().delete(fineTuneId);
  }

  /// This function lists all events of a fine-tune job by its id.
  /// Example:
  /// ```dart
  /// List<OpenAIFineTuneEventModel> events = await OpenAI.instance.fineTune.listEvents("FINE TUNE ID");
  /// ```
  @override
  Future<List<OpenAIFineTuneEventModel>> listEvents(String fineTuneId) async {
    final String fineTuneEvents = "$endpoint/$fineTuneId/events";

    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.build(fineTuneEvents),
      onSuccess: (Map<String, dynamic> response) {
        final List events = response['data'] as List;
        return events.map((e) => OpenAIFineTuneEventModel.fromJson(e)).toList();
      },
    );
  }

  /// This function retrieves a fine-tune job by its id.
  /// Example:
  /// ```dart
  /// OpenAIFineTuneModel fineTune = await OpenAI.instance.fineTune.retrieve("FINE TUNE ID");
  /// ```
  @override
  Future retrieve(String fineTuneId) async {
    final String fineTuneRetrieve = "$endpoint/$fineTuneId";

    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.build(fineTuneRetrieve),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIFineTuneModel.fromJson(response);
      },
    );
  }
}
