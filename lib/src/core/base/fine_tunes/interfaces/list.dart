import 'package:http/http.dart' as http;

abstract class ListInterface {
  Future<List> list({
    http.Client? client,
  });
}
