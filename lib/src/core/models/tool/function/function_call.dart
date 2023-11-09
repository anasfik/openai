import 'package:meta/meta.dart';

/// Controls how the model responds to function calls.
@immutable
class FunctionCall {
  /// Force the model to respond to the end-user instead of calling a function.
  static const none = FunctionCall._(value: 'none');

  /// The model can pick between an end-user or calling a function.
  static const auto = FunctionCall._(value: 'auto');

  final value;

  const FunctionCall._({required this.value});

  /// Specifying a particular function forces the model to call that function.
  factory FunctionCall.forFunction(String functionName) {
    return FunctionCall._(value: {
      'name': functionName,
    });
  }
}
