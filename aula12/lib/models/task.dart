class Task {
  int? id;
  String title;
  String description;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }

  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description, status: $status, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
