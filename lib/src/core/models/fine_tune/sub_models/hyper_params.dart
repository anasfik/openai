class OpenAiFineTuneHyperParamsModel {
  final int? batchSize;
  final double? learningRateMultiplier;
  final int? nEpochs;
  final double? promptLossWeight;

  OpenAiFineTuneHyperParamsModel({
    required this.batchSize,
    required this.learningRateMultiplier,
    required this.nEpochs,
    required this.promptLossWeight,
  });

  factory OpenAiFineTuneHyperParamsModel.fromJson(Map<String, dynamic> json) {
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

  @override
  int get hashCode {
    return batchSize.hashCode ^
        learningRateMultiplier.hashCode ^
        nEpochs.hashCode ^
        promptLossWeight.hashCode;
  }
}
