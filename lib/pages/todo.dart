import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hello_flutter/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _controller = TextEditingController();

  void _addTodo(BuildContext context) {
    if (_controller.text.isNotEmpty) {
      context.read<TodoProvider>().addTodo(_controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodoProvider>().todos;
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
                ElevatedButton(
                  onPressed: () => _addTodo(context),
                  child: const Text("Add"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Todo List
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    leading: IconButton(
                      icon: Icon(
                        todo.isDone
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: todo.isDone ? Colors.green : Colors.grey,
                      ),
                      onPressed: () =>
                          context.read<TodoProvider>().toggleDone(index),
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
                      onPressed: () =>
                          context.read<TodoProvider>().deleteTodo(index),
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
