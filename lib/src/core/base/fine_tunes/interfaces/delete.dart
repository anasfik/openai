import 'package:http/http.dart' as http;


abstract class DeleteInterface {
  Future<bool> delete(
    String fineTuneId, {
    http.Client? client,
  });
}
