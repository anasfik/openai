import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;

  // The function to be called by the tool.
  void sumNumbers(int number1, int number2) {
    print("Your sum answer is ${number1 + number2}");
  }

  // The tool object that wilm be sent to the API.
  final sumNumbersTool = OpenAIToolModel(
    type: "function",
    function: OpenAIFunctionModel.withParameters(
      name: "sumOfTwoNumbers",
      parameters: [
        OpenAIFunctionProperty.integer(
          name: "number1",
          description: "The first number to add",
        ),
        OpenAIFunctionProperty.integer(
          name: "number2",
          description: "The second number to add",
        ),
      ],
    ),
  );

  // The user text message that will be sent to the API.
  final userMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "What is the sum of 9996 and 3?",
      ),
    ],
    role: OpenAIChatMessageRole.user,
  );

  // The actual call.
  final chat = await OpenAI.instance.chat.create(
    model: "gpt-3.5-turbo",
    messages: [userMessage],
    tools: [sumNumbersTool],
  );

// ! This handling is only for showcase and not completed as edge cases will not be handled that you should handle in your app.

  final message = chat.choices.first.message;

// Wether the message has a tool call.
  if (message.haveToolCalls) {
    final call = message.toolCalls!.first;

    // Wether the tool call is the one we sent.
    if (call.function.name == "sumOfTwoNumbers") {
      // decode the arguments from the tool call.
      final decodedArgs = jsonDecode(call.function.arguments);

      final number1 = decodedArgs["number1"];
      final number2 = decodedArgs["number2"];

      // Call the function with the arguments.
      sumNumbers(number1, number2);
    }
  }
}
