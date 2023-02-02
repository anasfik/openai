import 'package:openai/openai.dart';
import 'package:test/test.dart';

void main() {
  group('authentication', () {
    test('without setting a key', () {
      try {
        OpenAI.instance;
      } catch (e) {
        expect(e, isA<MissingApiKeyException>());
      }
    });
    test('with setting a key', () {
      OpenAI.apiKey = "YOUR KEY";
      expect(OpenAI.instance, isA<OpenAI>());
    });
  });
}
