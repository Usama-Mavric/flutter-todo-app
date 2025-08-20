import 'package:flutter/material.dart';
import 'package:hello_flutter/widgets/todo_tile.dart';
import 'package:hello_flutter/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();
    final todos = provider.todos;
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Todo App"), centerTitle: true),
      body: Column(
        children: [
          // 🔹 Input Field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: "Add a new todo",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.trim().isEmpty) return;
                    provider.addTodo(controller.text.trim());
                    controller.clear();
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ),

          // 🔹 List of Todos
          Expanded(
            child: todos.isEmpty
                ? const Center(child: Text("No todos yet."))
                : ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return TodoTile(
                        todo: todo,
                        onToggle: () => provider.toggleDone(index),
                        onDelete: () => provider.deleteTodo(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
