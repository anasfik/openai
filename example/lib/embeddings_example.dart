import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;

  final embedding = await OpenAI.instance.embedding.create(
    model: "text-embedding-ada-002",
    input: "This is a sample text",
  );

  for (int index = 0; index < embedding.data.length; index++) {
    final currentItem = embedding.data[index];
    print(currentItem);
  }
}
