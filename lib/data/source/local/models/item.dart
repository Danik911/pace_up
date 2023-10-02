
import 'package:hive/hive.dart';


part 'item.g.dart';

@HiveType(typeId: 1)
class ItemHiveModel extends HiveObject {
  static const String boxKey = 'item';

  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late String image;

  @HiveField(4)
  late String cost;

}