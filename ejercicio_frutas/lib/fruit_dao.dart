import 'package:sqflite/sqflite.dart';
import 'package:ejercicio_frutas/fruit_model.dart';
import 'package:ejercicio_frutas/database_helper.dart';

class FruitDao {
  final dbHelper = DatabaseHelper();

  Future<List<Fruit>> getAllFruits() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('fruits');
    return List.generate(
      maps.length,
      (index) {
        return Fruit(
          id: maps[index]['id'],
          name: maps[index]['name'],
          description: maps[index]['description'],
        );
      },
    );
  }

  Future<void> insertFruit(Fruit fruit) async {
    final db = await dbHelper.database;
    await db.insert(
      'fruits',
      fruit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateFruit(Fruit fruit) async {
    final db = await dbHelper.database;
    await db.update(
      'fruits',
      fruit.toMap(),
      where: 'id = ?',
      whereArgs: [fruit.id],
    );
  }

  Future<void> deleteFruit(int id) async {
    final db = await dbHelper.database;
    await db.delete(
      'fruits',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
