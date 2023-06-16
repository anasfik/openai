import 'dart:convert';

import 'package:meta/meta.dart';

@immutable
class OpenAiFunctionModel {
  /// The name of the function to be called. Must be a-z, A-Z, 0-9, or contain
  /// underscores and dashes, with a maximum length of 64.
  final String name;

  /// The description of what the function does.
  final String? description;

  /// The parameters the functions accepts, described as a
  /// [JSON Schema](https://json-schema.org/understanding-json-schema) object.
  final OpenAiFunctionParameters? parameters;

  const OpenAiFunctionModel({
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

class OpenAiFunctionParameters {
  final String type;
  final List<OpenAiFunctionProperty> properties;
  const OpenAiFunctionParameters({
    this.type = 'object',
    required this.properties,
  });

  Map<String, dynamic> toMap() {
    final requiredProperties = properties
        .where((property) => property.isRequired)
        .map((property) => property.name)
        .toList(growable: false);
    return {
      'type': type,
      'properties': {
        for (final parameter in properties)
          parameter.name: {
            if (parameter.type != null) 'type': parameter.type,
            if (parameter.description != null)
              'description': parameter.description,
            if (parameter.enumValues != null) 'enum': parameter.enumValues,
          },
      },
      'required': requiredProperties,
    };
  }
}

class OpenAiFunctionProperty {
  static const functionTypeInteger = 'integer';
  static const functionTypeString = 'string';
  static const functionTypeBoolean = 'boolean';
  static const functionTypeFloat = 'float';

  final String name;
  final String? type;
  final String? description;
  final List<String>? enumValues;
  final bool isRequired;

  const OpenAiFunctionProperty({
    required this.name,
    this.type,
    this.description,
    this.isRequired = false,
    this.enumValues,
  });

  @override
  int get hashCode {
    return name.hashCode ^
        type.hashCode ^
        description.hashCode ^
        enumValues.hashCode;
  }
}

/// Controls how the model responds to function calls.
@immutable
class FunctionCall {
  /// Force the model to respond to the end-user instead of calling a function.
  static const none = FunctionCall._(value: 'none');

  /// The model can pick between an end-user or calling a function.
  static const auto = FunctionCall._(value: 'auto');

  final dynamic value;

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
      'arguments': arguments,
    };
  }

  @override
  String toString() =>
      'FunctionCallResponse(name: $name, arguments: $arguments)';
}
