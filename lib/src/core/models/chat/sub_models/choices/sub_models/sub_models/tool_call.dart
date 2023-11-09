// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'sub_models/response_function_call.dart';

class OpenAIResponseToolCall {
  final String? id;
  final String? type;
  final OpenAIResponseFunction function;

  OpenAIResponseToolCall({
    required this.id,
    required this.type,
    required this.function,
  });

  factory OpenAIResponseToolCall.fromMap(Map<String, dynamic> map) {
    return OpenAIResponseToolCall(
      id: map['id'],
      type: map['type'],
      function: OpenAIResponseFunction.fromMap(map['function']),
    );
  }

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
}

class OpenAIStreamResponseToolCall extends OpenAIResponseToolCall {
  final int index;

  OpenAIStreamResponseToolCall({
    required super.id,
    required super.type,
    required super.function,
    required this.index,
  });

  factory OpenAIStreamResponseToolCall.fromMap(Map<String, dynamic> map) {
    return OpenAIStreamResponseToolCall(
      id: map['id'],
      type: map['type'],
      function: OpenAIResponseFunction.fromMap(map['function']),
      index: map['index'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "type": type,
      "function": function.toMap(),
      "index": index,
    };
  }
}
