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
