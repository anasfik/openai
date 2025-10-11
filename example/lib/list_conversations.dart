import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  final allConversations = OpenAI.instance.conversations.listItems();
}
