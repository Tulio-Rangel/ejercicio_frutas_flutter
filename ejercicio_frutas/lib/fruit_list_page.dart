import 'package:flutter/material.dart';
import 'package:ejercicio_frutas/fruit_model.dart';
import 'package:ejercicio_frutas/add_edit_fruit_page.dart';
import 'package:ejercicio_frutas/fruit_dao.dart';

class FruitListPage extends StatefulWidget {
  const FruitListPage({super.key});

  @override
  _FruitListPageState createState() => _FruitListPageState();
}

class _FruitListPageState extends State<FruitListPage> {
  final fruitDao = FruitDao();
  List<Fruit> _fruits = [];

  @override
  void initState() {
    super.initState();
    _loadFruits();
  }

  Future<void> _loadFruits() async {
    final fruits = await fruitDao.getAllFruits();
    setState(() {
      _fruits = fruits;
    });
  }

  Future<void> _addFruit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddEditFruitPage(fruit: Fruit(id: 0, name: '', description: '')),
      ),
    );

    if (result != null) {
      await fruitDao.insertFruit(result);
      await _loadFruits();
    }
  }

  Future<void> _editFruit(Fruit fruit) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditFruitPage(fruit: fruit),
      ),
    );

    if (result != null) {
      await fruitDao.updateFruit(result);
      await _loadFruits();
    }
  }

  Future<void> _deleteFruit(int id) async {
    await fruitDao.deleteFruit(id);
    await _loadFruits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruit List'),
      ),
      body: ListView.builder(
        itemCount: _fruits.length,
        itemBuilder: (context, index) {
          final fruit = _fruits[index];
          return ListTile(
            title: Text(fruit.name),
            subtitle: Text(fruit.description),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteFruit(fruit.id),
            ),
            onTap: () => _editFruit(fruit),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFruit,
        child: const Icon(Icons.add),
      ),
    );
  }
}
