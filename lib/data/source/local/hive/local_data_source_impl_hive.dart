import 'dart:math';

import 'package:hive_flutter/adapters.dart';
import 'package:pace_up/data/source/mappers/db_model_to_entity.dart';
import '../../../../domain/entities/item.dart';
import '../local_data_source.dart';
import 'models/item.dart';

class LocalDataSourceImplHive extends LocalDataSource {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter<ItemHiveModel>(ItemHiveModelAdapter());

    await Hive.openBox<ItemHiveModel>(ItemHiveModel.boxKey);
  }

  @override
  Future<bool> hasData() async {
    final itemBox = Hive.box<ItemHiveModel>(ItemHiveModel.boxKey);

    return itemBox.length > 0;
  }

  @override
  Future<void> saveItems(Iterable<Item> items) async {
    final itemBox = Hive.box<ItemHiveModel>(ItemHiveModel.boxKey);
    final itemHiveModel = items.map((e) => e.toHiveModel());
    final itemsMap = {for (var e in itemHiveModel) e.id: e};
    await itemBox.clear();
    await itemBox.putAll(itemsMap);
  }

  @override
  Future<Item?> getItem(String itemId) async {
    final itemBox = Hive.box<ItemHiveModel>(ItemHiveModel.boxKey);
    final itemHiveModel = itemBox.get(itemId);
    return itemHiveModel?.toEntity();
  }

  @override
  Future<List<Item>> getAllItems() async {
    final itemBox = Hive.box<ItemHiveModel>(ItemHiveModel.boxKey);
    final itemsHiveModel = List.generate(itemBox.length, (index) => itemBox.getAt(index))
        .whereType<ItemHiveModel>()
        .toList();
    final items = itemsHiveModel.map((e) => e.toEntity()).toList();
    return items;
  }

  @override
  Future<List<Item>> getItemsByPage(
      {required int page, required int limit}) async {
    final itemBox = Hive.box<ItemHiveModel>(ItemHiveModel.boxKey);
    final totalItems = itemBox.length;

    final start = (page - 1) * limit;
    final newItemCount = min(totalItems - start, limit);

    final itemsHiveModel =
        List.generate(newItemCount, (index) => itemBox.getAt(start + index))
            .whereType<ItemHiveModel>()
            .toList();
    final items = itemsHiveModel.map((e) => e.toEntity()).toList();

    return items;
  }
}
