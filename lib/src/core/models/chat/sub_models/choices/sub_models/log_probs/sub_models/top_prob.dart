import 'content.dart';

class OpenAIChatCompletionChoiceTopLogProbsContentModel
    extends OpenAIChatCompletionChoiceLogProbsContentModel {
  OpenAIChatCompletionChoiceTopLogProbsContentModel({
    super.token,
    super.logprob,
    super.bytes,
  });

  factory OpenAIChatCompletionChoiceTopLogProbsContentModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return OpenAIChatCompletionChoiceTopLogProbsContentModel(
      token: map['token'],
      logprob: map['logprob'],
      bytes: List<int>.from(map['bytes']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'logprob': logprob,
      'bytes': bytes,
    };
  }
}
