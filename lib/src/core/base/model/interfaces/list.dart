import '../../../models/model/model.dart';

import "package:http/http.dart" as http;

abstract class ListInterface {
  Future<List<OpenAIModelModel>> list({
    http.Client? client,
  });
}
