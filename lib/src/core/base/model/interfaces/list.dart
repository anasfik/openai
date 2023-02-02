import '../../../models/model/model.dart';

abstract class ListInterface {
  Future<List<OpenAIModelModel>> list();
}
