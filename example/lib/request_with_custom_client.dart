import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

import 'package:http/http.dart' as http;

Future<void> main() async {
  /// Set the API key to be used in requests.
  OpenAI.apiKey = Env.apiKey;

  /// THe custom client that will be used in the next request.
  final httpClient = http.Client();

  /// We sent the request to get the list of all models.
  final modelsUsingCUstomClient = await OpenAI.instance.model.list(
    client: httpClient,
  );

  /// printing the IDs of all models retrieved form the request.
  print(
    modelsUsingCUstomClient
        .map((modelItem) => modelItem.id)
        .toList()
        .join("\n"),
  );
}
