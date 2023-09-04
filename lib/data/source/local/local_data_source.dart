
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pace_up/data/source/local/models/item.dart';
import 'package:pace_up/domain/entities/item.dart';

import '../../../configs/images.dart';

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

  Future<List<ItemHiveModel>> getItemsByPage({required int page, required int limit}) async {
    final itemBox = Hive.box<ItemHiveModel>(ItemHiveModel.boxKey);
    final totalItems = itemBox.length;

    final start = (page - 1) * limit;
    final newItemCount = min(totalItems - start, limit);

    final items = List.generate(newItemCount, (index) => itemBox.getAt(start + index))
        .whereType<ItemHiveModel>()
        .toList();

    return items;
  }

  final listOfItemsForTesting = [
    Item(
      number: "1",
      name: "test",
      description: "some dummy text",
      image: 'assets/images/litten.png'
    ),
  Item(
      number: "1",
      name: "test",
      description: "some dummy text",
      image: 'assets/images/1.jpg'
    ),
  Item(
      number: "1",
      name: "test",
      description: "some dummy text",
      image: 'assets/images/1.jpg'
    ),
  Item(
      number: "1",
      name: "test",
      description: "some dummy text",
      image: 'assets/images/1.jpg'
    ),
  Item(
      number: "1",
      name: "test",
      description: "some dummy text",
      image: 'assets/images/1.jpg'
    ),
  Item(
      number: "1",
      name: "test",
      description: "some dummy text",
      image: 'assets/images/1.jpg'
    ),

  ];

}