import 'package:openai/src/core/models/edit/edit.dart';

import '../../core/base/edits/edits.dart';
import '../../core/builder/base_api_url.dart';
import '../../core/networking/client.dart';
import '../../core/utils/logger.dart';

class OpenAIEdits implements OpenAIEditsBase {
  @override
  String get endpoint => "/edits";

  /// This function creates an edit based on a specific instruction you need to give.
  /// Example:
  ///```dart
  /// OpenAIEditModel edit = await OpenAI.instance.edit.create(
  ///   model: "text-davinci-edit-001";
  ///   instruction: "remote all '!'from input text",
  ///   input: "Hello!!, I! need to be ! somethi!ng"
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
        return OpenAIEditModel.fromJson(response);
      },
    );
  }

  OpenAIEdits() {
    OpenAILogger.logEndpoint(endpoint);
  }
}
