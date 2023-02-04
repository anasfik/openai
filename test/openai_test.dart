import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:openai/openai.dart';
import 'package:test/test.dart';

void main() async {
  final imageFileExample = await getFileFromUrl(
      "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png");

  final maskFileExample = await getFileFromUrl(
      "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png");

  String? modelExampleId;

  String? fileIdFromFilesApi;

  group('authentication', () {
    test('without setting a key', () {
      try {
        OpenAI.instance;
      } catch (e) {
        expect(e, isA<MissingApiKeyException>());
      }
    });
    test('with setting a key', () {
      OpenAI.apiKey = "YOUR API KEY FROM ENVIRONMENT VARIABLE";
      expect(OpenAI.instance, isA<OpenAI>());
    });

    test('test setting organization', () {
      OpenAI.organization = "YOUR ORGANIZATION";
      expect(OpenAI.organization, "YOUR ORGANIZATION");

      // I don't have an actual organization, so I will make it null again.
      // ! If you have a real organization, comment the following line.
      OpenAI.organization = null;
    });
  });
  group('models', () {
    test(
      'list models',
      () async {
        final List<OpenAIModelModel> models =
            await OpenAI.instance.model.list();
        expect(models, isA<List<OpenAIModelModel>>());
        if (models.isNotEmpty) {
          expect(models.first, isA<OpenAIModelModel>());
          expect(models.first.id, isNotNull);
          expect(models.first.id, isA<String>());

          // trying to get the "text-davinci-003" model id.
          modelExampleId = models
              .firstWhere((element) => element.id.contains("davinci-003"))
              .id;
        }
      },
    );

    test('retrieve a model', () async {
      assert(
        modelExampleId != null,
        "please set a model id that is not null, or let the previous test run first to get a model id example",
      );
      final OpenAIModelModel model =
          await OpenAI.instance.model.retrieve(modelExampleId!);
      expect(model, isA<OpenAIModelModel>());
      expect(model.id, isNotNull);
    });
  });
  group('completions', () {
    test('create', () async {
      final OpenAICompletionModel completion =
          await OpenAI.instance.completion.create(
        // in case the previous test didn't run, we will use a default model id.
        model: modelExampleId ?? "text-davinci-003",
        prompt: "Dart tests are made to ensure that a function w",
        maxTokens: 5,
        temperature: 0.9,
        topP: 1,
        presencePenalty: 0,
        frequencyPenalty: 0,
        bestOf: 1,
        n: 1,
      );
      expect(completion, isA<OpenAICompletionModel>());
      expect(completion.choices.first, isA<OpenAICompletionModelChoice>());
      expect(completion.choices.first.text, isNotNull);
      expect(completion.choices.first.text, isA<String>());
    });
    test('create with a stream', () async {
      final Stream<OpenAIStreamCompletionModel> completion =
          OpenAI.instance.completion.createStream(
        // in case the previous test didn't run, we will use a default model id.
        model: modelExampleId ?? "text-davinci-003",
        prompt: "Dart tests are made to ensure that a function w",
        maxTokens: 5,
        temperature: 0.9,
        topP: 1,
        presencePenalty: 0,
        frequencyPenalty: 0,
        bestOf: 1,
        n: 1,
      );
      expect(completion, isA<Stream<OpenAIStreamCompletionModel>>());
    });
  });
  group('edits', () {
    test('create', () async {
      final OpenAIEditModel edit = await OpenAI.instance.edit.create(
        model: "text-davinci-edit-001",
        instruction: "remove the word 'made' from the text",
        input: "I made something, idk man",
      );
      expect(edit, isA<OpenAIEditModel>());
      expect(edit.choices.first, isA<OpenAIEditModelChoice>());
      expect(edit.choices.first.text, isNotNull);
      expect(edit.choices.first.text, isA<String>());
    });
  });
  group('images', () {
    test('create', () async {
      final OpenAIImageModel image = await OpenAI.instance.image.create(
        prompt: "A dog is walking down the street.",
      );

      expect(image, isA<OpenAIImageModel>());
      expect(image.data.first.url, isA<String>());
    });
    test("edits", () async {
      final OpenAiImageEditModel imageEdited = await OpenAI.instance.image.edit(
        prompt: 'mask the image with color red',
        image: imageFileExample,
        mask: maskFileExample,
      );
      expect(imageEdited, isA<OpenAiImageEditModel>());
      expect(imageEdited.data.first.url, isA<String>());
    });
    test("variation", () async {
      final OpenAIImageVariationModel variation =
          await OpenAI.instance.image.variation(
        image: imageFileExample,
      );

      expect(variation, isA<OpenAIImageVariationModel>());
      expect(variation.data.first.url, isA<String>());
    });
  });

  group('embeddings', () {
    test('create', () async {
      final OpenAIEmbeddingsModel embedding =
          await OpenAI.instance.embedding.create(
        model: "text-embedding-ada-002",
        input: "This is a sample text",
      );
      expect(embedding, isA<OpenAIEmbeddingsModel>());
      expect(embedding.data.first, isA<OpenAIEmbeddingsDataModel>());
      expect(embedding.data.first.embeddings, isA<List<double>>());
    });
  });

  group("files", () {
    test("upload", () async {
      final OpenAIFileModel file = await OpenAI.instance.file.upload(
        file: jsonLFileExample(),
        purpose: "fine-tune",
      );

      expect(file, isA<OpenAIFileModel>());
      expect(file.id, isA<String>());
      expect(file.id, isNotNull);
    });
    test("list", () async {
      final List<OpenAIFileModel> files = await OpenAI.instance.file.list();
      expect(files, isA<List<OpenAIFileModel>>());
      if (files.isNotEmpty) {
        expect(files.first, isA<OpenAIFileModel>());
        expect(files.first.id, isNotNull);
        expect(files.first.id, isA<String>());

        // get the id of the file that we uploaded in the previous test.
        fileIdFromFilesApi = files
            .firstWhere((element) => element.fileName.contains("example.jsonl"))
            .id;
      }
    });

    test("retrive", () async {
      assert(
        fileIdFromFilesApi != null,
        "please set a file id that is not null, or let the previous test run first to get a file id example (if it does exists)",
      );

      final OpenAIFileModel file =
          await OpenAI.instance.file.retrieve(fileIdFromFilesApi!);

      expect(file, isA<OpenAIFileModel>());
      expect(file.id, isA<String>());
      expect(file.id, isNotNull);
    });
    test("retrieve content", () async {
      final dynamic content =
          await OpenAI.instance.file.retrieveContent(fileIdFromFilesApi!);
      expect(content, isNotNull);
    });

    test("delete", () async {
      final bool file = await OpenAI.instance.file.delete(fileIdFromFilesApi!);
      expect(file, isA<bool>());
      // we are trying to delete the file that we uploaded in the previous test.
      // so it should return true.
      expect(file, isTrue);
    });
  });

  group('moderations', () {
    test('create', () async {
      final OpenAIModerationModel moderation =
          await OpenAI.instance.moderation.create(
        input: "I hate you",
      );

      expect(moderation, isA<OpenAIModerationModel>());
      expect(moderation.results.first.categories.hate, isA<bool>());
    });
  });
}

File jsonLFileExample() {
  final file = File("example.jsonl");
  file.writeAsStringSync(
    jsonEncode(
        {"prompt": "<prompt text>", "completion": "<ideal generated text>"}),
  );
  return file;
}

Future<File> getFileFromUrl(String networkUrl) async {
  final response = await http.get(Uri.parse(networkUrl));
  final uniqueImageName = DateTime.now().microsecondsSinceEpoch;
  final file = File("$uniqueImageName.png");
  await file.writeAsBytes(response.bodyBytes);
  return file;
}
