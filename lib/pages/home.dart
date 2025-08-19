import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/counter.dart';
import 'package:hello_flutter/pages/form.dart';
import 'package:hello_flutter/pages/listScreen.dart';
import 'package:hello_flutter/pages/todo.dart';

// 🟢 Screen 1: Home
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 🔹 Controller = like useRef in React for input fields
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Enter your name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Go to Counter"),
              onPressed: () {
                final name = _nameController.text;
                // 🔹 Pass "name" to CounterScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CounterScreen(username: name),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Go to Form"),
              onPressed: () {
                final name = _nameController.text;
                // 🔹 Pass "name" to CounterScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Go to Static List"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Go to Todo App"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TodoScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
