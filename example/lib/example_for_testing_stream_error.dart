import 'dart:async';

import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

// This example is for testing the stream error, as example, cut the internet connection and run this example.

void main() {
  // we set the api key
  OpenAI.apiKey = Env.apiKey;

  // we create the custom stream.
  final stream = itemBodyCompletionStream(
    "What is the best makeup brand?",
    "Name 10 mackeup products",
    "You're a makeup artist",
  );

  // we listen
  stream.listen((event) {
    print(event.body);
  }, onError: (e) {
    // if there is some error, it will be catched here.
    print(e);
  }, onDone: () {
    print("done");
  });
}

Stream<ItemBodyCompletion> itemBodyCompletionStream(
  String system,
  String user,
  String assistant,
) {
  final bodyCompletion = OpenAI.instance.chat.createStream(
    model: "gpt-3.5-turbo",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.system,
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(system),
        ],
      ),
      OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.user,
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(user),
        ],
      ),
      OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.assistant,
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(assistant),
        ],
      ),
    ],
  );
  final stream = StreamController<ItemBodyCompletion>();

  bodyCompletion.listen((event) {
    final content = event.choices[0].delta.content;

    return content != null && content.first?.text != null
        ? stream.add(ItemBodyCompletion(body: content.first!.text!))
        : () {};
  }, onDone: () {
    stream.close();
  }, onError: (e) {
    stream.addError(e);
  });
  return stream.stream;
}

class ItemBodyCompletion {
  final String body;

  ItemBodyCompletion({required this.body});
}
