import 'package:http/http.dart' as http;

abstract class RetrieveInterface {
  Future retrieve(
    String fineTuneId, {
    http.Client? client,
  });
}
