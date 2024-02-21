// ignore_for_file: avoid-passing-async-when-sync-expected

import 'dart:convert';
import 'dart:io';
import 'dart:developer' as dev;
import 'package:dart_openai/dart_openai.dart';
import 'package:dart_openai/src/core/builder/headers.dart';
import 'package:dart_openai/src/core/constants/config.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/model/sub_models/permission.dart';
import 'package:dart_openai/src/core/utils/logger.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

import 'personal_for_testing/vars.dart';

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

  // String? fineTuneExampleId;

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
      OpenAI.apiKey = "YOUR API KEY HERE";
      // OpenAI.apiKey = apiKey;

      expect(OpenAI.instance, isA<OpenAI>());
    });

    test('test setting organization', () {
      OpenAI.organization = "YOUR ORGANIZATION";
      expect(OpenAI.organization, "YOUR ORGANIZATION");

      // I don't have an actual organization, so I will make it null again.
      // ! If you have a real organization, comment the following line.
      OpenAI.organization = null;
    });
    test("Changing base URL", () {
      final urlChange = "https://something.com";
      OpenAI.baseUrl = urlChange;
      expect(OpenAI.baseUrl, urlChange);

      // ! this is to reset the base URL to the default one.
      OpenAI.baseUrl = OpenAIStrings.defaultBaseUrl;
    });

    test("switching showing logs", () {
      OpenAI.showLogs = true;
      expect(OpenAILogger.isActive, isTrue);

      OpenAI.showLogs = false;
      expect(OpenAILogger.isActive, isFalse);
    });

    test("Add Extra headers to all requests", () {
      OpenAI.includeHeaders({
        "x-openai-test": "test",
      });

      expect(HeadersBuilder.build(), containsPair("x-openai-test", "test"));
    });

    test("requests timeout", () {
      final tS = 10;

      OpenAIConfig.requestsTimeOut = Duration(seconds: tS);

      expect(
        OpenAIConfig.requestsTimeOut.inMilliseconds,
        Duration(seconds: tS).inMilliseconds,
      );

      //! return to the default timeout.

      OpenAIConfig.requestsTimeOut = OpenAIConfig.defaultRequestsTimeOut;
    });

    // test('declaring web environment for the package', () {
    //   OpenAI.isWeb = true;

    //   expect(OpenAI.isWeb, isTrue);

    //   // ! this is to reset the isWeb to the default one.
    //   OpenAI.isWeb = false;
    // });
  });

  group('models', () {
    test(
      'list models',
      () async {
        final models = await OpenAI.instance.model.list();

        expect(models, isA<List<OpenAIModelModel>>());

        if (models.isNotEmpty) {
          expect(models.first, isA<OpenAIModelModel>());
          expect(models.first.id, isNotNull);
          expect(models.first.id, isA<String>());

          if (models.first.permission != null) {
            expect(
              models.first.permission,
              isA<List<OpenAIModelModelPermission>>(),
            );
          }

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
      final model = await OpenAI.instance.model.retrieve(modelExampleId!);

      expect(model, isA<OpenAIModelModel>());

      expect(model.id, isNotNull);

      if (model.permission != null) {
        expect(
          model.permission,
          isA<List<OpenAIModelModelPermission>>(),
        );
      }
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
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                "Hello, how are you?",
              ),
            ],
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

    test(
      'create with function call',
      () async {
        void sendEmail({required String to, required String message}) {
          dev.log(
            "mock Action: the message: $message is sent to $to successfully.",
          );
        }

        final OpenAIChatCompletionModel chatCompletion =
            await OpenAI.instance.chat.create(
          model: "gpt-3.5-turbo-0613",
          messages: [
            OpenAIChatCompletionChoiceMessageModel(
              content: [
                OpenAIChatCompletionChoiceMessageContentItemModel.text(
                  "Send an email to John asking about Marrakech weather",
                ),
              ],
              role: OpenAIChatMessageRole.user,
            ),
          ],
          tools: [
            OpenAIFunctionModel.withParameters(
              name: "sendEmail",
              description:
                  "sends the given email message to the a specific person",
              parameters: [
                OpenAIFunctionProperty.string(
                  name: "to",
                  description: "the name of the message receiver",
                ),
                OpenAIFunctionProperty.string(
                  name: "message",
                  description: "the message to be sent",
                ),
              ],
            ),
          ].map((function) {
            return OpenAIToolModel(type: "function", function: function);
          }).toList(),
        );

        final toolCalls = chatCompletion.choices.first.message.toolCalls;

        if (toolCalls == null || toolCalls.isEmpty) {
          print(
            "weither this happens from the API or the package, the test for this function should not show this.",
          );

          return;
        }

        final firstToolCall = toolCalls.first;
        final funcCall = firstToolCall.function;

        expect(funcCall, isNotNull);

        final decodedArgs =
            jsonDecode(funcCall.arguments) as Map<String, dynamic>;

        expect(decodedArgs["to"], isNotNull);
        expect(decodedArgs["message"], isNotNull);

        sendEmail(
          message: decodedArgs["message"],
          to: decodedArgs["to"],
        );
      },
    );

    test('create with a stream', () {
      final chatStream = OpenAI.instance.chat.createStream(
        model: "gpt-3.5-turbo",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                "Hello, how are you?",
              ),
            ],
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
      final OpenAIImageModel imageEdited = await OpenAI.instance.image.edit(
        prompt: 'mask the image with color red',
        image: imageFileExample,
        mask: maskFileExample,
      );
      expect(imageEdited, isA<OpenAIImageModel>());
      expect(imageEdited.data.first.url, isA<String>());
    });
    test("variation", () async {
      final OpenAIImageModel variation = await OpenAI.instance.image.variation(
        image: imageFileExample,
      );

      expect(variation, isA<OpenAIImageModel>());
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

  // group("fine-tune", () {
  //   test('create', () async {
  //     final OpenAIFineTuneModel fineTune =
  //         await OpenAI.instance.fineTune.create(
  //       trainingFile: fileIdFromFilesApi!,
  //     );
  //     expect(fineTune, isA<OpenAIFineTuneModel>());
  //     expect(fineTune.id, isA<String>());
  //     expect(fineTune.id, isNotNull);
  //     fineTuneExampleId = fineTune.id;
  //   });
  //   test('list', () async {
  //     final List<OpenAIFineTuneModel> fineTunes =
  //         await OpenAI.instance.fineTune.list();
  //     expect(fineTunes, isA<List<OpenAIFineTuneModel>>());
  //     if (fineTunes.isNotEmpty) {
  //       expect(fineTunes.first, isA<OpenAIFineTuneModel>());
  //       expect(fineTunes.first.id, isNotNull);
  //     }
  //   });
  //   test('retrieve', () async {
  //     final OpenAIFineTuneModel fineTune =
  //         await OpenAI.instance.fineTune.retrieve(fineTuneExampleId!);

  //     expect(fineTune, isA<OpenAIFineTuneModel>());
  //     expect(fineTune.id, isA<String>());
  //     expect(fineTune.id, equals(fineTuneExampleId!));
  //   });

  //   test("events", () async {
  //     final List<OpenAIFineTuneEventModel> events =
  //         await OpenAI.instance.fineTune.listEvents(fineTuneExampleId!);
  //     expect(events, isA<List<OpenAIFineTuneEventModel>>());
  //     if (events.isNotEmpty) {
  //       expect(events.first, isA<OpenAIFineTuneEventModel>());
  //       expect(events.first.level, isA<String>());
  //     }
  //   });

  //   test("events stream", () {
  //     final Stream<OpenAIFineTuneEventStreamModel> events =
  //         OpenAI.instance.fineTune.listEventsStream(fineTuneExampleId!);
  //     expect(events, isA<Stream<OpenAIFineTuneEventStreamModel>>());
  //     events.listen(
  //       (event) {
  //         expect(event, isA<OpenAIFineTuneEventStreamModel>());
  //         expect(event.level, isA<String>());
  //       },
  //       onError: (err) {
  //         expect(err, isA<RequestFailedException>());
  //       },
  //     );
  //   });

  //   test("cancel", () async {
  //     OpenAIFineTuneModel cancelledFineTune =
  //         await OpenAI.instance.fineTune.cancel(fineTuneExampleId!);
  //     expect(cancelledFineTune, isA<OpenAIFineTuneModel>());
  //     expect(cancelledFineTune.id, isA<String>());
  //     expect(cancelledFineTune.id, equals(fineTuneExampleId!));
  //   });
  // });

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
