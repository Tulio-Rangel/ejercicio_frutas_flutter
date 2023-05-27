class Fruit {
  int id;
  String name;
  String description;

  Fruit({required this.id, required this.name, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
