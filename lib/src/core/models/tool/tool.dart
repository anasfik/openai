// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:meta/meta.dart';

import 'function/function.dart';

export 'function/function.dart';

/// {@template openai_tool_model}
///  This class is used to represent an OpenAI tool.
/// {@endtemplate}
@immutable
class OpenAIToolModel {
  /// The type of the tool.
  final String type;

  /// The function of the tool.
  final OpenAIFunctionModel function;

  @override
  int get hashCode => type.hashCode ^ function.hashCode;

  /// {@macro openai_tool_model}
  const OpenAIToolModel({
    required this.type,
    required this.function,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIToolModel] object.
  factory OpenAIToolModel.fromMap(Map<String, dynamic> map) {
    return OpenAIToolModel(
      type: map['type'],
      function: OpenAIFunctionModel.fromMap(map['function']),
    );
  }

  /// This method is used to convert a [OpenAIToolModel] object to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'function': function.toMap(),
    };
  }

  @override
  bool operator ==(covariant OpenAIToolModel other) {
    if (identical(this, other)) return true;

    return other.type == type && other.function == function;
  }

  @override
  String toString() => 'OpenAIToolModel(type: $type, function: $function)';
}
