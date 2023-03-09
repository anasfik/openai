import 'package:meta/meta.dart';

@immutable
class OpenAiFineTuneHyperParamsModel {
  /// The batch size used for fine-tuning.
  final int? batchSize;

  /// The learning rate multiplier used for fine-tuning.
  final double? learningRateMultiplier;

  /// The number of epochs used for fine-tuning.
  final int? nEpochs;

  /// The prompt loss weight used for fine-tuning.
  final double? promptLossWeight;

  @override
  int get hashCode {
    return batchSize.hashCode ^
        learningRateMultiplier.hashCode ^
        nEpochs.hashCode ^
        promptLossWeight.hashCode;
  }

  /// This class is used to represent the hyper-parameters used for fine-tuning.
  const OpenAiFineTuneHyperParamsModel({
    required this.batchSize,
    required this.learningRateMultiplier,
    required this.nEpochs,
    required this.promptLossWeight,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAiFineTuneHyperParamsModel] object.
  factory OpenAiFineTuneHyperParamsModel.fromMap(Map<String, dynamic> json) {
    return OpenAiFineTuneHyperParamsModel(
      batchSize: json['batch_size'],
      learningRateMultiplier: json['learning_rate_multiplier'],
      nEpochs: json['n_epochs'],
      promptLossWeight: json['prompt_loss_weight'],
    );
  }

  @override
  String toString() {
    return 'OpenAiFineTuneHyperParamsModel(batchSize: $batchSize, learningRateMultiplier: $learningRateMultiplier, nEpochs: $nEpochs, promptLossWeight: $promptLossWeight)';
  }

  @override
  bool operator ==(covariant OpenAiFineTuneHyperParamsModel other) {
    if (identical(this, other)) return true;

    return other.batchSize == batchSize &&
        other.learningRateMultiplier == learningRateMultiplier &&
        other.nEpochs == nEpochs &&
        other.promptLossWeight == promptLossWeight;
  }
}
