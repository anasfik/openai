import 'package:dart_openai/dart_openai.dart';
import 'package:test/test.dart';

import 'personal_for_testing/vars.dart';

void main() {
  group('authentication', () {
    test('without setting a key', () {
      try {
        AzureOpenAI.instance;
      } catch (e) {
        expect(e, isA<MissingApiKeyException>());
      }
    });
    test('with setting a key', () {
      AzureOpenAI.apiKey = "YOUR API KEY HERE";
      // AzureOpenAI.apiKey = azureApiKey;

      expect(AzureOpenAI.instance, isA<AzureOpenAI>());
    });

    test("API URL", () {
      AzureOpenAI.configureRestAPI(
        yourResourceName: "your_resource_name",
        yourDeploymentName: "your_deployment_name",
        apiVersion: DateTime(2023, 06, 01),
      );

      expect(
        AzureOpenAI.templateUrl,
        "https://your_resource_name.openai.azure.com/openai/deployments/your_deployment_name/THIS_IS_A_PLACEHOLDER_FOR_ENDPOINTS?api-version=2023-06-01",
      );
    });
  });

  //! Testing only one method from AzureOpenAI class is enough because all its methods rely on the original OpenAI class.

  group('completion (Read code comment above)', () {
    test('create', () async {
      AzureOpenAI.apiKey = azureApiKey;

      final response = await AzureOpenAI.instance.completion.create(
        prompt: "Hello, my name is",
        maxTokens: 5,
      );

      expect(response, isA<OpenAICompletionModel>());
    });
  });
}
