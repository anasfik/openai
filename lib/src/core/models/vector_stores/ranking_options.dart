class OpenAIVectorStoresRankingOptions {
  final String? ranker;
  final num? scoreThreshold;

  OpenAIVectorStoresRankingOptions({
    this.ranker,
    this.scoreThreshold,
  });

  Map<String, dynamic> toMap() {
    return {
      if (ranker != null) 'ranker': ranker,
      if (scoreThreshold != null) 'score_threshold': scoreThreshold,
    };
  }
}
