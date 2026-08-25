import 'package:http/http.dart' as http;

import '../../../models/export.dart';

abstract class StreamListInterface {
  Stream<OpenAIFineTuneEventStreamModel> listEventsStream(
    String fineTuneId, {
    http.Client? client,
  });
}
