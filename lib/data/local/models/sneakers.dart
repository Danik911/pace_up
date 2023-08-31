import 'package:hive/hive.dart';
part 'sneakers.g.dart';

@HiveType(typeId: 0)
class Sneakers extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String size;



  Sneakers(
      {required this.title, required this.description, required this.size});
}
