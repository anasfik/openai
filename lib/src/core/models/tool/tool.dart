import 'package:meta/meta.dart';
import 'function/function.dart';
export 'function/function.dart';

@immutable
class OpenAIToolModel {
  final String type;
  final OpenAIFunctionModel function;

  const OpenAIToolModel({
    required this.type,
    required this.function,
  });

  factory OpenAIToolModel.fromMap(Map<String, dynamic> map) {
    return OpenAIToolModel(
      type: map['type'],
      function: OpenAIFunctionModel.fromMap(map['function']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'function': function.toMap(),
    };
  }
}
