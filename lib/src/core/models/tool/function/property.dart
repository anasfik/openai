/// {@template openai_function_property}
/// This class is used to represent an OpenAI function property.
/// {@endtemplate}
class OpenAIFunctionProperty {
  /// an integer type.
  static const functionTypeInteger = 'integer';

  /// A string type.
  static const functionTypeString = 'string';

  /// A boolean type.
  static const functionTypeBoolean = 'boolean';

  /// A number type.
  static const functionTypeNumber = 'number';

  /// An array (List) type.
  static const functionTypeArray = 'array';

  /// An object (Map) type.
  static const functionTypeObject = 'object';

  /// The name of the property.
  final String name;

  /// Weither the property is required.
  final bool isRequired;

  /// The type of the property.
  final Map<String, dynamic> _typeMap;

  @override
  int get hashCode {
    return name.hashCode ^ _typeMap.hashCode ^ isRequired.hashCode;
  }

  /// {@macro openai_function_property}
  const OpenAIFunctionProperty({
    required this.name,
    required Map<String, dynamic> typeMap,
    this.isRequired = false,
    List<String>? requiredProperties,
  }) : _typeMap = typeMap;

  /// {@macro openai_function_property}
  /// This a factory constructor that allows you to create a new function property with a primitive type.
  factory OpenAIFunctionProperty.primitive({
    required String name,
    String? description,
    bool isRequired = false,
    required String type,
    List? enumValues,
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

  /// {@macro openai_function_property}
  /// This a factory constructor that allows you to create a new function property with a string type.
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

  /// {@macro openai_function_property}
  /// This a factory constructor that allows you to create a new function property with a boolean type.
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

  /// {@macro openai_function_property}
  /// This a factory constructor that allows you to create a new function property with an integer type.
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

  /// {@macro openai_function_property}
  /// This a factory constructor that allows you to create a new function property with a number type.
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

  /// {@macro openai_function_property}
  /// This a factory constructor that allows you to create a new function property with an array (List) type.
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

  /// {@macro openai_function_property}
  /// This a factory constructor that allows you to create a new function property with an object (Map) type.
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

  /// The type entry of the property.
  MapEntry<String, Map<String, dynamic>> typeEntry() {
    return MapEntry(name, _typeMap);
  }

  /// The type map of the property.
  Map<String, dynamic> typeMap() {
    return _typeMap;
  }

  /// This method is used to convert a [OpenAIFunctionProperty] object to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      ..._typeMap,
    };
  }
}
