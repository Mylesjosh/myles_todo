class Task {
  final String title;
  bool isCompleted = false;
  final String description;

  Task({required this.title, required this.isCompleted, this.description = ''});

  void isDone() {
    isCompleted = !isCompleted;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'description': description,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      isCompleted: json['isCompleted'],
      description: json['description'] ?? '',
    );
  }
}
