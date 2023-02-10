import 'package:dart_openai/openai.dart';
import 'package:dotenv/dotenv.dart';

Future<void> main() async {
  // Load the .env file
  DotEnv env = DotEnv()..load([".env"]);

  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = env['OPEN_AI_API_KEY']!;

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
