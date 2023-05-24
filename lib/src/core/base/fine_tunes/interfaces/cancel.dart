import '../../../models/fine_tune/fine_tune.dart';

import 'package:http/http.dart' as http;

abstract class CancelInterface {
  Future<OpenAIFineTuneModel> cancel(
    String fineTuneId, {
    http.Client? client,
  });
}
