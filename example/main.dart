import 'package:openai/src/instance/model/completion.dart';
import 'package:openai/src/instance/openai.dart';

void main() async {
  OpenAI.apiKey = "Your API Key";
  // OpenAI.organization = "YOUR ORGANIZATION ID";
  // final models = await OpenAI.instance.model.list();
  // final model = await OpenAI.instance.model.one(models.first.id);
  // print(model.id);
  OpenAICompletionModel completion = await OpenAI.instance.completion.create(
    model: "text-davinci-003",
    prompt: "Dart laungage",
  );

  print(completion.choices.first.text);
}
