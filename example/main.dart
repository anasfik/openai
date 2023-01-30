import 'package:openai/src/core/models/completion.dart';
import 'package:openai/src/core/models/edit.dart';
import 'package:openai/src/core/models/image.dart';
import 'package:openai/src/instance/edits/edits.dart';
import 'package:openai/src/instance/openai.dart';

void main() async {
  OpenAI.apiKey = "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";
  // OpenAI.organization = "YOUR ORGANIZATION ID";
  // final models = await OpenAI.instance.model.list();
  // final model = await OpenAI.instance.model.one(models.first.id);
  // print(model.id);
  // OpenAICompletionModel completion = await OpenAI.instance.completion.create(
  //   model: "text-davinci-003",
  //   prompt: "Flutter is ",
  //   temperature: 0.8,
  //   maxTokens: 100,
  // );

  // print(completion.choices.first.text);

  // OpenAIEditModel a = await OpenAI.instance.edit.create(
  //   model: "text-davinci-edit-001",
  //   input: " Hi!, I am a bot!!!!,",
  //   instruction: "remove all ! the input ",
  // );

  // print(a.choices.first.text);

  OpenAIImageModel image = await OpenAI.instance.image.create(
    prompt: "A dog",
    n: 1,
  );

  print(image.data.first.url);
}
