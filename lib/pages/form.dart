import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/counter.dart';

// 🟢 Screen 2: Form
class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // 🔹 GlobalKey to manage form state
  final _formKey = GlobalKey<FormState>();

  // 🔹 Controllers for inputs
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final age = int.parse(_ageController.text);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CounterScreen(username: name)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Example")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey, // connect form to global key
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your age";
                  }
                  if (int.tryParse(value) == null) {
                    return "Age must be a number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
