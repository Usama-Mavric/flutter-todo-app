import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';

class TodoProvider with ChangeNotifier {
  final TodoService _service = TodoService();
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  TodoProvider() {
    _loadTodos(); // load when provider is created
  }

  void _loadTodos() async {
    _todos = await _service.loadTodos();
    notifyListeners();
  }

  void addTodo(String title) {
    _todos.add(Todo(title: title));
    _saveTodos();
  }

  void toggleDone(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    _saveTodos();
  }

  void deleteTodo(int index) {
    _todos.removeAt(index);
    _saveTodos();
  }

  void _saveTodos() {
    _service.saveTodos(_todos);
    notifyListeners();
  }
}
