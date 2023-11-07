import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  // Set your API key
  AzureOpenAI.apiKey = Env.apiKey;

  // Set your resource name and deployment name
  AzureOpenAI.configureRestAPI(
    yourResourceName: "your_resource_name",
    yourDeploymentName: "your_deployment_name",
    apiVersion: DateTime(2023, 06, 01),
  );

  // See your configured template URL.
  print(AzureOpenAI.templateUrl);

  // Create chat completion.
  final chatCompletion = await AzureOpenAI.instance.chat.create(
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.user,
        content: "Say hi!",
      ),
    ],
  );

  // Print the response.
  print(chatCompletion.choices.first.message.content);
}
