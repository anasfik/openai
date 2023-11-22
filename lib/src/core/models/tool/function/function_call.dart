import 'package:meta/meta.dart';

/// {@template function_call}
/// Controls how the model responds to function calls.
/// {@endtemplate}
@immutable
class FunctionCall {
  /// Force the model to respond to the end-user instead of calling a function.
  static const none = FunctionCall._(value: 'none');

  /// The model can pick between an end-user or calling a function.
  static const auto = FunctionCall._(value: 'auto');

  /// The value of the function call.
  final value;

  @override
  int get hashCode => value.hashCode;

  /// {@macro function_call}
  const FunctionCall._({required this.value});

  /// Specifying a particular function forces the model to call that function.
  factory FunctionCall.forFunction(String functionName) {
    return FunctionCall._(value: {
      'name': functionName,
    });
  }

  @override
  String toString() => value.toString();

  @override
  bool operator ==(covariant FunctionCall other) {
    if (identical(this, other)) return true;

    return other.value == value;
  }
}
