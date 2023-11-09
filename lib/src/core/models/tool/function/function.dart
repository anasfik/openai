import 'dart:convert';

import 'property.dart';
export 'property.dart';

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

  factory OpenAIFunctionModel.fromMap(Map<String, dynamic> map) {
    return OpenAIFunctionModel(
      name: map['name'],
      parametersSchema: jsonDecode(map['arguments']) as Map<String, dynamic>,
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
