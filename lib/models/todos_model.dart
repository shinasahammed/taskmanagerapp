import 'dart:convert';

class Todo {
  final int userId;
  final int id;
  final String title;
  bool completed;

  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed,
    };
  }

  static String encode(List<Todo> todos) {
    return jsonEncode(
      todos.map((e) => e.toJson()).toList(),
    );
  }

  static List<Todo> decode(String todos) {
    return (jsonDecode(todos) as List)
        .map((e) => Todo.fromJson(e))
        .toList();
  }
}