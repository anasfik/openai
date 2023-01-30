import 'package:openai/src/instance/openai.dart';

void main() async {
  OpenAI.apiKey = "YOUR KEY";
  OpenAI.organization = "YOUR ORGANIZATION ID";
  final models = await OpenAI.instance.model.list();
  final model = await OpenAI.instance.model.one(models.first.id);
  print(model.id);
}
