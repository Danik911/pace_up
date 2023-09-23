
import 'dart:convert';

class ItemSqModel {

  const ItemSqModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.size

  });

  final String id;
  final String name;
  final String description;
  final String image;
  final String size;

  // Convert a Item into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'size': size,
    };
  }


  factory ItemSqModel.fromMap(Map<String, dynamic> map) {
    return ItemSqModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? "",
      image: map['image'],
      size: map['size'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemSqModel.fromJson(String source) => ItemSqModel.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog(id: $id, name: $name, description: $description, image: $image, size: $size)';
  }
}