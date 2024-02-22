import 'top_prob.dart';

class OpenAIChatCompletionChoiceLogProbsContentModel {
  final String? token;

  final double? logprob;

  final List<int>? bytes;

  final List<OpenAIChatCompletionChoiceTopLogProbsContentModel>? topLogprobs;

  OpenAIChatCompletionChoiceLogProbsContentModel({
    this.token,
    this.logprob,
    this.bytes,
    this.topLogprobs,
  });

  factory OpenAIChatCompletionChoiceLogProbsContentModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return OpenAIChatCompletionChoiceLogProbsContentModel(
      token: map['token'],
      logprob: map['logprob'],
      bytes: List<int>.from(map['bytes']),
      topLogprobs: List<OpenAIChatCompletionChoiceTopLogProbsContentModel>.from(
        map['top_logprobs']?.map(
          (x) => OpenAIChatCompletionChoiceTopLogProbsContentModel.fromMap(x),
        ),
      ),
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
