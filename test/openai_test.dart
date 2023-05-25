import 'dart:convert';
import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() async {
  final exampleImageFile = await getFileFromUrl(
    "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png",
  );
  final audioExampleFile = await getFileFromUrl(
    "https://www.cbvoiceovers.com/wp-content/uploads/2017/05/Commercial-showreel.mp3",
    fileExtension: "mp3",
  );

  final imageFileExample = await exampleImageFile;
  final maskFileExample = await exampleImageFile;

  String? modelExampleId;

  String? fileIdFromFilesApi;

  String? fineTuneExampleId;

  // ignore: unused_local_variable
  String? fileToDelete;

  group('authentication', () {
    test('without setting a key', () {
      try {
        OpenAI.instance;
      } catch (e) {
        expect(e, isA<MissingApiKeyException>());
      }
    });
    test('with setting a key', () {
      OpenAI.apiKey = "YOUR-API-KEY";

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
      expect(completion.choices.first.text, isA<String?>());
    });
    test('create with a stream', () {
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

  group('chat (chatGPT)', () {
    test('create', () async {
      final OpenAIChatCompletionModel chatCompletion =
          await OpenAI.instance.chat.create(
        model: "gpt-3.5-turbo",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: "Hello, how are you?",
            role: OpenAIChatMessageRole.user,
          ),
        ],
      );

      expect(chatCompletion, isA<OpenAIChatCompletionModel>());
      expect(
        chatCompletion.choices.first,
        isA<OpenAIChatCompletionChoiceModel>(),
      );
      expect(chatCompletion.choices.first.message, isNotNull);
      expect(
        chatCompletion.choices.first.message,
        isA<OpenAIChatCompletionChoiceMessageModel>(),
      );
      expect(chatCompletion.choices.first.message.content, isA<String>());
    });
    test('create with a stream', () {
      final chatStream = OpenAI.instance.chat.createStream(
        model: "gpt-3.5-turbo",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: "Hello, how are you?",
            role: OpenAIChatMessageRole.user,
          ),
        ],
      );
      expect(chatStream, isA<Stream<OpenAIStreamChatCompletionModel>>());
      chatStream.listen((streamEvent) {
        expect(streamEvent, isA<OpenAIStreamChatCompletionModel>());
        expect(streamEvent.choices.first.delta.content, isA<String?>());
      });
    });
  });
  group('edits', () {
    // ! temporary disabled, because the API have on this and throws an unexpected error from OpenAI end.
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

  group('audio', () {
    test("create transcription", () async {
      final transcription = await OpenAI.instance.audio.createTranscription(
        file: audioExampleFile,
        model: "whisper-1",
        responseFormat: OpenAIAudioResponseFormat.json,
      );

      expect(transcription, isA<OpenAIAudioModel>());
      expect(transcription.text, isA<String>());
    });
    test("create translation", () async {
      final translation = await OpenAI.instance.audio.createTranslation(
        file: audioExampleFile,
        model: "whisper-1",
      );

      expect(translation, isA<OpenAIAudioModel>());
      expect(translation.text, isA<String>());
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
        fileToDelete = files.last.id;
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
      final content =
          await OpenAI.instance.file.retrieveContent(fileIdFromFilesApi!);
      expect(content, isNotNull);
    });

    // ! this will throw an error if you try ti delete the new uploaded file from the upload() method because it will be still processing, so please, wait a few seconds before running this test, otherwise get a file id from the list() method and set it to the fileIdFromFilesApi variable.
    // test("delete", () async {
    //   final bool file = await OpenAI.instance.file.delete(
    //     // "READ THE COMMENT ABOVE"
    //     fileToDelete!,
    //   );
    //   expect(file, isA<bool>());
    //   // we are trying to delete the file that we uploaded in the previous test.
    //   // so it should return true.
    //   expect(file, isTrue);
    // });
  });

  group("fine-tune", () {
    test('create', () async {
      final OpenAIFineTuneModel fineTune =
          await OpenAI.instance.fineTune.create(
        trainingFile: fileIdFromFilesApi!,
      );
      expect(fineTune, isA<OpenAIFineTuneModel>());
      expect(fineTune.id, isA<String>());
      expect(fineTune.id, isNotNull);
      fineTuneExampleId = fineTune.id;
    });
    test('list', () async {
      final List<OpenAIFineTuneModel> fineTunes =
          await OpenAI.instance.fineTune.list();
      expect(fineTunes, isA<List<OpenAIFineTuneModel>>());
      if (fineTunes.isNotEmpty) {
        expect(fineTunes.first, isA<OpenAIFineTuneModel>());
        expect(fineTunes.first.id, isNotNull);
      }
    });
    test('retrieve', () async {
      final OpenAIFineTuneModel fineTune =
          await OpenAI.instance.fineTune.retrieve(fineTuneExampleId!);

      expect(fineTune, isA<OpenAIFineTuneModel>());
      expect(fineTune.id, isA<String>());
      expect(fineTune.id, equals(fineTuneExampleId!));
    });

    test("events", () async {
      final List<OpenAIFineTuneEventModel> events =
          await OpenAI.instance.fineTune.listEvents(fineTuneExampleId!);
      expect(events, isA<List<OpenAIFineTuneEventModel>>());
      if (events.isNotEmpty) {
        expect(events.first, isA<OpenAIFineTuneEventModel>());
        expect(events.first.level, isA<String>());
      }
    });

    test("events stream", () {
      final Stream<OpenAIFineTuneEventStreamModel> events =
          OpenAI.instance.fineTune.listEventsStream(fineTuneExampleId!);
      expect(events, isA<Stream<OpenAIFineTuneEventStreamModel>>());
      events.listen(
        (event) {
          expect(event, isA<OpenAIFineTuneEventStreamModel>());
          expect(event.level, isA<String>());
        },
        onError: (err) {
          expect(err, isA<RequestFailedException>());
        },
      );
    });

    test("cancel", () async {
      OpenAIFineTuneModel cancelledFineTune =
          await OpenAI.instance.fineTune.cancel(fineTuneExampleId!);
      expect(cancelledFineTune, isA<OpenAIFineTuneModel>());
      expect(cancelledFineTune.id, isA<String>());
      expect(cancelledFineTune.id, equals(fineTuneExampleId!));
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

Future<File> getFileFromUrl(
  String networkUrl, {
  String fileExtension = 'png',
}) async {
  final response = await http.get(Uri.parse(networkUrl));
  final uniqueImageName = DateTime.now().microsecondsSinceEpoch;
  final file = File("$uniqueImageName.$fileExtension");
  await file.writeAsBytes(response.bodyBytes);
  return file;
}
