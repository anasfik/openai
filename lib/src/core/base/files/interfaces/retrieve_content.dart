import 'package:http/http.dart' as http;

abstract class RetrieveContentInterface {
  Future retrieveContent(
    String fileId, {
    http.Client? client,
  });
}
