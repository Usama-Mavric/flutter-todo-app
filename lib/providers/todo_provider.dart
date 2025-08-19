import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // for jsonEncode / jsonDecode

class Todo {
  String title;
  bool isDone;

  Todo({required this.title, this.isDone = false});

  // ✅ Convert to/from Map for persistence
  Map<String, dynamic> toMap() {
    return {'title': title, 'isDone': isDone};
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(title: map['title'], isDone: map['isDone']);
  }
}

class TodoProvider with ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  TodoProvider() {
    _loadTodos(); // load when provider is created
  }

  void addTodo(String title) {
    _todos.add(Todo(title: title));
    _saveTodos();
    notifyListeners(); // like setState but for Provider
  }

  void toggleDone(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    _saveTodos();
    notifyListeners();
  }

  void deleteTodo(int index) {
    _todos.removeAt(index);
    _saveTodos();
    notifyListeners();
  }

  // ✅ Persistence
  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> todoList = _todos
        .map((todo) => jsonEncode(todo.toMap()))
        .toList();
    await prefs.setStringList('todos', todoList);
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? todoList = prefs.getStringList('todos');
    if (todoList != null) {
      _todos.clear();
      _todos.addAll(todoList.map((todo) => Todo.fromMap(jsonDecode(todo))));
      notifyListeners();
    }
  }
}
