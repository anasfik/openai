class EvalRunDataSource {
  final String type;

  EvalRunDataSource({
    required this.type,
  });

  static EvalRunDataSource jsonl({
    // TODO:
    required Map<String, dynamic> source,
  }) {
    return JsonlRunDataSource(
      source: source,
    );
  }

  static EvalRunDataSource completions({
    // TODO:
    required Map<String, dynamic> source,
    // TODO:
    required Map<String, dynamic> inputMessages,
    required String model,

    // TODO:
    required Map<String, dynamic> samplingParams,
  }) {
    return CompletionsRunDataSource(
      inputMessages: inputMessages,
      model: model,
      samplingParams: samplingParams,
      source: source,
    );
  }

  static EvalRunDataSource responses({
    // TODO:
    required Map<String, dynamic> source,
    // TODO:
    required Map<String, dynamic> inputMessages,
    required String model,

    // TODO:
    required Map<String, dynamic> samplingParams,
  }) {
    return ResponsesRunDataSource(
      inputMessages: inputMessages,
      model: model,
      samplingParams: samplingParams,
      source: source,
    );
  }

  static EvalRunDataSource fromMap(Map<String, dynamic> map) {
    switch (map['type']) {
      case 'jsonl':
        return EvalRunDataSource.jsonl(
          source: Map<String, dynamic>.from(map['source'] ?? {}),
        );
      case 'completions':
        return EvalRunDataSource.completions(
          source: Map<String, dynamic>.from(map['source'] ?? {}),
          inputMessages: Map<String, dynamic>.from(map['input_messages'] ?? {}),
          model: map['model'] ?? '',
          samplingParams:
              Map<String, dynamic>.from(map['sampling_params'] ?? {}),
        );
      case 'responses':
        return EvalRunDataSource.responses(
          source: Map<String, dynamic>.from(map['source'] ?? {}),
          inputMessages: Map<String, dynamic>.from(map['input_messages'] ?? {}),
          model: map['model'] ?? '',
          samplingParams:
              Map<String, dynamic>.from(map['sampling_params'] ?? {}),
        );
      default:
        throw UnimplementedError(
          'EvalRunDataSource type ${map['type']} is not implemented',
        );
    }
  }
}

class JsonlRunDataSource extends EvalRunDataSource {
  final Map<String, dynamic> source;

  JsonlRunDataSource({
    required this.source,
    super.type = 'jsonl',
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'source': source,
    };
  }
}

class CompletionsRunDataSource extends EvalRunDataSource {
  final Map<String, dynamic> source;
  final Map<String, dynamic> inputMessages;
  final String model;
  final Map<String, dynamic> samplingParams;

  CompletionsRunDataSource({
    super.type = 'completions',
    required this.source,
    required this.inputMessages,
    required this.model,
    required this.samplingParams,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'source': source,
      'input_messages': inputMessages,
      'model': model,
      'sampling_params': samplingParams,
    };
  }
}

class ResponsesRunDataSource extends EvalRunDataSource {
  final Map<String, dynamic> source;
  final Map<String, dynamic> inputMessages;
  final String model;
  final Map<String, dynamic> samplingParams;

  ResponsesRunDataSource({
    super.type = 'responses',
    required this.source,
    required this.inputMessages,
    required this.model,
    required this.samplingParams,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'source': source,
      'input_messages': inputMessages,
      'model': model,
      'sampling_params': samplingParams,
    };
  }
}
