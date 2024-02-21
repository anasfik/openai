import 'package:meta/meta.dart';

/// {@template openai_fine_tune_hyper_params_model}
/// This class is used to represent the hyper-parameters used for fine-tuning.
/// {@endtemplate}
@immutable
final class OpenAIFineTuneHyperParamsModel {
  /// The batch size used for fine-tuning.
  final int? batchSize;

  /// The learning rate multiplier used for fine-tuning.
  final double? learningRateMultiplier;

  /// The number of epochs used for fine-tuning.
  final int? nEpochs;

  /// The prompt loss weight used for fine-tuning.
  final double? promptLossWeight;

  /// Weither the hyper-parameters have a batch size.
  bool get haveBatchSize => batchSize != null;

  /// Weither the hyper-parameters have a learning rate multiplier.
  bool get haveLearningRateMultiplier => learningRateMultiplier != null;

  /// Weither the hyper-parameters have a number of epochs.
  bool get haveNEpochs => nEpochs != null;

  /// Weither the hyper-parameters have a prompt loss weight.
  bool get havePromptLossWeight => promptLossWeight != null;

  @override
  int get hashCode {
    return batchSize.hashCode ^
        learningRateMultiplier.hashCode ^
        nEpochs.hashCode ^
        promptLossWeight.hashCode;
  }

  /// {@macro openai_fine_tune_hyper_params_model}
  const OpenAIFineTuneHyperParamsModel({
    required this.batchSize,
    required this.learningRateMultiplier,
    required this.nEpochs,
    required this.promptLossWeight,
  });

  /// {@template openai_fine_tune_hyper_params_model_fromMap}
  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIFineTuneHyperParamsModel] object.
  /// {@endtemplate}
  factory OpenAIFineTuneHyperParamsModel.fromMap(Map<String, dynamic> json) {
    return OpenAIFineTuneHyperParamsModel(
      batchSize: json['batch_size'],
      learningRateMultiplier: json['learning_rate_multiplier'],
      nEpochs: json['n_epochs'],
      promptLossWeight: json['prompt_loss_weight'],
    );
  }

  @override
  String toString() {
    return 'OpenAIFineTuneHyperParamsModel(batchSize: $batchSize, learningRateMultiplier: $learningRateMultiplier, nEpochs: $nEpochs, promptLossWeight: $promptLossWeight)';
  }

  @override
  bool operator ==(covariant OpenAIFineTuneHyperParamsModel other) {
    if (identical(this, other)) return true;

    return other.batchSize == batchSize &&
        other.learningRateMultiplier == learningRateMultiplier &&
        other.nEpochs == nEpochs &&
        other.promptLossWeight == promptLossWeight;
  }
}
