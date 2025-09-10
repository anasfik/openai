import 'package:dart_openai/src/core/models/responses/responses.dart';

abstract class CancelInterface {
  Future<OpenAIResponseModel> cancel({
    required String responseId,
  });
}
