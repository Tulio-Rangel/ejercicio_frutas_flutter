import 'package:flutter/material.dart';
import 'package:ejercicio_frutas/fruit_model.dart';

class AddEditFruitPage extends StatefulWidget {
  final Fruit fruit;

  const AddEditFruitPage({super.key, required this.fruit});

  @override
  _AddEditFruitPageState createState() => _AddEditFruitPageState();
}

class _AddEditFruitPageState extends State<AddEditFruitPage> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.fruit.name);
    _descriptionController =
        TextEditingController(text: widget.fruit.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveFruit() {
    final name = _nameController.text;
    final description = _descriptionController.text;
    final fruit = Fruit(
      name: name,
      description: description,
      id: 0,
    );

    Navigator.pop(context, fruit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fruit != null ? 'Edit Fruit' : 'Add Fruit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveFruit,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}