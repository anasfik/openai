import 'package:http/http.dart' as http;

abstract class DeleteInterface {
  Future<bool> delete(
    String fileId, {
    http.Client? client,
  });
}
