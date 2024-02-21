// ignore_for_file: public_member_api_docs, sort_constructors_first
/// {@template openai_chat_completion_response_function_model}
/// This represents the response function of the [OpenAIChatCompletionChoiceMessageModel] model of the OpenAI API, which is used in the [OpenAIChat] methods.
/// {@endtemplate}
class OpenAIResponseFunction {
  /// The name of the function.
  final String? name;

  /// The arguments of the function.
  final arguments;

  //! Not sure if the arguments will always be a Map<String, dynamic>, if you do confirm it from OpenAI docs please open an issue.

  /// Weither the function have a name or not.
  bool get hasName => name != null;

  /// Weither the function have arguments or not.
  bool get hasArguments => arguments != null;

  @override
  int get hashCode => name.hashCode ^ arguments.hashCode;

  /// {@macro openai_chat_completion_response_function_model}
  OpenAIResponseFunction({
    required this.name,
    required this.arguments,
  });

  /// This method used to convert a [Map<String, dynamic>] object to a [OpenAIResponseFunction] object.
  factory OpenAIResponseFunction.fromMap(Map<String, dynamic> map) {
    return OpenAIResponseFunction(
      name: map['name'],
      arguments: map['arguments'],
    );
  }

  /// This method used to convert the [OpenAIResponseFunction] to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "arguments": arguments,
    };
  }

  @override
  String toString() =>
      'OpenAIResponseFunction(name: $name, arguments: $arguments)';

  @override
  bool operator ==(covariant OpenAIResponseFunction other) {
    if (identical(this, other)) return true;

    return other.name == name && other.arguments == arguments;
  }
}
