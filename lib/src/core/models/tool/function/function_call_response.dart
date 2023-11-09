import 'dart:convert';

import 'package:meta/meta.dart';

@immutable
class FunctionCallResponse {
  /// The name of the function that the model wants to call.
  final String? name;

  /// The arguments that the model wants to pass to the function.
  final Map<String, dynamic>? arguments;

  const FunctionCallResponse({
    required this.name,
    required this.arguments,
  });

  factory FunctionCallResponse.fromMap(Map<String, dynamic> map) {
    final argsField = map['arguments'];

    Map<String, dynamic> arguments;

    try {
      arguments = jsonDecode(argsField);
    } catch (e) {
      arguments = {};
    }

    return FunctionCallResponse(
      name: map['name'],
      arguments: arguments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'arguments': json.encode(arguments),
    };
  }

  @override
  String toString() =>
      'FunctionCallResponse(name: $name, arguments: $arguments)';
}
