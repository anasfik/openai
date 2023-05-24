import 'package:dart_openai/src/core/models/edit/edit.dart';
import 'package:meta/meta.dart';

import '../../core/base/edits/edits.dart';
import '../../core/builder/base_api_url.dart';
import '../../core/constants/strings.dart';
import '../../core/networking/client.dart';
import '../../core/utils/logger.dart';

import 'package:http/http.dart' as http;

/// {@template openai_edits}
/// The class that handles all the requests related to the edits in the OpenAI API.
/// {@endtemplate}
@immutable
@protected
interface class OpenAIEdits implements OpenAIEditsBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.edits;

  /// {@macro openai_edits}
  OpenAIEdits() {
    OpenAILogger.logEndpoint(endpoint);
  }

  /// Given a [prompt] and an instruction, this method will return an edited version of the prompt.
  ///
  /// [model] is id of the model to use. You can use the `text-davinci-edit-001` or `code-davinci-edit-001` model with this method.
  ///
  /// [input] is the input text to use as a starting point for the edit.
  ///
  /// [instruction] is the instruction that tells the model how to edit the prompt.
  ///
  /// [n] defines how many edits to generate for the input and instruction.
  ///
  /// [temperature] defines what sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
  ///
  /// [topP] defines an alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
  ///
  ///
  /// Example:
  ///```dart
  /// OpenAIEditModel edit = await OpenAI.instance.edit.create(
  ///   model: "text-davinci-edit-001";
  ///   instruction: "remote all '!'from input text",
  ///   input: "Hello!!, I! need to be ! somethi!ng"
  ///   n: 1,
  ///   temperature: 0.8,
  /// );
  ///```
  @override
  Future<OpenAIEditModel> create({
    required String model,
    String? input,
    required String? instruction,
    int? n,
    double? temperature,
    double? topP,
    http.Client? client,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIEditModel>(
      to: BaseApiUrlBuilder.build(endpoint),
      body: {
        "model": model,
        "instruction": instruction,
        if (input != null) "input": input,
        if (n != null) "n": n,
        if (temperature != null) "temperature": temperature,
        if (topP != null) "top_p": topP,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIEditModel.fromMap(response);
      },
    );
  }
}
