import 'dart:io';

import 'package:openai/openai.dart';
import 'package:test/test.dart';

void main() {
  String? modelExampleId;

  group('authentication', () {
    test('without setting a key', () {
      try {
        OpenAI.instance;
      } catch (e) {
        expect(e, isA<MissingApiKeyException>());
      }
    });
    test('with setting a key', () {
      OpenAI.apiKey = "YOUR KEY FROM ENVIRONMENT VARIABLE";
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
        stream: false,
      );
      expect(completion, isA<OpenAICompletionModel>());
      expect(completion.choices.first, isA<OpenAICompletionModelChoice>());
      expect(completion.choices.first.text, isNotNull);
      expect(completion.choices.first.text, isA<String>());
    });
  });
  group('edits', () {
    test('create', () async {
      final OpenAIEditModel edit = await OpenAI.instance.edit.create(
        model: modelExampleId ?? "text-davinci-003",
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
    test(
      "edits",
      () async {
        final OpenAIImageModel image = await OpenAI.instance.image.create(
          prompt: "A dog is walking down the street.",
        );
        final OpenAiImageEditModel imageEdited =
            await OpenAI.instance.image.edit(
          prompt: 'mask the image with color red',
          image: File("YOUR IMAGE PATH"),
          mask: File("YOUR MASK PATH"),
        );
        expect(imageEdited, isA<OpenAIImageModel>());
        expect(imageEdited.data.first.url, isA<String>());
      },
    );
    test("variation", () async {
      final OpenAIImageVariationModel variation =
          await OpenAI.instance.image.variation(
        image: File("YOUR IMAGE PATH"),
      );

      expect(variation, isA<OpenAIImageVariationModel>());
      expect(variation.data.first.url, isA<String>());
    });
  });

  group(
    'embeddings',
    () async {
      test('create', () async {
        final OpenAIEmbeddingsModel embedding =
            await OpenAI.instance.embedding.create(
          model: modelExampleId ?? "text-davinci-003",
          input: "This is a sample text",
        );
        expect(embedding, isA<OpenAIEmbeddingsModel>());
        expect(embedding.data.first, isA<OpenAIEmbeddingsDataModel>());
        expect(embedding.data.first.embeddings, isA<List<double>>());
      });
    },
  );
}
