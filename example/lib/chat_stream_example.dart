import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;

  final chatStream = OpenAI.instance.chat.createStream(
    model: "gpt-3.5-turbfqfqo",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            "Hello, can you say: 'You are Anas'",
          ),
        ],
        role: OpenAIChatMessageRole.user,
      ),
      OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            "You are Anas",
          ),
        ],
        role: OpenAIChatMessageRole.assistant,
      ),
      OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            "Now I want you to repeat it, but change the word 'Anas' to 'Mohamed'",
          ),
        ],
        role: OpenAIChatMessageRole.user,
      ),
    ],
  );

  chatStream.listen(
    (event) {
      print(event.choices.first.delta.content);
    },
    onError: (e) {
      print("Error, $e");
    },
    onDone: () {
      print("Done");
    },
  );
}
