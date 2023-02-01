import '../../../models/file.dart';

abstract class RetrieveInterface {
  Future<OpenAIFileModel> retrieve(String fileId);
}
