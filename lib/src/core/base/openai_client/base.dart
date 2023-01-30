abstract class OpenAIClientBase<T> implements Initialization {}

abstract class Initialization {
  void initialize(String apiKey);
}
