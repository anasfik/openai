import 'package:openai/src/instance/openai.dart';

void main() async {
  OpenAI.apiKey = "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";
  final models = await OpenAI.instance.model.list();
  final model = await OpenAI.instance.model.one(models.first.id);
  print(model.id);
}
