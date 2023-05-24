import '../../../models/file/file.dart';

import 'package:http/http.dart' as http;

abstract class ListInterface {
  Future<List<OpenAIFileModel>> list({
    http.Client? client,
  });
}
