// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'sub_models/response_function_call.dart';

/// {@template openai_chat_completion_response_tool_call_model}
/// This represents the tool call of the [OpenAIChatCompletionChoiceMessageModel] model of the OpenAI API, which is used and get returned while using the [OpenAIChat] methods.
/// {@endtemplate}
class OpenAIResponseToolCall {
  /// The id of the tool call.
  final String? id;

  /// The type of the tool call.
  final String? type;

  /// The function of the tool call.
  final OpenAIResponseFunction function;

  /// Weither the tool call have an id.
  bool get haveId => id != null;

  /// Weither the tool call have a type.
  bool get haveType => type != null;

  @override
  int get hashCode => id.hashCode ^ type.hashCode ^ function.hashCode;

  /// {@macro openai_chat_completion_response_tool_call_model}
  OpenAIResponseToolCall({
    required this.id,
    required this.type,
    required this.function,
  });

  /// This is used  to convert a [Map<String, dynamic>] object to a [OpenAIResponseToolCall] object.
  factory OpenAIResponseToolCall.fromMap(Map<String, dynamic> map) {
    return OpenAIResponseToolCall(
      id: map['id'],
      type: map['type'],
      function: OpenAIResponseFunction.fromMap(map['function']),
    );
  }

  /// This method used to convert the [OpenAIResponseToolCall] to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "type": type,
      "function": function.toMap(),
    };
  }

  @override
  String toString() {
    return "OpenAIResponseToolCall(id: $id,type: $type,function: $function)";
  }

  @override
  bool operator ==(covariant OpenAIResponseToolCall other) {
    if (identical(this, other)) return true;

    return other.id == id && other.type == type && other.function == function;
  }
}

/// {@template openai_chat_completion_response_stream_tool_call_model}
/// This represents the stream tool call of the [OpenAIChatCompletionChoiceMessageModel] model of the OpenAI API, which is used and get returned while using the [OpenAIChat] methods.
/// {@endtemplate}
class OpenAIStreamResponseToolCall extends OpenAIResponseToolCall {
  /// The index of the tool call.
//! please fill an issue if it happen that the index is not an int in some cases.
  final int index;

  @override
  int get hashCode => super.hashCode ^ index.hashCode;

  /// {@macro openai_chat_completion_response_stream_tool_call_model}
  OpenAIStreamResponseToolCall({
    required super.id,
    required super.type,
    required super.function,
    required this.index,
  });

  /// This is used  to convert a [Map<String, dynamic>] object to a [OpenAIStreamResponseToolCall] object.
  factory OpenAIStreamResponseToolCall.fromMap(Map<String, dynamic> map) {
    return OpenAIStreamResponseToolCall(
      id: map['id'],
      type: map['type'],
      function: OpenAIResponseFunction.fromMap(map['function']),
      index: map['index'],
    );
  }

  /// This method used to convert the [OpenAIStreamResponseToolCall] to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "type": type,
      "function": function.toMap(),
      "index": index,
    };
  }

  @override
  bool operator ==(covariant OpenAIStreamResponseToolCall other) {
    if (identical(this, other)) return true;

    return other.index == index;
  }

  @override
  String toString() => 'OpenAIStreamResponseToolCall(index: $index})';
}
