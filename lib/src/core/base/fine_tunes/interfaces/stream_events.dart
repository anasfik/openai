import '../../../models/export.dart';

import 'package:http/http.dart' as http;

abstract class StreamListInterface {
  Stream<OpenAIFineTuneEventStreamModel> listEventsStream(
    String fineTuneId, {
    http.Client? client,
  });
}
