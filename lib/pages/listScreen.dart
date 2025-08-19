import 'package:flutter/material.dart';

// 🟢 Screen 4: Static List
class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  // 🔹 A static list (like a hardcoded array in React)
  final List<String> items = const [
    "Learn Flutter",
    "Build a Todo App",
    "Master Dart",
    "Explore State Management",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Static List")),
      body: ListView(
        children: [
          for (var item in items)
            ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: Text(item),
            ),
        ],
      ),
    );
  }
}
