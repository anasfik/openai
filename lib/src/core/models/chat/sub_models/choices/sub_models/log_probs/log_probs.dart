// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'sub_models/content.dart';

class OpenAIChatCompletionChoiceLogProbsModel {
  OpenAIChatCompletionChoiceLogProbsModel({
    required this.content,
  });

  final List<OpenAIChatCompletionChoiceLogProbsContentModel> content;

  factory OpenAIChatCompletionChoiceLogProbsModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAIChatCompletionChoiceLogProbsModel(
      content: json["content"] != null
          ? List<OpenAIChatCompletionChoiceLogProbsContentModel>.from(
              json["content"].map(
                (x) =>
                    OpenAIChatCompletionChoiceLogProbsContentModel.fromMap(x),
              ),
            )
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "content": content.map((x) => x.toMap()).toList(),
    };
  }
}
