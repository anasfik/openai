import '../../../models/moderation/moderation.dart';

abstract class CreateInterface {
  Future<OpenAIModerationModel> create({
    required String input,
    String? model,
  });
}
