import 'package:openai/src/instance/openai.dart';

void main() {
  OpenAI.apiKey = "";
  print(OpenAI.instance);
}
