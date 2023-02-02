import '../../../models/file/file.dart';

abstract class RetrieveInterface {
  Future<OpenAIFileModel> retrieve(String fileId);
}
