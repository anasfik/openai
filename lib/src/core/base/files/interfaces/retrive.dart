import '../../../models/file/file.dart';
import 'package:http/http.dart' as http;
abstract class RetrieveInterface {
  Future<OpenAIFileModel> retrieve(
    String fileId, {
    http.Client? client,
  });
}
