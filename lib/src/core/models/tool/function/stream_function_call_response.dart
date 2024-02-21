// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:meta/meta.dart';

/// {@template stream_function_call_response_model}
/// This class is used to represent a stream function call response.
/// {@endtemplate}
@immutable
class StreamFunctionCallResponse {
  /// The name of the function that the model wants to call.
  final String? name;

  /// The arguments that the model wants to pass to the function.
  final String? arguments;

  // Weither the function have a name or not.
  bool get hasName => name != null;

  // Weither the function have arguments or not.
  bool get hasArguments => arguments != null;

  @override
  int get hashCode => name.hashCode ^ arguments.hashCode;

  /// {@macro stream_function_call_response_model}
  const StreamFunctionCallResponse({
    required this.name,
    required this.arguments,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [StreamFunctionCallResponse] object.
  factory StreamFunctionCallResponse.fromMap(Map<String, dynamic> map) {
    return StreamFunctionCallResponse(
      name: map['name'],
      arguments: map['arguments'],
    );
  }

  /// This method is used to convert a [StreamFunctionCallResponse] object to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'arguments': arguments,
    };
  }

  @override
  String toString() =>
      'StreamFunctionCallResponse(name: $name, arguments: $arguments)';

  @override
  bool operator ==(covariant StreamFunctionCallResponse other) {
    if (identical(this, other)) return true;

    return other.name == name && other.arguments == arguments;
  }
}
