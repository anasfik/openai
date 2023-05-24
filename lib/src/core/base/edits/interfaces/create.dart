import '../../../models/edit/edit.dart';

import 'package:http/http.dart' as http;

abstract class CreateInterface {
  Future<OpenAIEditModel> create({
    required String model,
    String? input,
    required String? instruction,
    int? n,
    double? temperature,
    double? topP,
    http.Client? client,
  });
}
