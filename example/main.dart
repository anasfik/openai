import 'package:openai/openai.dart';

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

  // OpenAIImageModel image = await OpenAI.instance.image.create(
  //   prompt: "A dog",
  //   n: 1,
  // );

  // print(image.data.first.url);

  // Future<File> getFileFromUrl(String networkUrl) async {
  //   final response = await http.get(Uri.parse(networkUrl));
  //   final file = File("image.json");
  //   await file.writeAsBytes(response.bodyBytes);
  //   return file;
  // }

  // final a = await getFileFromUrl(
  //     "https://ico.cppng.com/download/2020-06/51744-3-desktop-computer-download-image-download-hq-png.png");

  // final b = await getFileFromUrl(
  //     "https://in.portal-pokemon.com/play/resources/pokedex/img/pm/997f32e3b38169eab2b431bc2ead3c8217674f6a.png");

  // final result = await OpenAI.instance.image.edit(
  //   image: a,
  //   mask: b,
  //   prompt: "change color to green",
  //   n: 1,
  // );

  // print(result.data.first.url);

  // OpenAIImageVariationModel variation = await OpenAI.instance.image.variation(
  //   image: a,
  // );
  // print(variation.data.first.url);

  // OpenAIEmbeddingsModel embeddings = await OpenAI.instance.embedding.create(
  //   model: "text-embedding-ada-002",
  //   input: "This is a text input just to test",
  // );
  // print(embeddings.data.first.embeddings);
  // final List<OpenAIFileModel> file = await OpenAI.instance.file.list();
  // print(file);

  // final OpenAIFileModel fileExample =
  //     await OpenAI.instance.file.retrieve(file.first.id);
  // print(fileExample.fileName);

  // final fileContentExample =
  //     await OpenAI.instance.file.retrieveContent(fileExample.id);
  // print(fileContentExample);

  // final fineTune = await OpenAI.instance.fineTune
  //     .create(trainingFile: "file-wJR4HjdfmPm3BwuEpnxYhmfH");
  // print(fineTune);

  // final fineTuneList = await OpenAI.instance.fineTune.list();
  // print(fineTuneList);

  // final fineTuneRetrieve =
  //     await OpenAI.instance.fineTune.retrieve(fineTuneList.first.id);
  // print(fineTuneRetrieve);

  // final events = await OpenAI.instance.fineTune.listEvents(fineTuneRetrieve.id);
  // print(events);

  // final newCreatedTune = await OpenAI.instance.fineTune.create(
  //   trainingFile: "file-wJR4HjdfmPm3BwuEpnxYhmfH",
  // );

  // print(newCreatedTune);

  // for (int index = 0; index < 10; index++) {
  //   final events = await OpenAI.instance.fineTune.listEvents(newCreatedTune.id);
  //   print(events);
  // }
  // final canceledFineTune = await OpenAI.instance.fineTune.cancel(newCreatedTune.id);
  bool isTuneDeleted = await OpenAI.instance.fineTune.delete("curie:ft-personal-2023-02-02-17-17-47");
  print(isTuneDeleted);
}
