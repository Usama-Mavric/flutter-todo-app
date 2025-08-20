class Todo {
  String title;
  bool isDone;

  Todo({required this.title, this.isDone = false});

  // For persistence (SharedPreferences/JSON)
  Map<String, dynamic> toJson() => {"title": title, "isDone": isDone};

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(title: json["title"], isDone: json["isDone"] ?? false);
  }
}
