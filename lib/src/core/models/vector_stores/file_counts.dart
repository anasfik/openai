class OpenAIVectorStoreFileCounts {
  final int cancelled;
  final int completed;
  final int failed;
  final int inProgress;
  final int total;

  OpenAIVectorStoreFileCounts({
    required this.cancelled,
    required this.completed,
    required this.failed,
    required this.inProgress,
    required this.total,
  });

  factory OpenAIVectorStoreFileCounts.fromMap(Map<String, dynamic> map) {
    return OpenAIVectorStoreFileCounts(
      cancelled: map['cancelled'] ?? 0,
      completed: map['completed'] ?? 0,
      failed: map['failed'] ?? 0,
      inProgress: map['in_progress'] ?? 0,
      total: map['total'] ?? 0,
    );
  }
}
