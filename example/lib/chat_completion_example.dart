import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

void main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  final systemMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "return any message you are given as JSON.",
      ),
    ],
    role: OpenAIChatMessageRole.assistant,
  );

  final userMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "Hello, I am a chatbot created by OpenAI. How are you today?",
      ),

      //! image url contents are allowed only for models with image support
      // OpenAIChatCompletionChoiceMessageContentItemModel.imageUrl(
      //   "https://placehold.co/600x400",
      // ),
    ],
    role: OpenAIChatMessageRole.user,
    name: "anas",
  );

  final requestMessages = [
    systemMessage,
    userMessage,
  ];

  OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
    model: "gpt-3.5-turbo-1106",
    responseFormat: {"type": "json_object"},
    seed: 6,
    messages: requestMessages,
    temperature: 0.2,
    maxTokens: 500,

    // uncomment and set your own properties if you want to use tool choices feature..

    // toolChoice: "auto",
    // tools: [],
  );

  print(chatCompletion.choices.first.message); //
  print(chatCompletion.systemFingerprint); //
  print(chatCompletion.usage.promptTokens); //
  print(chatCompletion.id); //
}
