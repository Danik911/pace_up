import 'dart:math';

import 'package:hive_flutter/adapters.dart';
import 'package:pace_up/data/source/local/models/item.dart';

import '../../../domain/entities/cart_item.dart';
import '../../../domain/entities/item.dart';

class LocalDataSource {

  List<CartItem> cart = [];

 //Cart for testing
 /* final List<CartItem> cartForTesting =[
    CartItem(
      id: "1",
      quantity: 1,
     item: Item(
          id: "1",
          name: "test9",
          description: "some dummy text",
          image: 'assets/images/9.jpg',
          cost: "34"
      )
    ),
    CartItem(
        id: "2",
        quantity: 1,
        item: Item(
            id: "2",
            name: "test9",
            description: "some dummy text",
            image: 'assets/images/9.jpg',
            cost: "34"
        )
    ),
    CartItem(
        id: "3",
        quantity: 1,
        item: Item(
            id: "3",
            name: "test9",
            description: "some dummy text",
            image: 'assets/images/9.jpg',
            cost: "34"
        )
    ),
    CartItem(
        id: "4",
        quantity: 1,
        item: Item(
            id: "4",
            name: "test9",
            description: "some dummy text",
            image: 'assets/images/9.jpg',
            cost: "34"
        )
    ),
    CartItem(
        id: "5",
        quantity: 1,
        item: Item(
            id: "5",
            name: "test9",
            description: "some dummy text",
            image: 'assets/images/9.jpg',
            cost: "34"
        )
    ),
    CartItem(
        id: "6",
        quantity: 1,
        item: Item(
            id: "6",
            name: "test9",
            description: "some dummy text",
            image: 'assets/images/9.jpg',
            cost: "34"
        )
    ),
    CartItem(
        id: "7",
        quantity: 1,
        item: Item(
            id: "7",
            name: "test9",
            description: "some dummy text",
            image: 'assets/images/9.jpg',
            cost: "34"
        )
    ),
    CartItem(
        id: "8",
        quantity: 1,
        item: Item(
            id: "8",
            name: "test9",
            description: "some dummy text",
            image: 'assets/images/9.jpg',
            cost: "34"
        )
    ),
    CartItem(
        id: "9",
        quantity: 1,
        item: Item(
            id: "9",
            name: "test9",
            description: "some dummy text",
            image: 'assets/images/9.jpg',
            cost: "34"
        )
    ),
    CartItem(
        id: "10",
        quantity: 1,
        item: Item(
            id: "10",
            name: "test9",
            description: "some dummy text",
            image: 'assets/images/9.jpg',
            cost: "34"
        )
    ),
    CartItem(
        id: "11",
        quantity: 1,
        item: Item(
            id: "11",
            name: "test9",
            description: "some dummy text",
            image: 'assets/images/9.jpg',
            cost: "34"
        )
    ),
  ];*/

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

    final itemsMap = {for (var e in items) e.id: e};
    await itemBox.clear();
    await itemBox.putAll(itemsMap);
  }

  Future<ItemHiveModel?> getItem(String itemId) async {
    final itemBox = Hive.box<ItemHiveModel>(ItemHiveModel.boxKey);

    return itemBox.get(itemId);
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

  List<CartItem> getAllCartItems() {
    return cart;
  }

  void addCartItem(CartItem cartItem) {
    cart.add(cartItem);
  }

  void deleteCartItem(String? cartItemId) {
    cart.removeWhere((element) => element.id == cartItemId);
  }

  CartItem? getCartItem(String? cartItemId) {
    return cart.firstWhere((element) => element.id == cartItemId);
  }

  /*final listOfItemsForTesting = [
    Item(
        id: "9",
        name: "test9",
        description: "some dummy text",
        image: 'assets/images/9.jpg',
        cost: "34"
    ),
    Item(
        id: "2",
        name: "test2",
        description: "some dummy text",
        image: 'assets/images/2.jpg',
        cost: "34"

    ),
    Item(
        id: "3",
        name: "test3",
        description: "some dummy text",
        image: 'assets/images/3.jpg',
        cost: "34"),
    Item(
        id: "4",
        name: "test4",
        description: "some dummy text",
        image: 'assets/images/4.jpg',
        cost: "34"),
    Item(
        id: "6",
        name: "test6",
        description: "some dummy text",
        image: 'assets/images/6.jpg',
        cost: "34"),
    Item(
        id: "7",
        name: "test7",
        description: "some dummy text",
        image: 'assets/images/7.jpg',
        cost: "34"),
    Item(
        id: "8",
        name: "test6",
        description: "some dummy text",
        image: 'assets/images/8.jpg',
        cost: "34"),
    Item(
        id: "10",
        name: "test10",
        description: "some dummy text",
        image: 'assets/images/10.jpg',
        cost: "34"),
  ];*/

  List<CartItem> itemsToCartItems(List<Item> items){
    return items.map((e) => e.toCartItem()).toList();

  }
}
