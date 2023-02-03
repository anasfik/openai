import 'package:openai/openai.dart';
import 'package:test/test.dart';

void main() {
  group('authentication', () {
    test('without setting a key', () {
      try {
        OpenAI.instance;
      } catch (e) {
        expect(e, isA<MissingApiKeyException>());
      }
    });
    test('with setting a key', () {
      OpenAI.apiKey = "YOUR KEY LOADED FROM ENVIRONMENT VARIABLE";
      expect(OpenAI.instance, isA<OpenAI>());
    });

    test('test setting organization', () {
      OpenAI.organization = "YOUR ORGANIZATION";
      expect(OpenAI.organization, "YOUR ORGANIZATION");
    });
  });
  group('models', () {
    String? modelExampleId;
    test('list models', () async {
      final List<OpenAIModelModel> models = await OpenAI.instance.model.list();
      expect(models, isA<List<OpenAIModelModel>>());
      if (models.isNotEmpty) {
        expect(models.first, isA<OpenAIModelModel>());
        expect(models.first.id, isNotNull);
        expect(models.first.id, isA<String>());
        modelExampleId = models.first.id;
      }
    });

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
        model: "davinci-text-003",
        prompt: "Dart tests are made to ensure that a function w",
        maxTokens: 5,
        temperature: 0.9,
        topP: 1,
        presencePenalty: 0,
        frequencyPenalty: 0,
        bestOf: 1,
        n: 1,
        stream: false,
        stop: [""],
      );
      expect(completion, isA<OpenAICompletionModel>());
      expect(completion.choices.first, isA<OpenAICompletionModelChoice>());
      expect(completion.choices.first.text, isNotNull);
      expect(completion.choices.first.text, isA<String>());
    });
  });
}
