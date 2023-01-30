import '../../../models/model.dart';

abstract class ListInterface {
  Future<List<OpenAIModelModel>> list();
}
