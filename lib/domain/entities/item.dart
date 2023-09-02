import 'package:hive/hive.dart';


class Item {
  const Item({
    required this.number,
    required this.name,
    required this.description,
    required this.image,

  });

  final String number;
  final String name;
  final String description;
  final String image;

}