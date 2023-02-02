import '../../../models/file/file.dart';

abstract class ListInterface {
  Future<List<OpenAIFileModel>> list();
}
