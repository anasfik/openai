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
  final Map<String, dynamic> parametersSchema;

  const OpenAIFunctionModel({
    required this.name,
    required this.parametersSchema,
    this.description,
  });

  factory OpenAIFunctionModel.withParameters({
    required String name,
    String? description,
    required Iterable<OpenAIFunctionProperty> parameters,
  }) {
    return OpenAIFunctionModel(
      name: name,
      description: description,
      parametersSchema: OpenAIFunctionProperty.object(
        name: '',
        properties: parameters,
      ).typeMap(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      if (description != null) 'description': description,
      'parameters': parametersSchema,
    };
  }
}

class OpenAIFunctionProperty {
  static const functionTypeInteger = 'integer';
  static const functionTypeString = 'string';
  static const functionTypeBoolean = 'boolean';
  static const functionTypeNumber = 'number';
  static const functionTypeArray = 'array';
  static const functionTypeObject = 'object';

  final String name;
  final bool isRequired;
  final Map<String, dynamic> _typeMap;

  const OpenAIFunctionProperty({
    required this.name,
    required Map<String, dynamic> typeMap,
    this.isRequired = false,
    List<String>? requiredProperties,
  }) : _typeMap = typeMap;

  factory OpenAIFunctionProperty.primitive({
    required String name,
    String? description,
    bool isRequired = false,
    required String type,
    List<dynamic>? enumValues,
  }) {
    return OpenAIFunctionProperty(
      name: name,
      isRequired: isRequired,
      typeMap: {
        'type': type,
        if (description != null) 'description': description,
        if (enumValues != null) 'enum': enumValues,
      },
    );
  }

  factory OpenAIFunctionProperty.string({
    required String name,
    String? description,
    bool isRequired = false,
    List<String>? enumValues,
  }) {
    return OpenAIFunctionProperty.primitive(
      name: name,
      isRequired: isRequired,
      type: functionTypeString,
      description: description,
      enumValues: enumValues,
    );
  }

  factory OpenAIFunctionProperty.boolean({
    required String name,
    String? description,
    bool isRequired = false,
  }) {
    return OpenAIFunctionProperty.primitive(
      name: name,
      isRequired: isRequired,
      type: functionTypeBoolean,
      description: description,
    );
  }

  factory OpenAIFunctionProperty.integer({
    required String name,
    String? description,
    bool isRequired = false,
  }) {
    return OpenAIFunctionProperty.primitive(
      name: name,
      isRequired: isRequired,
      type: functionTypeInteger,
      description: description,
    );
  }

  factory OpenAIFunctionProperty.number({
    required String name,
    String? description,
    bool isRequired = false,
  }) {
    return OpenAIFunctionProperty.primitive(
      name: name,
      isRequired: isRequired,
      type: functionTypeNumber,
      description: description,
    );
  }

  factory OpenAIFunctionProperty.array({
    required String name,
    String? description,
    bool isRequired = false,
    required OpenAIFunctionProperty items,
  }) {
    return OpenAIFunctionProperty(
      name: name,
      typeMap: {
        'type': functionTypeArray,
        if (description != null) 'description': description,
        'items': items._typeMap,
      },
      isRequired: isRequired,
    );
  }

  factory OpenAIFunctionProperty.object({
    required String name,
    String? description,
    required Iterable<OpenAIFunctionProperty> properties,
    bool isRequired = false,
  }) {
    final requiredProperties = properties
        .where((property) => property.isRequired)
        .map((property) => property.name)
        .toList(growable: false);

    return OpenAIFunctionProperty(
      name: name,
      typeMap: {
        'type': functionTypeObject,
        if (description != null) 'description': description,
        'properties': Map.fromEntries(
          properties.map(
            (property) => property.typeEntry(),
          ),
        ),
        'required': requiredProperties,
      },
      isRequired: isRequired,
    );
  }

  @override
  int get hashCode {
    return name.hashCode ^ _typeMap.hashCode;
  }

  MapEntry<String, Map<String, dynamic>> typeEntry() {
    return MapEntry(name, _typeMap);
  }

  Map<String, dynamic> typeMap() {
    return _typeMap;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      ..._typeMap,
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
