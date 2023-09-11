import 'dart:math';

import 'package:hive_flutter/adapters.dart';
import 'package:pace_up/data/source/local/models/item.dart';

class LocalDataSource {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter<ItemHiveModel>(ItemHiveModelAdapter());

    await Hive.openBox<ItemHiveModel>(ItemHiveModel.boxKey);
  }

  Future<bool> hasData() async {
    final itemBox = Hive.box<ItemHiveModel>(ItemHiveModel.boxKey);

    return itemBox.length > 0;
  }

  Future<void> saveItems(Iterable<ItemHiveModel> items) async {
    final itemBox = Hive.box<ItemHiveModel>(ItemHiveModel.boxKey);

    final itemsMap = {for (var e in items) e.name: e};
    await itemBox.clear();
    await itemBox.putAll(itemsMap);
  }

  Future<ItemHiveModel?> getItem(String number) async {
    final itemBox = Hive.box<ItemHiveModel>(ItemHiveModel.boxKey);

    return itemBox.get(number);
  }

  Future<List<ItemHiveModel>> getAllItems() async {
    final itemBox = Hive.box<ItemHiveModel>(ItemHiveModel.boxKey);

    final items = List.generate(itemBox.length, (index) => itemBox.getAt(index))
        .whereType<ItemHiveModel>()
        .toList();

    return items;
  }

  Future<List<ItemHiveModel>> getItemsByPage(
      {required int page, required int limit}) async {
    final itemBox = Hive.box<ItemHiveModel>(ItemHiveModel.boxKey);
    final totalItems = itemBox.length;

    final start = (page - 1) * limit;
    final newItemCount = min(totalItems - start, limit);

    final items =
        List.generate(newItemCount, (index) => itemBox.getAt(start + index))
            .whereType<ItemHiveModel>()
            .toList();

    return items;
  }

/*  final listOfItemsForTesting = [
    Item(
        id: "9",
        name: "test9",
        description: "some dummy text",
        image: 'assets/images/9.jpg',
        size: ''
    ),
    Item(
        id: "2",
        name: "test2",
        description: "some dummy text",
        image: 'assets/images/2.jpg'),
    Item(
        id: "3",
        name: "test3",
        description: "some dummy text",
        image: 'assets/images/3.jpg'),
    Item(
        id: "4",
        name: "test4",
        description: "some dummy text",
        image: 'assets/images/4.jpg'),
    Item(
        id: "6",
        name: "test6",
        description: "some dummy text",
        image: 'assets/images/6.jpg'),
    Item(
        id: "7",
        name: "test7",
        description: "some dummy text",
        image: 'assets/images/7.jpg'),
    Item(
        id: "8",
        name: "test6",
        description: "some dummy text",
        image: 'assets/images/8.jpg'),
    Item(
        id: "10",
        name: "test10",
        description: "some dummy text",
        image: 'assets/images/10.jpg'),
  ]*/
}
