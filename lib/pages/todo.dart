import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todo {
  String title;
  bool isDone;

  Todo({required this.title, this.isDone = false});

  // Convert Todo -> Map (for JSON)
  Map<String, dynamic> toMap() {
    return {'title': title, 'isDone': isDone};
  }

  // Convert Map -> Todo
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(title: map['title'], isDone: map['isDone']);
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Todo> _todos = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos(); // Load todos when screen starts
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosJson = prefs.getString('todos');
    if (todosJson != null) {
      final List decoded = jsonDecode(todosJson);
      setState(() {
        _todos.clear();
        _todos.addAll(decoded.map((e) => Todo.fromMap(e)));
      });
    }
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String todosJson = jsonEncode(_todos.map((e) => e.toMap()).toList());
    await prefs.setString('todos', todosJson);
  }

  void _addTodo() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _todos.add(Todo(title: _controller.text));
      });
      _controller.clear();
      _saveTodos(); // save after adding
    }
  }

  void _toggleDone(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
    _saveTodos(); // save after toggling
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
    _saveTodos(); // save after deleting
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo App")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input + Add Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "Enter todo",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: _addTodo, child: const Text("Add")),
              ],
            ),
            const SizedBox(height: 20),
            // Todo List
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final todo = _todos[index];
                  return ListTile(
                    leading: IconButton(
                      icon: Icon(
                        todo.isDone
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: todo.isDone ? Colors.green : Colors.grey,
                      ),
                      onPressed: () => _toggleDone(index),
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration: todo.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTodo(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
