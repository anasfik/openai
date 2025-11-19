class OpenAIContainer {
  final String id;
  final String name;
  final String status;

  OpenAIContainer({
    required this.id,
    required this.name,
    required this.status,
  });

  factory OpenAIContainer.fromMap(Map<String, dynamic> json) {
    return OpenAIContainer(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
    };
  }
}
