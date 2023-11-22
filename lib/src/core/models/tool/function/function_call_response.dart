// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

/// {@template function_call_response}
///  This class is used to represent an OpenAI function call response.
/// {@endtemplate}
@immutable
class FunctionCallResponse {
  /// The name of the function that the model wants to call.
  final String? name;

  /// The arguments that the model wants to pass to the function.
  final Map<String, dynamic>? arguments;

  /// Weither the response have a name.
  bool get haveName => name != null;

  /// Weither the response have arguments.
  bool get haveArguments => arguments != null;

  @override
  int get hashCode => name.hashCode ^ arguments.hashCode;

  /// {@macro function_call_response}
  const FunctionCallResponse({
    required this.name,
    required this.arguments,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [FunctionCallResponse] object.
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

  /// This method is used to convert a [FunctionCallResponse] object to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'arguments': json.encode(arguments),
    };
  }

  @override
  String toString() =>
      'FunctionCallResponse(name: $name, arguments: $arguments)';

  @override
  bool operator ==(covariant FunctionCallResponse other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other.name == name && mapEquals(other.arguments, arguments);
  }
}
