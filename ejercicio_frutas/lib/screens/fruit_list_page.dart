import 'package:flutter/material.dart';
import 'package:ejercicio_frutas/models/fruit_model.dart';
import 'package:ejercicio_frutas/screens/add_edit_fruit_page.dart';
import 'package:ejercicio_frutas/db/fruit_dao.dart';

class FruitListPage extends StatefulWidget {
  const FruitListPage({super.key});

  @override
  _FruitListPageState createState() => _FruitListPageState();
}

class _FruitListPageState extends State<FruitListPage> {
  final fruitDao = FruitDao();
  final List<Fruit> _fruits = [];
  int _fruitIdCounter = 1;

  @override
  void initState() {
    super.initState();
    _loadFruits();
  }

  Future<void> _loadFruits() async {
    final fruits = await fruitDao.getAllFruits();
    setState(() {
      _fruits.addAll(fruits);
    });
  }

  Future<void> _addFruit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditFruitPage(
            fruit: Fruit(id: _fruitIdCounter, name: '', description: '')),
      ),
    );

    if (result != null) {
      await fruitDao.insertFruit(result);
      setState(() {
        _fruits.add(result);
        _fruitIdCounter++;
      });
    }
  }

  Future<void> _editFruit(Fruit fruit) async {
    final index = _fruits.indexOf(fruit);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditFruitPage(fruit: fruit),
      ),
    );

    if (result != null) {
      await fruitDao.updateFruit(result);
      setState(() {
        _fruits[index] = result;
      });
    }
  }

  Future<void> _deleteFruit(int id) async {
    await fruitDao.deleteFruit(id);
    setState(() {
      _fruits.removeWhere((fruit) => fruit.id == id);
    });
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
