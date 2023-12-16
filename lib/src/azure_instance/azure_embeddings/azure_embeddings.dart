import '../../../dart_openai.dart';

base class AzureOpenAIEmbedding {
  Future<OpenAIEmbeddingsModel> get({
    required input,
    String? user,
  }) {
    return OpenAI.instance.embedding.create(
      model: null,
      input: input,
      user: user,
    );
  }
}
