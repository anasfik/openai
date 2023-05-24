import 'package:dart_openai/src/core/models/fine_tune/sub_models/event.dart';

import 'package:http/http.dart' as http;

abstract class EventsInterface {
  Future<List<OpenAIFineTuneEventModel>> listEvents(
    String fineTuneId, {
    http.Client? client,
  });
}
