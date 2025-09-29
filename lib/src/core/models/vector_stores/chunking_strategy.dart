class OpenAIVectorStoreChunkingStrategy {
  final String type;
  OpenAIVectorStoreChunkingStrategy({
    required this.type,
  });

  factory OpenAIVectorStoreChunkingStrategy.auto() {
    return AutoOpenAIVectorStoreChunkingStrategy();
  }

  factory OpenAIVectorStoreChunkingStrategy.static({
    required int chunkOverlapTokens,
    required int maxChunkSizeTokens,
  }) {
    return StaticOpenAIVectorStoreChunkingStrategy(
      static: StaticOpenAIVectorStoreChunkingStrategyStatic(
        chunkOverlapTokens: chunkOverlapTokens,
        maxChunkSizeTokens: maxChunkSizeTokens,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
    };
  }
}

class AutoOpenAIVectorStoreChunkingStrategy
    extends OpenAIVectorStoreChunkingStrategy {
  AutoOpenAIVectorStoreChunkingStrategy({
    super.type = 'auto',
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
    };
  }
}

class StaticOpenAIVectorStoreChunkingStrategy
    extends OpenAIVectorStoreChunkingStrategy {
  final StaticOpenAIVectorStoreChunkingStrategyStatic static;
  StaticOpenAIVectorStoreChunkingStrategy({
    super.type = 'static',
    required this.static,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'static': static.toMap(),
    };
  }
}

class StaticOpenAIVectorStoreChunkingStrategyStatic {
  final int chunkOverlapTokens;
  final int maxChunkSizeTokens;

  StaticOpenAIVectorStoreChunkingStrategyStatic({
    required this.chunkOverlapTokens,
    required this.maxChunkSizeTokens,
  });

  Map<String, dynamic> toMap() {
    return {
      'chunk_overlap_tokens': chunkOverlapTokens,
      'max_chunk_size_tokens': maxChunkSizeTokens,
    };
  }
}
