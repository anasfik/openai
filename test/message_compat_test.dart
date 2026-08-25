import 'package:dart_openai/dart_openai.dart';
import 'package:test/test.dart';

void main() {
  group('message content compatibility (#189)', () {
    test('single text item serializes as a bare string', () {
      final message = OpenAIChatCompletionChoiceMessageModel.textContent(
        role: OpenAIChatMessageRole.user,
        text: 'plain hello',
      );

      final map = message.toMap();
      expect(map['content'], 'plain hello');
      expect(map['content'], isA<String>());
    });

    test('parses legacy providers that return string content', () {
      final message = OpenAIChatCompletionChoiceMessageModel.fromMap({
        'role': 'assistant',
        'content': 'hello back',
      });

      expect(message.content?.single.text, 'hello back');
    });

    test('multi-item content still serializes as a list', () {
      final message = OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.user,
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text('look'),
          OpenAIChatCompletionChoiceMessageContentItemModel.imageUrl(
            'https://example.com/cat.png',
          ),
        ],
      );

      expect(message.toMap()['content'], isA<List<dynamic>>());
    });
  });
}
