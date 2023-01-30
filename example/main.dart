import 'dart:async';
import 'dart:io';
import 'package:openai/src/instance/openai.dart';
import 'package:http/http.dart' as http;

void main() async {
  OpenAI.apiKey = "Your API Key";
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

  // OpenAIImageModel image = await OpenAI.instance.image.create(
  //   prompt: "A dog",
  //   n: 1,
  // );

  // print(image.data.first.url);

  Future<File> getFileFromUrl(String networkUrl) async {
    final response = await http.get(Uri.parse(networkUrl));
    final file = File("image.png");
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  final a = await getFileFromUrl(
      "https://ico.cppng.com/download/2020-06/51744-3-desktop-computer-download-image-download-hq-png.png");

  final b = await getFileFromUrl(
      "https://in.portal-pokemon.com/play/resources/pokedex/img/pm/997f32e3b38169eab2b431bc2ead3c8217674f6a.png");

  final result = await OpenAI.instance.image.edit(
    image: a,
    mask: b,
    prompt: "change color to green",
    n: 1,
  );

  print(result.data.first.url);
}
