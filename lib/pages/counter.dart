import 'package:flutter/material.dart';

// 🟢 Screen 2: Counter
class CounterScreen extends StatefulWidget {
  final String username; // 🔹 This is like React props

  const CounterScreen({super.key, required this.username});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello, ${widget.username} 👋",
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text("Count: $_counter", style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
