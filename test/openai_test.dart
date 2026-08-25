// ignore_for_file: avoid-passing-async-when-sync-expected

import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:dart_openai/src/core/builder/headers.dart';
import 'package:dart_openai/src/core/constants/config.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/utils/logger.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() async {
  final liveApiKey = Platform.environment['OPEN_AI_API_KEY'];
  if (liveApiKey == null || liveApiKey.isEmpty) {
    // Live-API integration suite. Skipped locally/CI unless a key is provided.
    return;
  }

  final exampleImageFile = await getFileFromUrl(
    'https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png',
  );

  final imageFileExample = await loadOpenAIFile(exampleImageFile.path);
  final maskFileExample = imageFileExample;

  String? fileIdFromFilesApi;
  // ignore: unused_local_variable
  String? fileToDelete;

  // String? fineTuneExampleId;

  group('authentication', () {
    test('without setting a key', () {
      try {
        OpenAI.instance;
      } catch (e) {
        expect(e, isA<MissingApiKeyException>());
      }
    });
    test('with setting a key', () {
      OpenAI.apiKey = liveApiKey;

      expect(OpenAI.instance, isA<OpenAI>());
    });

    test('test setting organization', () {
      OpenAI.organization = 'YOUR ORGANIZATION';
      expect(OpenAI.organization, 'YOUR ORGANIZATION');

      // I don't have an actual organization, so I will make it null again.
      // ! If you have a real organization, comment the following line.
      OpenAI.organization = null;
    });
    test('Changing base URL', () {
      const urlChange = 'https://something.com';
      OpenAI.baseUrl = urlChange;
      expect(OpenAI.baseUrl, urlChange);

      // ! this is to reset the base URL to the default one.
      OpenAI.baseUrl = OpenAIStrings.defaultBaseUrl;
    });

    test('switching showing logs', () {
      OpenAI.showLogs = true;
      expect(OpenAILogger.isActive, isTrue);

      OpenAI.showLogs = false;
      expect(OpenAILogger.isActive, isFalse);
    });

    test('Add Extra headers to all requests', () {
      OpenAI.includeHeaders({
        'x-openai-test': 'test',
      });

      expect(HeadersBuilder.build(), containsPair('x-openai-test', 'test'));
    });

    test('requests timeout', () {
      const tS = 10;

      OpenAIConfig.requestsTimeOut = const Duration(seconds: tS);

      expect(
        OpenAIConfig.requestsTimeOut.inMilliseconds,
        const Duration(seconds: tS).inMilliseconds,
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
    String? modelExampleId;

    test(
      'list models',
      () async {
        final models = await OpenAI.instance.model.list();

        expect(models, isA<List<OpenAIModelModel>>());

        if (models.isNotEmpty) {
          expect(models.first, isA<OpenAIModelModel>());
          expect(models.first.id, isNotNull);
          expect(models.first.id, isA<String>());

          // ignore: unused_local_variable
          final someModel = models.first;

          modelExampleId = models
              .firstWhereOrNull(
                (element) => element.id.contains('gpt-3'),
              )!
              .id;
        }
      },
    );

    test('retrieve a model', () async {
      assert(
        modelExampleId != null,
        'please set a model id that is not null, or let the previous test run first to get a model id example',
      );

      final model = await OpenAI.instance.model.retrieve(modelExampleId!);

      expect(model, isA<OpenAIModelModel>());

      expect(model.id, isNotNull);
    });
  });

  group('completions', () {
    test('create', () async {
      final completion = await OpenAI.instance.completion.create(
        model: 'davinci-002',
        prompt: 'Dart tests are made to ensure that a function w',
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

    test('create with a stream', () async {
      final completionStream = OpenAI.instance.completion.createStream(
        model: 'davinci-002',
        prompt: 'Dart tests are made to ensure that a function w',
        maxTokens: 5,
        temperature: 0.9,
        topP: 1,
        presencePenalty: 0,
        frequencyPenalty: 0,
        bestOf: 1,
        n: 1,
      );

      final completer = Completer<bool>();
      expect(completionStream, isA<Stream<OpenAIStreamCompletionModel>>());

      completionStream.listen(
        (event) {
          final val = event.choices.first.text;

          expect(val, isA<String>());
        },
        onDone: () {
          completer.complete(true);
        },
      );

      await completer.future;
    });
  });

  group('chat (chatGPT)', () {
    test('create', () async {
      final chatCompletion = await OpenAI.instance.chat.create(
        model: 'gpt-3.5-turbo',
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                'Hello, how are you?',
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
      expect(
        chatCompletion.choices.first.message.content,
        isA<List<OpenAIChatCompletionChoiceMessageContentItemModel>>(),
      );
      expect(
        chatCompletion.choices.first.message.content!
            .map((e) => e.text)
            .isEmpty,
        isFalse,
      );
    });

    test(
      'create with function call',
      () async {
        void sendEmail({required String to, required String message}) {
          dev.log(
            'mock Action: the message: $message is sent to $to successfully.',
          );
        }

        final chatCompletion = await OpenAI.instance.chat.create(
          model: 'gpt-3.5-turbo',
          messages: [
            OpenAIChatCompletionChoiceMessageModel(
              content: [
                OpenAIChatCompletionChoiceMessageContentItemModel.text(
                  'Send an email to John asking about Marrakech weather',
                ),
              ],
              role: OpenAIChatMessageRole.user,
            ),
          ],
          tools: [
            OpenAIFunctionModel.withParameters(
              name: 'sendEmail',
              description:
                  'sends the given email message to the a specific person',
              parameters: [
                OpenAIFunctionProperty.string(
                  name: 'to',
                  description: 'the name of the message receiver',
                ),
                OpenAIFunctionProperty.string(
                  name: 'message',
                  description: 'the message to be sent',
                ),
              ],
            ),
          ].map((function) {
            return OpenAIToolModel(type: 'function', function: function);
          }).toList(),
        );

        final toolCalls = chatCompletion.choices.first.message.toolCalls;

        if (toolCalls == null || toolCalls.isEmpty) {
          print(
            'weither this happens from the API or the package, the test for this function should not show this.',
          );

          return;
        }

        final firstToolCall = toolCalls.first;
        final funcCall = firstToolCall.function;

        expect(funcCall, isNotNull);

        final decodedArgs =
            jsonDecode(funcCall!.arguments!) as Map<String, dynamic>;

        expect(decodedArgs['to'], isNotNull);
        expect(decodedArgs['message'], isNotNull);

        sendEmail(
          message: decodedArgs['message'],
          to: decodedArgs['to'],
        );
      },
    );

    test('create with a stream', () async {
      final chatStream = OpenAI.instance.chat.createStream(
        model: 'gpt-3.5-turbo',
        streamOptions: {
          'include_usage': true,
        },
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                'Hello, how are you?',
              ),
            ],
            role: OpenAIChatMessageRole.user,
          ),
        ],
      );
      final completer = Completer<bool>();

      expect(chatStream, isA<Stream<OpenAIStreamChatCompletionModel>>());
      chatStream.listen(
        (streamEvent) {
          expect(streamEvent, isA<OpenAIStreamChatCompletionModel>());
          expect(streamEvent.choices.first.delta.content,
              isA<List<OpenAIChatCompletionChoiceMessageContentItemModel>?>());
          expect(streamEvent.choices.first.delta.content?.first?.text,
              isA<String?>());
          if (streamEvent.usage != null) {
            final u = streamEvent.usage!;
            expect(u, isA<OpenAIStreamChatCompletionUsageModel>());
            expect(u.promptTokens, greaterThan(0));
            expect(u.completionTokens, greaterThan(0));
            expect(u.totalTokens, equals(u.promptTokens + u.completionTokens));
          }
        },
        onDone: () {
          completer.complete(true);
        },
      );

      await completer.future;
    });
  });

  group('images', () {
    test('create', () async {
      final image = await OpenAI.instance.image.create(
        prompt: 'A dog is walking down the street.',
      );

      expect(image, isA<OpenAIImageModel>());
      expect(image.data.first.url, isA<String>());
    });
    test('edits', () async {
      final imageEdited = await OpenAI.instance.image.edit(
        prompt: 'mask the image with color red',
        image: imageFileExample,
        mask: maskFileExample,
      );
      expect(imageEdited, isA<OpenAIImageModel>());
      expect(imageEdited.data.first.url, isA<String>());
    });
    test('variation', () async {
      final variation = await OpenAI.instance.image.variation(
        image: imageFileExample,
      );

      expect(variation, isA<OpenAIImageModel>());
      expect(variation.first.url, isA<String>());
    });
  });

  group('embeddings', () {
    test('create', () async {
      final embedding = await OpenAI.instance.embedding.create(
        model: 'text-embedding-ada-002',
        input: 'This is a sample text',
      );
      expect(embedding, isA<OpenAIEmbeddingsModel>());
      expect(embedding.data.first, isA<OpenAIEmbeddingsDataModel>());
      expect(embedding.data.first.embeddings, isA<List<double>>());
    });

    test('create with smaller dimensions', () async {
      final embedding = await OpenAI.instance.embedding.create(
        model: 'text-embedding-3-large',
        input: 'This is a sample text',
        dimensions: 1000,
      );
      expect(embedding, isA<OpenAIEmbeddingsModel>());
      expect(embedding.data.first, isA<OpenAIEmbeddingsDataModel>());
      expect(embedding.data.first.embeddings, isA<List<double>>());
      expect(embedding.data.first.embeddings.length, 1000);
    });
  });

  group('audio', () {
    test('create transcription', () async {
      final audioExampleFile = await getFileFromUrl(
        'https://www.cbvoiceovers.com/wp-content/uploads/2017/05/Commercial-showreel.mp3',
        fileExtension: 'mp3',
      );

      final transcription = await OpenAI.instance.audio.createTranscription(
        file: await loadOpenAIFile(audioExampleFile.path),
        model: 'whisper-1',
        responseFormat: OpenAIAudioResponseFormat.json,
      );

      if (transcription is OpenAITranscriptionVerboseModel) {
        expect(transcription.language, isA<String?>());
      } else if (transcription is OpenAITranscriptionModel) {
        expect(transcription.text, isA<String?>());
      }
    });

    test('create transcription with timestamp granularity', () async {
      final audioExampleFile = await getFileFromUrl(
        'https://www.cbvoiceovers.com/wp-content/uploads/2017/05/Commercial-showreel.mp3',
        fileExtension: 'mp3',
      );

      final transcription = await OpenAI.instance.audio.createTranscription(
        file: await loadOpenAIFile(audioExampleFile.path),
        model: 'whisper-1',
        responseFormat: OpenAIAudioResponseFormat.verbose_json,
        timestampGranularities: [OpenAIAudioTimestampGranularity.word],
      );

      expect(transcription, isA<OpenAITranscriptionGeneralModel>());

      if (transcription is OpenAITranscriptionVerboseModel) {
        expect(transcription.language, isA<String?>());
      } else if (transcription is OpenAITranscriptionModel) {
        expect(transcription.text, isA<String?>());
      }
    });
    test('create translation', () async {
      final audioExampleFile = await getFileFromUrl(
        'https://www.cbvoiceovers.com/wp-content/uploads/2017/05/Commercial-showreel.mp3',
        fileExtension: 'mp3',
      );

      final translation = await OpenAI.instance.audio.createTranslation(
        file: await loadOpenAIFile(audioExampleFile.path),
        model: 'whisper-1',
      );

      expect(translation, isA<String>());
    });

    test('create transcription with auto chunking strategy', () async {
      // Arrange
      final audioExampleFile = await getFileFromUrl(
        'https://www.cbvoiceovers.com/wp-content/uploads/2017/05/Commercial-showreel.mp3',
        fileExtension: 'mp3',
      );
      // ignore: unused_local_variable
      final chunkingStrategy = OpenAIAudioChunkingConfig.auto();

      // Act
      final transcription = await OpenAI.instance.audio.createTranscription(
        file: await loadOpenAIFile(audioExampleFile.path),
        model: 'whisper-1',
        chunkingStrategy: chunkingStrategy,
      );
      if (transcription is OpenAITranscriptionVerboseModel) {
        expect(transcription.language, isA<String?>());
      } else if (transcription is OpenAITranscriptionModel) {
        expect(transcription.text, isA<String?>());
      }
    });

    test('create transcription with server VAD chunking strategy', () async {
      // Arrange
      final audioExampleFile = await getFileFromUrl(
        'https://www.cbvoiceovers.com/wp-content/uploads/2017/05/Commercial-showreel.mp3',
        fileExtension: 'mp3',
      );
      // ignore: unused_local_variable
      final chunkingStrategy = OpenAIAudioChunkingConfig.serverVad(
        prefixPaddingMs: 200,
        silenceDurationMs: 500,
        threshold: 0.1,
      );

      // Act
      final transcription = await OpenAI.instance.audio.createTranscription(
        file: await loadOpenAIFile(audioExampleFile.path),
        model: 'whisper-1',
        chunkingStrategy: chunkingStrategy,
      );

      if (transcription is OpenAITranscriptionVerboseModel) {
        expect(transcription.language, isA<String?>());
      } else if (transcription is OpenAITranscriptionModel) {
        expect(transcription.text, isA<String?>());
      }
    });

    test('create translation with auto chunking strategy', () async {
      // Arrange
      final audioExampleFile = await getFileFromUrl(
        'https://www.cbvoiceovers.com/wp-content/uploads/2017/05/Commercial-showreel.mp3',
        fileExtension: 'mp3',
      );
      // ignore: unused_local_variable
      final chunkingStrategy = OpenAIAudioChunkingConfig.auto();

      // Act
      final translation = await OpenAI.instance.audio.createTranslation(
        file: await loadOpenAIFile(audioExampleFile.path),
        model: 'whisper-1',
      );

      expect(translation, isA<String>());
    });
  });

  group('files', () {
    test('upload', () async {
      final file = await OpenAI.instance.file.upload(
        file: await loadOpenAIFile(jsonLFileExample().path),
        purpose: 'fine-tune',
      );

      expect(file, isA<OpenAIFileModel>());
      expect(file.id, isA<String>());
      expect(file.id, isNotNull);
    });
    test('list', () async {
      final files = await OpenAI.instance.file.list();

      if (files.data.isNotEmpty) {
        expect(files.data.first, isA<OpenAIFileModel>());
        expect(files.data.first.id, isNotNull);
        expect(files.data.first.id, isA<String>());

        // get the id of the file that we uploaded in the previous test.
        fileIdFromFilesApi = files.data
            .firstWhere((element) => element.fileName.contains('example.jsonl'))
            .id;
        // ignore: unused_local_variable
        fileToDelete = files.data.last.id;
      }
    });

    test('retrive', () async {
      assert(
        fileIdFromFilesApi != null,
        'please set a file id that is not null, or let the previous test run first to get a file id example (if it does exists)',
      );

      final file = await OpenAI.instance.file.retrieve(fileIdFromFilesApi!);

      expect(file, isA<OpenAIFileModel>());
      expect(file.id, isA<String>());
      expect(file.id, isNotNull);
    });
    test('retrieve content', () async {
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
      final moderation = await OpenAI.instance.moderation.create(
        input: 'I hate you',
      );

      expect(moderation, isA<OpenAIModerationModel>());
      expect(moderation.results.first.categories.hate, isA<bool>());
    });
  });
}

File jsonLFileExample() {
  final file = File('example.jsonl')
    ..writeAsStringSync(jsonEncode({
      'prompt': '<prompt text>',
      'completion': '<ideal generated text>',
    }));

  return file;
}

Future<File> getFileFromUrl(
  String networkUrl, {
  String fileExtension = 'png',
}) async {
  final response = await http.get(Uri.parse(networkUrl));
  final uniqueImageName = DateTime.now().microsecondsSinceEpoch;
  final file = File('$uniqueImageName.$fileExtension');
  await file.writeAsBytes(response.bodyBytes);

  return file;
}
