// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'property.dart';

export 'property.dart';

/// {@template openai_function_model}
/// This class is used to represent an OpenAI function.
/// {@endtemplate}
class OpenAIFunctionModel {
  /// The name of the function to be called. Must be a-z, A-Z, 0-9, or contain
  /// underscores and dashes, with a maximum length of 64.
  final String name;

  /// The description of what the function does.
  final String? description;

  /// The parameters the functions accepts, described as a
  /// [JSON Schema](https://json-schema.org/understanding-json-schema) object.
  final Map<String, dynamic> parametersSchema;

  /// Weither the function have a description.
  bool get haveDescription => description != null;

  @override
  int get hashCode =>
      name.hashCode ^ description.hashCode ^ parametersSchema.hashCode;

  /// {@macro openai_function_model}
  const OpenAIFunctionModel({
    required this.name,
    required this.parametersSchema,
    this.description,
  });

  /// {@macro openai_function_model}
  /// This a factory constructor that allows you to create a new function with valid parameters schema.
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

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIFunctionModel] object.
  factory OpenAIFunctionModel.fromMap(Map<String, dynamic> map) {
    return OpenAIFunctionModel(
      name: map['name'],
      parametersSchema: jsonDecode(map['arguments']) as Map<String, dynamic>,
    );
  }

  /// This method is used to convert a [OpenAIFunctionModel] object to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      if (description != null) 'description': description,
      'parameters': parametersSchema,
    };
  }

  @override
  String toString() =>
      'OpenAIFunctionModel(name: $name, description: $description, parametersSchema: $parametersSchema)';

  @override
  bool operator ==(covariant OpenAIFunctionModel other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other.name == name &&
        other.description == description &&
        mapEquals(other.parametersSchema, parametersSchema);
  }
}
