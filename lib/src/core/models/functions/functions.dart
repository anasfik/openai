import 'dart:convert';

import 'package:meta/meta.dart';

@immutable
class OpenAIFunctionModel {
  /// The name of the function to be called. Must be a-z, A-Z, 0-9, or contain
  /// underscores and dashes, with a maximum length of 64.
  final String name;

  /// The description of what the function does.
  final String? description;

  /// The parameters the functions accepts, described as a
  /// [JSON Schema](https://json-schema.org/understanding-json-schema) object.
  final OpenAIFunctionParameters? parameters;

  const OpenAIFunctionModel({
    required this.name,
    this.description,
    this.parameters,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      if (description != null) 'description': description,
      if (parameters != null) 'parameters': parameters!.toMap(),
    };
  }
}

class OpenAIFunctionParameters {
  final Map<String, dynamic> _map;

  const OpenAIFunctionParameters(Map<String, dynamic> parametersSchema)
      : _map = parametersSchema;

  factory OpenAIFunctionParameters.fromProperties(
    Iterable<OpenAIFunctionProperty> properties,
  ) {
    final requiredProperties = properties
        .where((property) => property.isRequired)
        .map((property) => property.name)
        .toList(growable: false);

    return OpenAIFunctionParameters({
      'type': 'object',
      'properties': {
        for (final property in properties) property.name: property.toMap(),
      },
      'required': requiredProperties,
    });
  }

  Map<String, dynamic> toMap() {
    return _map;
  }
}

class OpenAIFunctionProperty {
  static const functionTypeInteger = 'integer';
  static const functionTypeString = 'string';
  static const functionTypeBoolean = 'boolean';
  static const functionTypeFloat = 'float';

  final String name;
  final String? type;
  final String? description;
  final List<String>? enumValues;
  final bool isRequired;

  @override
  int get hashCode {
    return name.hashCode ^
        type.hashCode ^
        description.hashCode ^
        enumValues.hashCode;
  }

  const OpenAIFunctionProperty({
    required this.name,
    this.type,
    this.description,
    this.isRequired = false,
    this.enumValues,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      if (type != null) 'type': type,
      if (description != null) 'description': description,
      if (enumValues != null) 'enum': enumValues,
    };
  }
}

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

@immutable
class FunctionCallResponse {
  /// The name of the function that the model wants to call.
  final String name;

  /// The arguments that the model wants to pass to the function.
  final Map<String, dynamic> arguments;

  const FunctionCallResponse({
    required this.name,
    required this.arguments,
  });

  factory FunctionCallResponse.fromMap(Map<String, dynamic> map) {
    return FunctionCallResponse(
      name: map['name'],
      arguments: json.decode(map['arguments']),
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
