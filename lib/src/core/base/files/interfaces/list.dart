import '../../../models/file.dart';

abstract class ListInterface {
  Future<List<OpenAIFileModel>> list();
}
