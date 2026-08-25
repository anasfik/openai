import 'package:http/http.dart' as http;

import '../../../models/model/model.dart';

abstract class ListInterface {
  Future<List<OpenAIModelModel>> list({
    http.Client? client,
  });
}
