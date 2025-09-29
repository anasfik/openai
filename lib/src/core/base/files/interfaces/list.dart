import 'package:dart_openai/src/core/models/file/file_list.dart';

import 'package:http/http.dart' as http;

abstract class ListInterface {
  Future<OpenAIFileListModel> list({
    String? after,
    int? limit,
    String? order,
    String? purpose,
    http.Client? client,
  });
}
