import 'package:http/http.dart' as http;

import '../../../models/file/file.dart';

abstract class RetrieveInterface {
  Future<OpenAIFileModel> retrieve(
    String fileId, {
    http.Client? client,
  });
}
