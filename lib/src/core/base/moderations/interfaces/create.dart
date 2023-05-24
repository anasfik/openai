import '../../../models/moderation/moderation.dart';

import 'package:http/http.dart' as http;

abstract class CreateInterface {
  Future<OpenAIModerationModel> create({
    required String input,
    String? model,
    http.Client? client,
  });
}
