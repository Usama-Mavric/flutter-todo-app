import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/counter.dart';
import 'package:hello_flutter/pages/form.dart';
import 'package:hello_flutter/pages/listScreen.dart';
import 'package:hello_flutter/pages/todo.dart';
import 'package:hello_flutter/providers/todo_provider.dart';
import 'package:provider/provider.dart';

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
    final count = context.watch<TodoProvider>().todos.length;
    return Scaffold(
      appBar: AppBar(title: const Text("🏠 Home"), centerTitle: true),

      // body: Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text("Total Todos: $count"),
      //       TextField(
      //         controller: _nameController,
      //         decoration: const InputDecoration(
      //           labelText: "Enter your name",
      //           border: OutlineInputBorder(),
      //         ),
      //       ),
      //       const SizedBox(height: 20),
      //       ElevatedButton(
      //         child: const Text("Go to Counter"),
      //         onPressed: () {
      //           final name = _nameController.text;
      //           // 🔹 Pass "name" to CounterScreen
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => CounterScreen(username: name),
      //             ),
      //           );
      //         },
      //       ),
      //       const SizedBox(height: 20),
      //       ElevatedButton(
      //         child: const Text("Go to Form"),
      //         onPressed: () {
      //           final name = _nameController.text;
      //           // 🔹 Pass "name" to CounterScreen
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => FormScreen()),
      //           );
      //         },
      //       ),
      //       const SizedBox(height: 20),
      //       ElevatedButton(
      //         child: const Text("Go to Static List"),
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => const ListScreen()),
      //           );
      //         },
      //       ),
      //       const SizedBox(height: 20),
      //       ElevatedButton(
      //         child: const Text("Go to Todo App"),
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => const TodoScreen()),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          // ✅ prevent overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "Welcome Back 👋",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                "You have $count todos",
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 20),

              // Input
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Enter your name"),
              ),

              const SizedBox(height: 30),

              // Card with navigation buttons
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      buildNavButton(
                        context,
                        "Go to Counter",
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CounterScreen(username: _nameController.text),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      buildNavButton(
                        context,
                        "Go to Form",
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FormScreen(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      buildNavButton(
                        context,
                        "Go to Static List",
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListScreen(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      buildNavButton(
                        context,
                        "Go to Todo App",
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TodoScreen(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🔹 Helper button
Widget buildNavButton(BuildContext context, String text, VoidCallback onTap) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(onPressed: onTap, child: Text(text)),
  );
}
