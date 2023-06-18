import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

Future<void> main() async {
  OpenAI.apiKey = Env.apiKey;

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
    content: "What’s the weather like in Boston right now?",
    role: OpenAIChatMessageRole.user,
  );

  final chatRes1 = await OpenAI.instance.chat.create(
    model: "gpt-3.5-turbo-0613",
    messages: [userMsg],
    functions: [function],
  );

  final assistantMsg1 = chatRes1.choices.first.message;
  final funcCall = assistantMsg1.functionCall;

  if (funcCall == null || funcCall.name != "getCurrentWeather") {
    print(assistantMsg1.content);
    return;
  }

  final weather = getCurrentWeather(
    location: funcCall.arguments?["location"],
    unit: funcCall.arguments?["unit"],
  );

  final functionMsg = OpenAIChatCompletionChoiceMessageModel(
    functionName: function.name,
    content: json.encode(weather.toMap()),
    role: OpenAIChatMessageRole.function,
  );

  final chatRes2 = await OpenAI.instance.chat.create(
    model: "gpt-3.5-turbo-0613",
    messages: [
      userMsg,
      assistantMsg1,
      functionMsg,
    ],
    functions: [function],
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
