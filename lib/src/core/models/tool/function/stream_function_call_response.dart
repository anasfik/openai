import 'package:meta/meta.dart';

@immutable
class StreamFunctionCallResponse {
  /// The name of the function that the model wants to call.
  final String? name;

  /// The arguments that the model wants to pass to the function.
  final String? arguments;

  const StreamFunctionCallResponse({
    required this.name,
    required this.arguments,
  });

  factory StreamFunctionCallResponse.fromMap(Map<String, dynamic> map) {
    return StreamFunctionCallResponse(
      name: map['name'],
      arguments: map['arguments'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'arguments': arguments,
    };
  }

  @override
  String toString() =>
      'StreamFunctionCallResponse(name: $name, arguments: $arguments)';
}
