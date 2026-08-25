import 'package:http/http.dart' as http;

import '../../../models/fine_tune/fine_tune.dart';

abstract class CancelInterface {
  Future<OpenAIFineTuneModel> cancel(
    String fineTuneId, {
    http.Client? client,
  });
}
