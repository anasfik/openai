class OpenAIContainerContainerFile {
  final String id;
  final String containerId;
  final String path;
  final int bytes;
  final int createdAt;
  final String source;

  OpenAIContainerContainerFile({
    required this.id,
    required this.containerId,
    required this.path,
    required this.bytes,
    required this.createdAt,
    required this.source,
  });

  factory OpenAIContainerContainerFile.fromMap(Map<String, dynamic> json) {
    return OpenAIContainerContainerFile(
      id: json['id'],
      containerId: json['container_id'],
      path: json['path'],
      bytes: json['bytes'],
      createdAt: json['created_at'],
      source: json['source'],
    );
  }
}
