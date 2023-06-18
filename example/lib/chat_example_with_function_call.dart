import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

Future<void> main() async {
  OpenAI.apiKey = Env.apiKey;

  final chatRes = await OpenAI.instance.chat.create(
    model: "gpt-3.5-turbo-0613",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        content:
            "send an email with a message asking about weather in Marrakech",
        role: OpenAIChatMessageRole.user,
      ),
    ],
    functions: [
      OpenAIFunctionModel(
        name: "sendEmail",
        description: "sends an email with the given message",
        parameters: OpenAIFunctionParameters.fromProperties(
          [
            OpenAIFunctionProperty(
              name: "message",
              type: 'string',
            ),
          ],
        ),
      ),
    ],
  );

  final funcCall = chatRes.choices.first.message.functionCall;

  if (funcCall != null && funcCall.name == "sendEmail") {
    final message = funcCall.arguments?["message"];
    sendEmail(message);
  }
}

void sendEmail(String message) {
  print("message: $message... is sent successfully.");
}
