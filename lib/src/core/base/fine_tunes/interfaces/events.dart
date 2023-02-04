import 'package:dart_openai/src/core/models/fine_tune/sub_models/event.dart';

abstract class EventsInterface {
  Future<List<OpenAIFineTuneEventModel>> listEvents(String fineTuneId);
}
