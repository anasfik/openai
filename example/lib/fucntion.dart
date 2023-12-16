import 'dart:async';
import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';

Future<void> main() async {
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

  final chatRes1 = OpenAI.instance.chat.createStream(
    model: "gpt-3.5-turbo-0613",
    messages: [userMsg],
    functions: [function],
  );

  print("(((((((((((((((((((((((((((object)))))))))))))))))))))))))))");

  Stream<int> stream = Stream.fromIterable([1, 2, 3, 4, 5]);
  int? firstElement = await stream.first;
  print('First Element: $firstElement');
  StreamSubscription<int> subscription = stream.listen((int element) {
    print('Received element: $element');
  });

  await subscription.asFuture();

  await checkStreamMessage(streamResponse: chatRes1);
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

checkStreamMessage(
    {required Stream<OpenAIStreamChatCompletionModel> streamResponse}) async {
  Stream<OpenAIStreamChatCompletionModel> stream =
      streamResponse.asBroadcastStream();
  OpenAIStreamChatCompletionModel? first = await stream.first;
  OpenAIStreamChatCompletionChoiceDeltaModel delta = first.choices.first.delta;
  StreamFunctionCallResponse? funcCall = delta.functionCall;

  if (funcCall == null) {
    final StreamSubscription<OpenAIStreamChatCompletionModel> subscription =
        stream.listen((event) {
      print(event.choices.first.delta.content);
    });
    await subscription.asFuture();
  } else {
    final functionName = funcCall.name ?? "";
    String argsJson = funcCall.arguments ?? "";

    final StreamSubscription<OpenAIStreamChatCompletionModel> subscription =
        stream.listen((event) {
      final delta = event.choices.first.delta;
      final funcCall = delta.functionCall;
      String arg = funcCall?.arguments ?? "";
      argsJson = argsJson + arg;
    });

    await subscription.asFuture();

    Map<String, dynamic> arguments;

    try {
      arguments = jsonDecode(argsJson);
    } catch (e) {
      arguments = {};
    }
    print("$functionName:$argsJson:::::$arguments");

    Map<String, dynamic> functionResponse =
        streamCallFunction(functionName, arguments);

    final functionCallMessage = OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.assistant,
      functionCall: FunctionCallResponse.fromMap(
          {"name": functionName, "arguments": argsJson}),
      content: '',
    );

    final functionResponseMsg = OpenAIChatCompletionChoiceMessageModel(
      functionName: functionName,
      content: json.encode(functionResponse),
      role: OpenAIChatMessageRole.function,
    );

    final realUserStream = OpenAI.instance.chat.createStream(
      model: "gpt-3.5-turbo-0613",
      messages: [
        functionCallMessage,
        functionResponseMsg,
      ],
    );
    await checkStreamMessage(streamResponse: realUserStream);
  }
}

Map<String, dynamic> streamCallFunction(
    String functionName, Map<String, dynamic> arguments) {
  if (functionName == "getCurrentWeather") {
    final weather = getCurrentWeather(
      location: arguments["location"],
      unit: arguments["unit"],
    );
    return weather.toMap();
  } else {
    return {};
  }
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
