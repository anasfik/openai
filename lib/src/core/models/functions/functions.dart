import 'dart:convert';

import 'package:meta/meta.dart';

@immutable
class OpenAiFunctionModel {
  final String name;
  final String? description;
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
  OpenAiFunctionParameters({
    this.type = 'object',
    required this.properties,
  });

  Map<String, dynamic> toMap() {
    final requiredProperties = properties
        .where((property) => property.isRequired)
        .map((property) => property.name)
        .toList();
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

@immutable
class FunctionCall {
  static const none = FunctionCall._(value: 'none');
  static const auto = FunctionCall._(value: 'auto');

  final dynamic value;

  const FunctionCall._({required this.value});

  factory FunctionCall.forFunction(String functionName) {
    return FunctionCall._(value: {
      'name': functionName,
    });
  }
}

@immutable
class FunctionCallResponse {
  final String name;
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

  @override
  String toString() =>
      'FunctionCallResponse(name: $name, arguments: $arguments)';
}
