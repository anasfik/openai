import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

Future<void> main() async {
  OpenAI.apiKey = Env.apiKey;
  OpenAI.showResponsesLogs = true;

  final function = OpenAIFunctionModel.withParameters(
    name: "getCurrentWeather",
    description: "Get the current weather in a given location",
    parameters: [
      OpenAIFunctionProperty.string(
        name: "location",
        description: 'The city and state, e.g. San Francisco, CA',
        isRequired: true,
      ),
      OpenAIFunctionProperty.string(
        name: "unit",
        description: 'The unit of temperature to return',
        enumValues: ["celsius", "fahrenheit"],
      ),
    ],
  );

  final userMsg = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "What’s the weather like in Boston right now?",
      ),
    ],
    role: OpenAIChatMessageRole.user,
  );

  final chatRes1 = await OpenAI.instance.chat.create(
    model: "gpt-3.5-turbo-0613",
    messages: [userMsg],
    tools: [
      OpenAIToolModel(type: "function", function: function),
    ],
  );

  final assistantMsg1 = chatRes1.choices.first.message;
  final toolCalls = assistantMsg1.toolCalls;

  if (toolCalls == null ||
      toolCalls.isEmpty ||
      toolCalls.first.function.name != "getCurrentWeather") {
    print(assistantMsg1.content);
    return;
  }

  final funcCall = toolCalls.first.function;

  final weather = getCurrentWeather(
    location: jsonDecode(funcCall.arguments)?["location"],
    unit: jsonDecode(funcCall.arguments)?["unit"],
  );

  final toolMsg = OpenAIChatCompletionChoiceMessageModel(
    toolCalls: [toolCalls.first],
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        weather.toMap().toString(),
      ),
    ],
    role: OpenAIChatMessageRole.tool,
  );

  final chatRes2 = await OpenAI.instance.chat.create(
    model: "gpt-3.5-turbo-0613",
    messages: [
      userMsg,
      assistantMsg1,
      toolMsg.asRequestFunctionMessage(toolCallId: toolCalls.first.id!),
    ],
    tools: [
      OpenAIToolModel(type: "function", function: function),
    ],
  );

  final assistantMsg2 = chatRes2.choices.first.message;

  print(assistantMsg2.content);
  // The weather in Boston right now is sunny with a temperature of 22 degrees Celsius.
}

Weather getCurrentWeather({
  required String location,
  String? unit = "celsius",
}) {
  return Weather(
    temperature: 22,
    unit: unit ?? "celsius",
    description: "Sunny",
  );
}

class Weather {
  final int temperature;
  final String unit;
  final String description;

  const Weather({
    required this.temperature,
    required this.unit,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'temperature': temperature,
      'unit': unit,
      'description': description,
    };
  }
}
