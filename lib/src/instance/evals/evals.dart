import 'package:dart_openai/src/core/base/evals/evals.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/utils/logger.dart';

class OpenAIEvals implements OpenAIEvalsBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.evals;

  /// {@macro openai_embedding}
  OpenAIEvals() {
    OpenAILogger.logEndpoint(endpoint);
  }
}
