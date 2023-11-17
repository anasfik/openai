// ignore_for_file: public_member_api_docs, sort_constructors_first
class OpenAIResponseFunction {
  final String? name;
  final arguments;

  OpenAIResponseFunction({
    required this.name,
    required this.arguments,
  });

  factory OpenAIResponseFunction.fromMap(Map<String, dynamic> map) {
    return OpenAIResponseFunction(
      name: map['name'],
      arguments: map['arguments'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "arguments": arguments,
    };
  }
}
