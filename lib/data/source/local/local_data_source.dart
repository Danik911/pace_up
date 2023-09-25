import 'package:pace_up/domain/entities/item.dart';

abstract class LocalDataSource {
  Future<bool> hasData();
  Future<void> saveItems(Iterable<Item> items);
  Future<Item?> getItem(String itemId);
  Future<List<Item>> getAllItems();
  Future<List<Item>> getItemsByPage({required int page, required int limit});
}
