import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;

  final chatStream = OpenAI.instance.chat.createStream(
    model: "gpt-3.5-turbo",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            "What is the fastest car in the world as of 2023?",
          ),
        ],
        role: OpenAIChatMessageRole.user,
      ),
    ],
    tools: [
      OpenAIToolModel(
        type: "function",
        function: OpenAIFunctionModel.withParameters(
          name: "fastestCarInTheWorldInTheYear",
          parameters: [
            OpenAIFunctionProperty.integer(
              name: "year",
              description: "The year to get the fastest car in the world for.",
            ),
          ],
        ),
      ),
    ],
  );

  final functionNameMapper = <String, dynamic>{};

  final stringBuf = StringBuffer();

  chatStream.listen((event) {
    final function = event.choices.first.delta.toolCalls?.first.function;

    final name = function?.name;
    functionNameMapper[name ?? ""] = name;
    final args = function?.arguments;

    if (args != null) {
      stringBuf.write(args);
    }
  }, onDone: () {
    if (functionNameMapper.containsKey("fastestCarInTheWorldInTheYear")) {
      final fullResponse = stringBuf.toString();

      print(fullResponse);

      if (isJSONDecoded(fullResponse)) {
        final decode = jsonDecode(fullResponse) as Map<String, dynamic>;
        final yearParam = decode['year'] as int;

        fastestCarInTheWorldInTheYear(yearParam);
      } else {
        // just saying, in case you need to handl normal responses.
        print("Response can not be decoded, it is not valid JSON");
      }
    } else {
      print("there is functioning calling but not ours");
    }
  });
}

bool isJSONDecoded(String source) {
  try {
    jsonDecode(source);
    return true;
  } catch (e) {
    return false;
  }
}

void fastestCarInTheWorldInTheYear(int year) {
  print(
    "[Mock Handling]: The fastest car in the world in $year is the Bugatti Chiron Super Sport 300+",
  );
}
