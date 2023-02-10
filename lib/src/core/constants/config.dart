import 'package:meta/meta.dart';

@immutable
@internal
abstract class OpenAIConfig {
  static String get baseUrl => "https://api.openai.com";
  static String get version => "v1";
}
