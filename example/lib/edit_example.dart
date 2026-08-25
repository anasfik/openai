import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

Future<void> main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  // Creates the Edit
  OpenAIEditModel edit = await OpenAI.instance.edit.create(
    model: "text-davinci-edit-001",
    input:
        "Flutter is a cross-platform UI toolkit that is designed to allow code reuse across operating systems such as iOS and Android, while also allowing applications to interface directly with underlying platform services.",
    instruction: "summarize the input to 50 tokens at maximum",
    temperature: 0.8,
    n: 4,
  );

  // Prints the choices.
  for (int index = 0; index < edit.choices.length; index++) {
    print(edit.choices[index].text);
  }
}
