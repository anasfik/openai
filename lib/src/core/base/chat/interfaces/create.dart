import '../../../models/edit/edit.dart';

abstract class CreateInterface {
  Future create({
    required String model,
    required List messages,
    double? temperature,
    double? topP,
    int? n,
    dynamic stop,
    int? maxTokens,
    double? presencePenalty,
    double? frequencyPenalty,
    Map<String, dynamic>? logitBias,
    String? user,
  });
}
