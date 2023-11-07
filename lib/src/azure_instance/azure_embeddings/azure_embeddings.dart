import '../../../dart_openai.dart';
import '../../instance/embedding/embedding.dart';

base class AzureOpenAIEmbedding extends OpenAIEmbedding {
  Future<OpenAIEmbeddingsModel> get({
    required input,
    String? user,
  }) {
    return super.create(
      model: null,
      input: input,
      user: user,
    );
  }
}
